#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
version_file="${repo_root}/CODEX_VERSION"
resource_dir="${repo_root}/Sources/CodexBinary/Resources"
tmp_tar="${resource_dir}/codex.tar.gz"

if [[ ! -f "${version_file}" ]]; then
  echo "Missing CODEX_VERSION at ${version_file}" >&2
  exit 1
fi

version="$(tr -d '[:space:]' < "${version_file}")"
if [[ -z "${version}" ]]; then
  echo "CODEX_VERSION is empty" >&2
  exit 1
fi

url="https://github.com/openai/codex/releases/download/${version}/codex-aarch64-apple-darwin.tar.gz"

mkdir -p "${resource_dir}"
rm -rf "${resource_dir}/codex"
rm -f "${resource_dir}/codex-aarch64-apple-darwin"

if command -v curl >/dev/null 2>&1; then
  curl -fL "${url}" -o "${tmp_tar}"
elif command -v wget >/dev/null 2>&1; then
  wget -O "${tmp_tar}" "${url}"
else
  echo "Missing curl or wget to download ${url}" >&2
  exit 1
fi

tar -xzf "${tmp_tar}" -C "${resource_dir}"
rm -f "${tmp_tar}"

echo "Downloaded ${url}"
echo "Extracted to ${resource_dir}"
