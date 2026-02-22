#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: update-formula.sh <version-tag> [--dry-run]

Examples:
  ./scripts/update-formula.sh v1.2.3
  ./scripts/update-formula.sh 1.2.3 --dry-run

Options:
  --dry-run      Show planned changes without writing files.
  --formula PATH Use an explicit Homebrew formula file path.
  --help         Show this help message.
EOF
}

log() {
  printf '[%s] %s\n' "$(date -u +"%Y-%m-%dT%H:%M:%SZ")" "$*"
}

if [[ $# -lt 1 ]]; then
  usage
  exit 1
fi

DRY_RUN=0
FORMULA_PATH=""

RELEASE_TAG=""
while [[ $# -gt 0 ]]; do
  case "${1}" in
    --dry-run)
      DRY_RUN=1
      shift
      ;;
    --formula)
      if [[ $# -lt 2 ]]; then
        echo "error: --formula requires a path" >&2
        exit 1
      fi
      FORMULA_PATH="$2"
      shift 2
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    --*)
      echo "error: unknown flag: ${1}" >&2
      usage
      exit 1
      ;;
    *)
      if [[ -z "$RELEASE_TAG" ]]; then
        RELEASE_TAG="$1"
      else
        echo "error: unexpected argument: ${1}" >&2
        usage
        exit 1
      fi
      shift
      ;;
  esac
done

if [[ -z "$RELEASE_TAG" ]]; then
  echo "error: version tag is required" >&2
  usage
  exit 1
fi

if [[ "$RELEASE_TAG" != v* ]]; then
  RELEASE_TAG="v${RELEASE_TAG}"
fi

RELEASE_VERSION="${RELEASE_TAG#v}"
if [[ ! "$RELEASE_VERSION" =~ ^[0-9]+(\.[0-9]+){0,2}(-[A-Za-z0-9.+-]+)?$ ]]; then
  echo "error: version tag looks invalid: ${RELEASE_TAG}" >&2
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
TARGET_REPO="${GITHUB_REPOSITORY:-TakeInterestInc/agent-guardian}"

if [[ -z "$FORMULA_PATH" ]]; then
  for candidate in \
    "$REPO_ROOT/Formula/guardclaw.rb" \
    "$REPO_ROOT/Formula/agent-guardian.rb" \
    "$REPO_ROOT/guardclaw.rb" \
    "$REPO_ROOT/Formula/agentguardclaw.rb"; do
    if [[ -f "$candidate" ]]; then
      FORMULA_PATH="$candidate"
      break
    fi
  done
fi

if [[ -z "$FORMULA_PATH" || ! -f "$FORMULA_PATH" ]]; then
  echo "error: formula file not found; pass --formula /path/to/Formula.rb" >&2
  exit 1
fi

log "Updating formula: ${FORMULA_PATH}"
log "Release tag: ${RELEASE_TAG}"
log "Release version: ${RELEASE_VERSION}"

python3 - "$FORMULA_PATH" "$RELEASE_VERSION" "$RELEASE_TAG" "$TARGET_REPO" "$DRY_RUN" <<'PY'
import re
import sys
import urllib.request

formula_path, release_version, release_tag, target_repo, dry_run = sys.argv[1:]
current_version = None


def get_checksum(url: str) -> str:
    import os, pathlib
    # If RELEASE_ASSET_DIR is set, read the .sha256 file from disk instead of
    # fetching via unauthenticated HTTP (needed when repo is private).
    asset_dir = os.environ.get("RELEASE_ASSET_DIR", "")
    if asset_dir:
        filename = url.split("/")[-1]          # e.g. guardclaw-darwin-arm64.sha256
        sha_file = pathlib.Path(asset_dir) / filename
        if sha_file.exists():
            checksum = sha_file.read_text().strip().split()[0]
            if re.fullmatch(r"[0-9a-fA-F]{64}", checksum):
                return checksum
        raise RuntimeError(f"sha256 file not found in RELEASE_ASSET_DIR: {sha_file}")
    with urllib.request.urlopen(url, timeout=30) as response:
        if response.status != 200:
            raise RuntimeError(f"failed checksum fetch ({response.status}) for {url}")
        payload = response.read().decode("utf-8").strip()
    checksum = payload.split()[0].strip()
    if not re.fullmatch(r"[0-9a-fA-F]{64}", checksum):
        raise RuntimeError(f"checksum for {url} is invalid")
    return checksum


with open(formula_path, "r", encoding="utf-8") as fh:
    lines = fh.read().splitlines(keepends=True)

url_re = re.compile(r'^(\s*url\s+)"([^"]+)"')
sha_re = re.compile(r'^\s*sha256\s+"[^"]*"')
version_re = re.compile(r'^(\s*version\s+)"[^"]*"\s*$')
# Match any GitHub releases URL so cross-repo migration works (e.g. agent-guardian → guardclaw-releases)
any_release_re = re.compile(r"https://github\.com/[^/]+/[^/]+/releases/download/[^/]+/")

updated = list(lines)
pending = {}

if not any(url_re.match(line) for line in lines):
    raise RuntimeError("formula contains no url entries")

idx = 0
while idx < len(updated):
    match = url_re.match(updated[idx])
    if not match:
        idx += 1
        continue

    line_prefix = match.group(1)
    url = match.group(2)
    if "/releases/download/" not in url:
        idx += 1
        continue

    parts = url.split("/")
    artifact = parts[-1]
    if not artifact:
        raise RuntimeError(f"cannot infer artifact from URL: {url}")

    new_url = any_release_re.sub(f"https://github.com/{target_repo}/releases/download/{release_tag}/", url)
    if new_url == url:
        raise RuntimeError(f"failed to rewrite release URL for artifact {artifact}: {url}")

    # SHA256 files for tarballs include the .tar.gz suffix (e.g. guardclaw-darwin-arm64.tar.gz.sha256)
    # Note: <artifact>.sha256 is the raw binary hash; <artifact>.tar.gz.sha256 is the tarball hash.
    checksum_url = f"https://github.com/{target_repo}/releases/download/{release_tag}/{artifact}.sha256"
    checksum = get_checksum(checksum_url)

    updated[idx] = f'{line_prefix}"{new_url}"\n'
    pending[idx] = checksum
    idx += 1

if not pending:
    raise RuntimeError("no releases URLs were updated; formula format may be unsupported")

j = 0
for _, checksum in pending.items():
    while j < len(updated) and not sha_re.match(updated[j]):
        j += 1
    if j >= len(updated):
        raise RuntimeError("found url without following sha256 line")
    updated[j] = re.sub(r'(^\s*sha256\s+)"[^"]*"', fr'\1"{checksum}"', updated[j])
    j += 1

# Only the first explicit version definition is valid in Homebrew formula files.
for i, line in enumerate(updated):
    match = version_re.match(line)
    if match:
        current_version = match.group(1)
        updated[i] = f'{match.group(1)}"{release_version}"\n'
        break
else:
    raise RuntimeError("formula missing version field")

if current_version is None:
    raise RuntimeError("formula version could not be parsed")

with open(formula_path, "w", encoding="utf-8") as fh:
    if dry_run != "1":
        fh.writelines(updated)
PY

if [[ "$DRY_RUN" == "1" ]]; then
  log "DRY RUN complete. No files written."
else
  log "Formula updated successfully."
fi
