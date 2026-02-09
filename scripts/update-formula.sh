#!/usr/bin/env bash
# update-formula.sh — Updates Homebrew formulae for a new release.
#
# Usage: ./scripts/update-formula.sh v0.1.0
#
# This script:
# 1. Downloads release tarballs from GitHub Releases
# 2. Computes SHA256 checksums
# 3. Updates Formula/*.rb files with correct version + checksums
# 4. Commits and pushes the changes
#
# Prerequisites:
# - gh CLI authenticated
# - git configured with push access to this repo

set -euo pipefail

VERSION="${1:?Usage: $0 <version-tag>}"
VERSION_NUM="${VERSION#v}"  # Strip leading 'v'

REPO="TakeInterestInc/agent-guardian"
FORMULAE_DIR="$(cd "$(dirname "$0")/../Formula" && pwd)"

echo "Updating formulae for ${VERSION}..."

# Binaries and their formula files
declare -A FORMULA_MAP=(
  ["guardclaw"]="guardclaw.rb"
  ["guardclaw-mcp"]="guardclaw-mcp.rb"
  ["guardclaw-shell"]="guardclaw-shell.rb"
)

PLATFORMS=(
  "darwin-arm64"
  "darwin-amd64"
  "linux-arm64"
  "linux-amd64"
)

TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

for binary in "${!FORMULA_MAP[@]}"; do
  formula_file="${FORMULAE_DIR}/${FORMULA_MAP[$binary]}"
  echo "--- Updating ${formula_file} ---"

  # Update version
  sed -i.bak "s/version \".*\"/version \"${VERSION_NUM}\"/" "$formula_file"

  for platform in "${PLATFORMS[@]}"; do
    tarball="${binary}-${platform}.tar.gz"
    url="https://github.com/${REPO}/releases/download/${VERSION}/${tarball}"

    echo "  Downloading ${tarball}..."
    if curl -fsSL -o "${TMPDIR}/${tarball}" "$url" 2>/dev/null; then
      sha=$(shasum -a 256 "${TMPDIR}/${tarball}" | awk '{print $1}')
      echo "  SHA256: ${sha}"

      # Replace the PLACEHOLDER or existing sha256 for this platform's URL
      # We use the URL line above the sha256 line to identify which one to replace
      python3 -c "
import re, sys
with open('${formula_file}', 'r') as f:
    content = f.read()
# Find the sha256 line that follows the URL for this platform
pattern = r'(url \".*${tarball}\"\\n\\s+sha256 \")([a-fA-F0-9]+|PLACEHOLDER)(\")'
replacement = r'\\g<1>${sha}\\3'
content = re.sub(pattern, replacement, content)
with open('${formula_file}', 'w') as f:
    f.write(content)
"
      echo "  Updated SHA256 in formula"
    else
      echo "  WARN: ${tarball} not found in release, skipping"
    fi
  done

  rm -f "${formula_file}.bak"
done

echo ""
echo "Done. Review changes with: git diff"
echo "Then commit and push to update the tap."
