# CodexBinary

Swift Package that bundles the Codex binary as a resource and exposes a stable path to it.

## Usage

```swift
import CodexBinary

let url = CodexResource.binaryURL
```

## Update the bundled binary

1. Update the version string in `CODEX_VERSION` (e.g. `rust-v0.86.0-alpha.1`).
2. Run:

```sh
Scripts/update_codex_resource.sh
```

This downloads the release artifact from GitHub and extracts it into
`Sources/CodexBinary/Resources` so it is packaged with the module.

## Notes

- The current script downloads the `codex-aarch64-apple-darwin` release artifact.
- If you need other platforms or architectures, we can make the script configurable.
