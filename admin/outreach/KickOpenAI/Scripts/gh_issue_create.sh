#!/usr/bin/env bash
# Usage: ./gh_issue_create.sh <owner/repo> <title-file> <body-file> <appendix-file>
set -euo pipefail

REPO="${1:-openai/openai-cookbook}"
TITLE_FILE="${2:-../Posts/github_issue.md}"
BODY_FILE="${3:-../Posts/github_issue.md}"
APPENDIX_FILE="${4:-../Appendix/CoCivium_OpenAI_Bugs_Appendix_YYYY-MM-DD.md}"

TITLE="$(head -n1 "$TITLE_FILE" | sed 's/^Title: //')"
BODY="$(sed '1d' "$BODY_FILE")"

gh issue create   --repo "$REPO"   --title "$TITLE"   --body "$BODY"

echo "Issue created in $REPO.  Remember to attach the appendix manually (GitHub CLI attachment support varies)."
