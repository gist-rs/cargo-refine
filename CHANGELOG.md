# Changelog

Release notes for each version are on the
[releases page](https://github.com/gist-rs/cargo-refine/releases). This file keeps the
version-specific caveats that used to live in the README.

## Unreleased

- `cargo refine --help` (and `-h`) prints a short page of everyday commands and
  exits 0. `--help-all` prints every flag. Before, `--help` was rejected as an
  unknown flag.
- `--suggest --domain` lists and accepts only the rule domains your build
  carries. Before, it advertised security and GPU-kernel domains that the
  release binary then refused.
- `--unmine` and `--purge` now clear the mining sync watermark. Before, they
  removed a file name that was never written.
- `cargo refine --mine` now states exactly what a mining record carries,
  including the code snippet each fix touched.

## v0.2.0 — 2026-10-01

- **Renamed to Refine.** The binary is `cargo-refine` (run as `cargo refine`),
  and release assets are named `cargo-refine-*`.
- Per-project state moved from `.heal/` to `.refine/`, and the sync policy file
  from `.heal-sync-policy` to `.refine-sync-policy`. There are no compatibility
  aliases. The account key in `~/.config/riir-auth/` is untouched.
- The service URL variable is `RIIR_REFINE_KAT_SERVICE_URL`. The old
  `RIIR_HEAL_KAT_SERVICE_URL` is still read as a fallback. The default service
  is `https://ai.gist.rs`.
- The installers still install releases up to v0.1.4, which ship a binary named
  `cargo-heal`.

## v0.1.4 — 2026-09-09

- Defaults to `https://ai.gist.rs`. If the default host cannot be reached, the
  client retries the paired known host once and keeps using it.
- Added `--version` and `--yes`. `--yes` gives non-interactive consent for
  agents and CI.
- `--mine` writes the default sync policy when none exists.
- `--fix` is compile-checked in the shipped binary.

## v0.1.2 and v0.1.3 — 2026-09-08

- **Caveat:** these binaries default the service to `heal.gist.rs`, which never
  went public. To use them, set
  `RIIR_HEAL_KAT_SERVICE_URL=https://ai.gist.rs`. Better, upgrade.
- v0.1.2 introduced the current command shape: bare `cargo heal` is a dry run,
  `--fix` writes, and `--mine` explains and opts in to mining. `login`,
  `update` and `sync` ship in the binary.

## v0.1.0 and v0.1.1 — 2026-09-07

- **Caveat:** these binaries default to the retired `kat.heal.gist.rs`. Upgrade.
