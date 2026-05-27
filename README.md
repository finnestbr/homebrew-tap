# Finnest Homebrew tap

Official [Homebrew](https://brew.sh) tap for the [Finnest CLI](https://github.com/finnestbr/finnest-power).

## Install

```sh
brew tap finnestbr/tap
brew install finnest
```

Or in one line:

```sh
brew install finnestbr/tap/finnest
```

## Upgrade

```sh
brew update
brew upgrade finnest
```

## Uninstall

```sh
brew uninstall finnest
brew untap finnestbr/tap
```

## What's inside

The `Formula/` directory holds the Homebrew formula(e) describing how to install
the published Finnest CLI binaries from
[github.com/finnestbr/finnest-power releases](https://github.com/finnestbr/finnest-power/releases).

Formulae are updated automatically by the upstream repo's
[`publish.yml`](https://github.com/finnestbr/finnest-power/blob/main/.github/workflows/publish.yml)
workflow on every `cli-v*` tag. Direct edits to this repo's `Formula/` directory
are not expected.

## Alternative installs

If you prefer not to use Homebrew, the CLI is also installable via:

- **Shell installer**: `curl -fsSL https://github.com/finnestbr/finnest-power/releases/latest/download/install.sh | sh`
- **Direct download**: pre-built binaries on the
  [releases page](https://github.com/finnestbr/finnest-power/releases?q=cli-v) for
  darwin-arm64, darwin-x64, linux-amd64, linux-arm64, and windows-amd64.

All published binaries are cosign-signed with keyless OIDC and ship a CycloneDX
SBOM + SLSA v1 provenance attestation.

## License

This tap repository is MIT-licensed (see [`LICENSE`](./LICENSE)). The Finnest
CLI binaries it points at are governed by the license declared in the upstream
[finnest-power](https://github.com/finnestbr/finnest-power) repository.
