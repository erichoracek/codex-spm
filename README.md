# CodexBinary

Swift Package that bundles the Codex binary as a resource and exposes a stable path to it.

## Usage

```swift
import CodexBinary

let url = CodexResource.binaryURL
```

```swift
import CodexZshBinary

let zshURL = CodexZshResource.binaryURL
```

## Update the bundled Codex binary

1. Update the version string in `CODEX_VERSION` (e.g. `rust-v0.86.0-alpha.1`).
2. Run:

```sh
Scripts/update_codex_resource.sh
```

This downloads both release artifacts from the matching Codex GitHub release:
- `codex-aarch64-apple-darwin.tar.gz`
- `codex-shell-tool-mcp-npm-<version>.tgz`

It refreshes:
- `Sources/CodexBinary/Resources/codex-aarch64-apple-darwin`
- `Sources/CodexZshBinary/Resources/zsh`

## Notes

- The current updater downloads the Apple Silicon Codex CLI artifact plus the
  packaged Apple Silicon macOS 15 `zsh` binary.
- If you need other platforms or architectures, we can make the script configurable.
