#!/usr/bin/env bash
set -euo pipefail

OWNER=rickballard
REPO=CoCivium
BRANCH=main

PR="${1:-}"
if [[ -z "$PR" ]]; then echo "Usage: $0 <pr-number>"; exit 64; fi

current_req() {
  gh api "repos/$OWNER/$REPO/branches/$BRANCH/protection" \
    --jq '.required_pull_request_reviews.required_approving_review_count // 1' 2>/dev/null || echo 1
}

payload() {
  cat <<JSON
{
  "required_status_checks": null,
  "enforce_admins": true,
  "required_pull_request_reviews": {
    "dismiss_stale_reviews": true,
    "require_code_owner_reviews": true,
    "required_approving_review_count": $1
  },
  "restrictions": null,
  "required_linear_history": true,
  "required_conversation_resolution": true,
  "allow_force_pushes": false,
  "allow_deletions": false
}
JSON
}

REQ="$(current_req)"

echo "→ Temporarily setting approvals to 0…"
gh api -X PUT "repos/$OWNER/$REPO/branches/$BRANCH/protection" \
  -H "Accept: application/vnd.github+json" --input - <<<"$(payload 0)"

echo "→ Squash-merging PR #$PR…"
gh pr merge "$PR" --squash --delete-branch --repo "$OWNER/$REPO"

echo "→ Restoring approvals to $REQ…"
gh api -X PUT "repos/$OWNER/$REPO/branches/$BRANCH/protection" \
  -H "Accept: application/vnd.github+json" --input - <<<"$(payload "$REQ")"

echo "✅ Done."
