#!/usr/bin/env bash
# repub-tag.sh — Re-publish a version tag.
#
# If the tag already exists, this script:
#   1. Deletes the tag from local and remote.
#   2. Finds and removes the matching "docs: publish <tag>" commit from
#      gh-pages. If that was the only commit, the entire gh-pages branch is
#      deleted. Otherwise the commit is surgically dropped from history and
#      the branch is force-pushed.
#
# It then recreates the tag locally and pushes it to the remote, which triggers
# the CI publish workflow for a clean re-publish.
#
# Usage:
#   ./scripts/repub-tag.sh <tag>
#
# Environment:
#   REMOTE   Git remote name (default: origin)

set -euo pipefail

# ── arguments ────────────────────────────────────────────────────────────────

TAG="${1:-}"
if [[ -z "$TAG" ]]; then
  echo "Usage: $0 <tag>" >&2
  exit 1
fi

REMOTE="${REMOTE:-origin}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(git -C "$SCRIPT_DIR" rev-parse --show-toplevel)"

cd "$REPO_ROOT"

# ── helpers ───────────────────────────────────────────────────────────────────

local_tag_exists()     { git rev-parse "refs/tags/$1" &>/dev/null; }
remote_tag_exists()    { git ls-remote --exit-code --tags  "$REMOTE" "refs/tags/$1" &>/dev/null; }
remote_branch_exists() { git ls-remote --exit-code --heads "$REMOTE" "$1" &>/dev/null; }

# ── 1. Remove existing tag ────────────────────────────────────────────────────

if local_tag_exists "$TAG" || remote_tag_exists "$TAG"; then
  echo "==> Tag '$TAG' exists — removing before re-publish"

  if local_tag_exists "$TAG"; then
    echo "    Deleting local tag '$TAG'"
    git tag -d "$TAG"
  fi

  if remote_tag_exists "$TAG"; then
    echo "    Deleting remote tag '$TAG'"
    git push "$REMOTE" ":refs/tags/$TAG"
  fi
fi

# ── 2. Undo the gh-pages commit for this tag ─────────────────────────────────

if remote_branch_exists gh-pages; then
  WORK_DIR="$(mktemp -d)"
  trap 'rm -rf "$WORK_DIR"' EXIT

  REMOTE_URL="$(git remote get-url "$REMOTE")"

  echo "==> Cloning gh-pages into $WORK_DIR"
  git clone --branch gh-pages --single-branch "$REMOTE_URL" "$WORK_DIR"

  pushd "$WORK_DIR" > /dev/null

  GIT_USER="$(git -C "$REPO_ROOT" config user.name  2>/dev/null || echo 'repub-tag')"
  GIT_EMAIL="$(git -C "$REPO_ROOT" config user.email 2>/dev/null || echo 'repub-tag@local')"
  git config user.name  "$GIT_USER"
  git config user.email "$GIT_EMAIL"

  # Find the commit whose message is exactly "docs: publish <tag>"
  COMMIT="$(git log --format="%H %s" | awk -v msg="docs: publish $TAG" '$0 ~ msg {print $1; exit}')"

  if [[ -z "$COMMIT" ]]; then
    echo "    No commit matching 'docs: publish $TAG' found on gh-pages — skipping"
  else
    TOTAL="$(git rev-list --count HEAD)"
    echo "    Found commit $COMMIT  ($TOTAL commit(s) on gh-pages)"

    if [[ "$TOTAL" -eq 1 ]]; then
      # Only one commit: replace it with an empty orphan so the gh-pages branch
      # (and its GitHub Pages configuration) is preserved but contains nothing.
      echo "    Only commit — resetting gh-pages to an empty orphan commit"
      git checkout --orphan gh-pages-empty
      git rm -rf . > /dev/null 2>&1 || true
      git commit --allow-empty -m "chore: reset gh-pages"
      git push origin --force HEAD:gh-pages
    else
      HEAD_SHA="$(git rev-parse HEAD)"

      if [[ "$COMMIT" == "$HEAD_SHA" ]]; then
        # The target commit is the latest; just reset back one
        echo "    Commit is HEAD — resetting HEAD~1 and force-pushing"
        git reset --hard HEAD~1
        git push origin --force HEAD:gh-pages
      else
        # The target commit is buried in history; rebase to drop it
        echo "    Commit is not HEAD — rebasing to drop it"
        PARENT="$(git rev-parse "${COMMIT}^")"
        git rebase --onto "$PARENT" "$COMMIT" HEAD
        git push origin --force HEAD:gh-pages
      fi
    fi
  fi

  popd > /dev/null
else
  echo "==> No remote gh-pages branch found — skipping gh-pages cleanup"
fi

# ── 3. Recreate the tag and push to trigger CI ───────────────────────────────

echo "==> Creating local tag '$TAG'"
git tag "$TAG"

echo "==> Pushing tag '$TAG' to '$REMOTE'"
git push "$REMOTE" "$TAG"

echo "==> Done — CI will now publish a fresh copy of '$TAG'"
