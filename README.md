# cargo-refine

**Refine — the code fixer that learns.** Point it at a Rust crate and keep the
mechanical fixes. No AI model and no prompts: the fixes come from a compiled,
human-written rule set, and a fix is kept only if your code still compiles.

Home: <https://refine.gist.rs> · Releases: <https://github.com/gist-rs/cargo-refine/releases> ·
Changes: [CHANGELOG.md](CHANGELOG.md)

## Install

macOS / Linux:

```sh
curl -fsSL https://raw.githubusercontent.com/gist-rs/cargo-refine/main/install.sh | sh
```

Windows (PowerShell):

```powershell
iwr -useb https://raw.githubusercontent.com/gist-rs/cargo-refine/main/install.ps1 | iex
```

Homebrew (prebuilt formula — nothing is compiled):

```sh
brew tap gist-rs/tap && brew trust gist-rs/tap && brew install cargo-refine
```

Scoop:

```powershell
scoop bucket add gist-rs https://github.com/gist-rs/scoop-bucket
scoop install cargo-refine
```

The installers put `cargo-refine` in `~/.cargo/bin` (Windows: `%USERPROFILE%\.cargo\bin`),
so `cargo refine` works in any Rust project. They pick the latest release (pin one with
`CARGO_REFINE_VERSION=v0.2.0` for install.sh or `-Version v0.2.0` for install.ps1), choose
the right Windows build, and check every download against the release's `SHA256SUMS`
before unpacking it.

## Use

Inside a Rust crate:

```sh
cargo refine            # dry run: list what it would fix, change nothing
cargo refine --fix      # apply the fixes (Rust fixes are compile-checked; see below)
cargo refine --help     # the everyday commands; --help-all lists every flag
```

- **`cargo refine`** with no flags is a dry run: it reads the current directory
  (or the paths you name) and writes nothing.
- **`--fix` writes.** On release builds every Rust fix is compile-checked: Refine runs
  `cargo check` and undoes any edit that breaks the build. `--no-verify` skips
  that check if you want speed over safety.
- **Formatting is kept.** A file that was already `rustfmt`-clean is re-formatted
  after the fix. A file with existing formatting drift is left alone, so the diff
  stays mechanical. `--no-fmt` turns this off.

## What it fixes

Counts are for the v0.2.0 release (2026-10-01). Run `cargo refine --version` to
see which features your build carries.

| Domain | Rules | What it does |
|---|---|---|
| Clippy lints (`clippy_lints`) | 100 rules, 81 with an automatic fix | fixes `cargo clippy` warnings: style, complexity, perf |
| Rust performance (`rust_perf`) | 168 rules, 11 with an automatic fix | flags and fixes allocation, cloning, loop shape, collection choice |
| Dockerfiles (`docker`) | 31 rules, 14 with an automatic fix | hadolint-style findings with bounded fixes; no registry calls |
| Release profiles (`dist`) | 6 rules, suggestions only | `Cargo.toml` build-config advice for shipped binaries |
| Compile errors (`rustc_errors`) | 12 repair strategies | `cargo refine --fix-compile`: borrow-check errors E0597, E0502, E0499 and E0505, plus E0614 |

Security, GPU-kernel and shader rules are in preview and **not in the release
binary**. `cargo refine --suggest --domain <name>` accepts only the domains your
build carries.

**What it is not:**

- **Not an AI model.** There are no trained weights and no prompt calls. The fixes
  come from a compiled, human-written rule set.
- **Not a formatter or a linter.** It works alongside `cargo clippy` and `rustfmt`
  and fixes what they report, mechanically.
- **Not a guesser.** It refuses anything it cannot prove safe. A warning without
  a safe mechanical fix is deliberately left for you.

## What leaves your machine

| You run | What is sent |
|---|---|
| any run | a check for a newer rule set: a download, it sends no code (skip it with `--no-update`) |
| logged out | nothing else; nothing is billed |
| logged in (`cargo refine login`) | each run's metered total, for billing |
| `--stats on` (opt-in, default off) | rule names and counts per fix run; never code, never paths |
| `--mine` (opt-in) | records of each fix: the rule, counters, and the code snippet the fix touched (see below) |

