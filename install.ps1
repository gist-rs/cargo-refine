# cargo-refine installer (binary-only distribution).
# Usage: iwr -useb https://raw.githubusercontent.com/gist-rs/cargo-refine/main/install.ps1 | iex
# Pin a version: & ([scriptblock]::Create((iwr -useb https://raw.githubusercontent.com/gist-rs/cargo-refine/main/install.ps1))) -Version v0.1.3
param([string]$Version = "")

$ErrorActionPreference = "Stop"

# PS 5.1 leaves TLS 1.2 unset by default and GitHub refuses the older protocols -
# enable it before the first call (no-op where it is already on, e.g. PS 7+).
[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12

$Repo = "gist-rs/cargo-refine"
$Dest = Join-Path $env:USERPROFILE ".cargo\bin"

if ($env:PROCESSOR_ARCHITECTURE -ne "AMD64") {
    throw "unsupported architecture: $env:PROCESSOR_ARCHITECTURE (only x86_64 windows binaries ship)"
}

if ($Version) {
    $release = Invoke-RestMethod "https://api.github.com/repos/$Repo/releases/tags/$Version"
} else {
    $release = Invoke-RestMethod "https://api.github.com/repos/$Repo/releases/latest"
}
$tag = $release.tag_name
if (-not $tag) { throw "cannot resolve the release (none published yet?)" }

# Windows assets ship as msvc on some releases and gnu on others - accept either, prefer msvc.
# Pre-rename releases (<= v0.1.4) carry cargo-heal-* assets with cargo-heal.exe
# inside - fall back to that spelling, and install the binary the archive
# actually contains.
$assetNames = @($release.assets | ForEach-Object { $_.name })
$asset = $null
$flavor = ""
$bin = "cargo-refine"
foreach ($name in @("cargo-refine", "cargo-heal")) {
    foreach ($f in @("msvc", "gnu")) {
        $asset = $assetNames | Where-Object { $_ -match ("^" + $name + "-" + [regex]::Escape($tag) + "-x86_64-pc-windows-$f\.zip$") } | Select-Object -First 1
        if ($asset) { $flavor = $f; if ($name -eq "cargo-heal") { $bin = "cargo-heal"; Write-Host "note: $tag predates the rename - installing the cargo-heal binary" }; break }
    }
    if ($asset) { break }
}
if (-not $asset) {
    $assetList = if ($assetNames.Count) { $assetNames -join ', ' } else { "(none)" }
    throw "no (cargo-refine|cargo-heal)-$tag-x86_64-pc-windows-(msvc|gnu).zip asset in release $tag. assets in this release: $assetList"
}

$base = "https://github.com/$Repo/releases/download/$tag"

$tmp = Join-Path ([System.IO.Path]::GetTempPath()) ("cargo-refine-" + [guid]::NewGuid().ToString("N"))
New-Item -ItemType Directory -Path $tmp | Out-Null
try {
    Write-Host "fetching $asset ..."
    Invoke-WebRequest -UseBasicParsing "$base/$asset" -OutFile "$tmp\$asset"
    Invoke-WebRequest -UseBasicParsing "$base/SHA256SUMS" -OutFile "$tmp\SHA256SUMS"

    $line = Select-String -Path "$tmp\SHA256SUMS" -Pattern ([regex]::Escape($asset)) | Select-Object -First 1
    if (-not $line) { throw "$asset not listed in SHA256SUMS" }
    $want = ($line.Line -split '\s+')[0]
    $got = (Get-FileHash -Algorithm SHA256 "$tmp\$asset").Hash.ToLower()
    if ($got -ne $want) { throw "checksum mismatch for $asset (want $want, got $got) - aborting" }

    Expand-Archive -Path "$tmp\$asset" -DestinationPath $tmp -Force
    New-Item -ItemType Directory -Force -Path $Dest | Out-Null
    Move-Item -Force (Join-Path $tmp "$bin.exe") (Join-Path $Dest "$bin.exe")
    Write-Host "installed $bin $tag (x86_64-pc-windows-$flavor) -> $Dest\$bin.exe"
    if (($env:Path -split ';') -notcontains $Dest) {
        Write-Host "note: $Dest is not on your PATH - add it to use 'cargo $bin'"
    }
}
finally {
    Remove-Item -Recurse -Force $tmp -ErrorAction SilentlyContinue
}
