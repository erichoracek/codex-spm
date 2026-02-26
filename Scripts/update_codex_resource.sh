#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
version_file="${repo_root}/CODEX_VERSION"
codex_resource_dir="${repo_root}/Sources/CodexBinary/Resources"
zsh_resource_dir="${repo_root}/Sources/CodexZshBinary/Resources"
codex_tmp_tar="${codex_resource_dir}/codex.tar.gz"
zsh_tmp_tar="${zsh_resource_dir}/codex-shell-tool-mcp.tgz"
zsh_tmp_extract_dir="${zsh_resource_dir}/codex-shell-tool-mcp"
zsh_archive_path="package/vendor/aarch64-apple-darwin/zsh/macos-15/zsh"
include_zsh=0

usage() {
  cat <<'EOF'
Usage: Scripts/update_codex_resource.sh [--include-zsh]

  --include-zsh   Download and refresh the bundled zsh.

By default, this script only refreshes the codex binary. The bundled zsh is
skipped unless --include-zsh is provided because shipped zsh binaries must be
signed before release use.
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
  --include-zsh)
    include_zsh=1
    shift
    ;;
  -h | --help)
    usage
    exit 0
    ;;
  *)
    echo "Unknown argument: $1" >&2
    usage >&2
    exit 1
    ;;
  esac
done

download_file() {
  local url="$1"
  local output_path="$2"

  if command -v curl >/dev/null 2>&1; then
    curl -fL "${url}" -o "${output_path}"
  elif command -v wget >/dev/null 2>&1; then
    wget -O "${output_path}" "${url}"
  else
    echo "Missing curl or wget to download ${url}" >&2
    exit 1
  fi
}

if [[ ! -f "${version_file}" ]]; then
  echo "Missing CODEX_VERSION at ${version_file}" >&2
  exit 1
fi

version="$(tr -d '[:space:]' < "${version_file}")"
if [[ -z "${version}" ]]; then
  echo "CODEX_VERSION is empty" >&2
  exit 1
fi

if [[ "${version}" != rust-v* ]]; then
  echo "Expected CODEX_VERSION to start with rust-v, found ${version}" >&2
  exit 1
fi

package_version="${version#rust-v}"
codex_url="https://github.com/openai/codex/releases/download/${version}/codex-aarch64-apple-darwin.tar.gz"
zsh_url="https://github.com/openai/codex/releases/download/${version}/codex-shell-tool-mcp-npm-${package_version}.tgz"

mkdir -p "${codex_resource_dir}" "${zsh_resource_dir}"
rm -rf "${codex_resource_dir}/codex"
rm -f \
  "${codex_tmp_tar}" \
  "${codex_resource_dir}/codex-aarch64-apple-darwin"

download_file "${codex_url}" "${codex_tmp_tar}"

tar -xzf "${codex_tmp_tar}" -C "${codex_resource_dir}"

if [[ "${include_zsh}" == "1" ]]; then
  rm -rf "${zsh_tmp_extract_dir}"
  rm -f "${zsh_tmp_tar}" "${zsh_resource_dir}/zsh"

  download_file "${zsh_url}" "${zsh_tmp_tar}"
  mkdir -p "${zsh_tmp_extract_dir}"
  tar -xzf "${zsh_tmp_tar}" -C "${zsh_tmp_extract_dir}" "${zsh_archive_path}"
  cp "${zsh_tmp_extract_dir}/${zsh_archive_path}" "${zsh_resource_dir}/zsh"
  chmod 755 "${zsh_resource_dir}/zsh"
  rm -rf "${zsh_tmp_extract_dir}"
  rm -f "${zsh_tmp_tar}"
else
  echo "Warning: skipping bundled zsh refresh; pass --include-zsh to download it. Bundled zsh must still be signed before shipping." >&2
fi

rm -f "${codex_tmp_tar}"

echo "Downloaded ${codex_url}"
echo "Extracted to ${codex_resource_dir}"
if [[ "${include_zsh}" == "1" ]]; then
  echo "Downloaded ${zsh_url}"
  echo "Extracted ${zsh_archive_path}"
  echo "Updated ${zsh_resource_dir}/zsh"
  echo "Warning: bundled zsh is not signed by this script; sign it before shipping." >&2
fi