**Mining sends code snippets, and here is exactly which:** the span a fix replaced
and its replacement. Snippets come only from your own repo's `src/`, `tests/`,
`benches/` and `examples/` (set in `.refine-sync-policy`), are capped at 64 KiB,
and never include a whole file or a file path. Every snippet is scanned for
secrets (API keys, tokens, private keys, env values, high-entropy strings). A
snippet with **any** finding is dropped, not sent. Batches are signed with your
account key. `cargo refine --unmine` stops mining; fixing keeps working.

## Cost and KAT

Every run that reads your code, the dry run included, is metered on your machine
at 1 KAT per million code-word tokens.

- **Logged out:** the meter stays local. Nothing is reported or billed, and you
  earn nothing.
- **Logged in:** each run's metered total is reported and billed to your
  account. Free trial credit (TUNA, valid 30 days) is used first where the
  network funds it, then KAT. An emptied account that has never contributed is
  refused until you contribute (`--mine`) or top up.
- **KAT** is the network's service credit. It has **no cash value and no
  redemption right**. Miners are paid KAT at each weekly epoch settle, from
  the pool that KAT burns fund.

Check your position with `cargo refine --info`. The network's live numbers are at
<https://ai.gist.rs>.

```sh
cargo refine login     # one time: creates your account key
cargo refine --info    # account, contribution and local work in one view
cargo refine --mine    # what mining is, the policy, and how to opt in
```

`login` makes an Ed25519 key in OpenSSH format, or imports yours with
`cargo refine login --key <path>`. The CLI talks to `https://ai.gist.rs` by
default. `cargo refine config get` shows the active service, and
`cargo refine config set --url devnet` points it at the test network.

## Where it keeps files

| Path | What |
|---|---|
| `<your repo>/.refine/` | the local meter and charge ledger, the outbox, the rule-set cache and the fix history |
| `<your repo>/.refine-sync-policy` | which files mining may read; written only by `--mine` |
| `~/.config/riir-auth/` | your account key (`RIIR_AUTH_ACCOUNT_DIR` overrides it) |
| `~/.config/riir-heal/` | your mining consent and service-URL choice |

Turn the local meter off with `RIIR_REFINE_KAT_METER=0`.

## Verify a download

Every release carries a `SHA256SUMS` file, and the installers check it
automatically. To check by hand:

```sh
shasum -a 256 -c SHA256SUMS     # macOS
sha256sum -c SHA256SUMS         # Linux / Windows (Git Bash)
```

The binaries are not code-signed yet, so SmartScreen or Gatekeeper may ask on
first run.

## FAQ

**Why did it skip a warning my `cargo clippy` shows?**
Refine carries a fix only when the change is mechanical and checked. A rule with
no safe fix is left out on purpose: a wrong fix is worse than none.

**Can `--fix` break my code?**
On release builds every Rust fix is compile-checked, and any edit that breaks the
build is undone. Run plain `cargo refine` first to review what it would change.

**Why is `--fix` slower than the dry run?**
It re-runs the compiler to prove each fix still builds. `--no-verify` skips that.

**How do I update?**
`brew upgrade cargo-refine` or `scoop update cargo-refine`, or re-run the
installer.

**How do I uninstall?**
Delete `~/.cargo/bin/cargo-refine` (Windows: `%USERPROFILE%\.cargo\bin\cargo-refine.exe`).
If you logged in, also delete `~/.config/riir-auth/` and `~/.config/riir-heal/`,
plus any `.refine/` folders in your projects.

## Attribution

Every archive ships `THIRD_PARTY_LICENSES.md`, which lists every third-party crate
in the binary with its license text. It is generated at release time from the
exact feature set that ships.

## License

The `cargo-refine` binary is distributed under MIT OR Apache-2.0. This repository
publishes releases, installers and documentation only — no source.
