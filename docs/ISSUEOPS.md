# IssueOps: `/run` quick guide

## What it does
Comment `/run` with a **bash** code block and the self-hosted runner (Windows + Git Bash) will execute that block on a fresh checkout of this repo and reply with logs. Artifacts (script + output) are attached to the workflow run.

Only the **first** fenced ```bash block in your comment is executed.

## Who can trigger
Right now: only **@rickballard** (hard-coded in the workflow). Ask to be added if you need access.

## How to use
Write a comment like:

/run

```bash
set -euo pipefail
echo "Repo top: $(pwd)"
git --no-pager log --oneline -n 3

mkdir -p docs
cat > docs/ACADEMY.md <<'EOF'
# CoCivium Academy (Contributor Onboarding)

## Baseline tools (Windows)
- Git for Windows (includes Git Bash)
- GitHub CLI (`gh`)
- Optional: PowerShell 7+ for local dev

## How we automate from issues
We use an IssueOps workflow. Comment `/run` with a **bash** fence; the first fenced block is executed on our self-hosted runner and results are posted back. See [docs/ISSUEOPS.md](./ISSUEOPS.md).

## AI Boot Prompt (copy/paste into your assistant)
You are assisting on the CoCivium project (open-source). Preferences:
- Default to Git Bash on Windows; keep commands cross-platform where possible.
- Prefer short, robust steps. For long tasks, propose committing scripts to `scripts/` and calling them from `/run`.
- Surface tool/install hints only when needed; link to docs/ACADEMY.md and docs/ISSUEOPS.md.
- When suggesting repo changes, provide clean diffs or ready-to-paste files. Include commit messages.
- Assume branch protection requires PRs; if automation needs a bypass, propose a temporary rules update and restore it.

When asked to “do” something that requires a machine, emit a minimal `/run` bash block that fetches and executes the reviewed script from the repo.
