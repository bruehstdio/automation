#!/usr/bin/env bash
# Clone all repositories for a given GitHub owner/organization.
# Usage: ./clone-all-repos.sh <owner> [destination_dir]
#
# Requires: gh (GitHub CLI) authenticated

set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <owner/org> [destination_dir]"
  echo "  owner/org        GitHub user or organization name"
  echo "  destination_dir   Directory to clone into (default: ./<owner>)"
  exit 1
fi

OWNER="$1"
DEST="${2:-$OWNER}"

if ! command -v gh &>/dev/null; then
  echo "Error: gh (GitHub CLI) is not installed." >&2
  exit 1
fi

if ! gh auth status &>/dev/null; then
  echo "Error: gh is not authenticated. Run 'gh auth login' first." >&2
  exit 1
fi

mkdir -p "$DEST"

echo "Fetching repository list for '$OWNER'..."
repos=$(gh repo list "$OWNER" --limit 1000 --json nameWithOwner --jq '.[].nameWithOwner')

total=$(echo "$repos" | wc -l | tr -d ' ')
echo "Found $total repositories."

count=0
for repo in $repos; do
  count=$((count + 1))
  name="${repo#*/}"
  target="$DEST/$name"

  if [[ -d "$target/.git" ]]; then
    echo "[$count/$total] Updating $repo (already cloned)..."
    git -C "$target" pull --ff-only 2>/dev/null || echo "  Warning: pull failed for $name, skipping update"
  else
    echo "[$count/$total] Cloning $repo..."
    gh repo clone "$repo" "$target" -- --quiet
  fi
done

echo "Done. All repositories cloned to '$DEST/'."
