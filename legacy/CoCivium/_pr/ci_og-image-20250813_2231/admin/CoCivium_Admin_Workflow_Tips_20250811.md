CoCivium Admin Workflow Tips — 2025-08-11 (EST 1:07)

A short, opinionated checklist from today’s cleanup (workflow guardrails, README refresh, lint hygiene/fights, PR flow/hygiene).  Goal: fewer surprises, faster merges, cleaner history.  

1) Branch & PR Flow (keep it boring)

**One purpose per branch.** Name like: `docs/readme-refresh-YYYYMMDD` or `chore/ci-lint-YYYYMMDD`.
**Always PR to `main`.** Don’t merge directly unless you must unbreak CI.
**Prefer squash-merge.** Keeps `main` linear and easy to revert.
**No self-approval.** If rules block you, ask a human reviewer or use a temporary maintainer override with a comment.

2) Fast local prequel (copy/paste)

# repo prequel (Windows Git Bash safe)

cd "$HOME/Documents/GitHub/CoCivium" 2>/dev/null \
  || cd "/c/Users/Chris/Documents/GitHub/CoCivium" \
  || { echo "? repo not found"; exit 1; }

export GIT_PAGER=cat GH_PAGER=cat GH_NO_TTY=1
git fetch --prune origin
git switch -C docs/readme-refresh-$(date +%Y%m%d) origin/main

3) Linting guardrails (so CI doesn’t surprise you)

Markdown (two linters):
markdownlint-cli2 (project default): allow inline HTML; watch MD022/MD032 (blank lines around headings/lists).
Ruby mdl (workflow check): we added .mdlrc to match our style:
Line length = 120
Allow inline HTML (MD033)
Use .mdlignore for non-prose MD (e.g., Issue Forms YAML masquerading as MD).

YAML (yamllint):
If a long line is unavoidable (e.g., JSON in YAML), use a scoped disable:

# yamllint disable-line rule:line-length

(Place it directly above or on the line; avoid broad disables.)

Link checker (lychee):
Prefer full URLs in angle brackets (<https://…>) to avoid “bare URL” rules.
For flaky externals, add them to the link checker’s allowlist rather than disabling the job.

4) Markdown hygiene (90% of failures)

Always leave a blank line:
Before and after headings.
Before the first list item and after the last list item.
Before and after fenced code blocks.
Exactly one H1 per file (MD025).

Code fences include a language (MD040):
```bash / ```json / ```text
Avoid bare URLs (MD034): use <https://example.com> or [label](https://example.com).

5) ONEBLOCK mode (docs you can diff & render)

Put the machine-brief section between markers:

<!-- COCIVIUM-README-START -->
…authoritative body…
<!-- COCIVIUM-README-END -->

CI (later) can verify that block’s presence and optionally regenerate it.

6) Typical “fix the lints” one-liner set

CI (later) can verify that block’s presence and optionally regenerate it.

# Add blank line after headings, around lists (example for one file)

perl -0777 -i -pe "s/^(#{1,6}\s[^\n]*\n)(?!\n)/\$1\n/gm" README.md
perl -0777 -i -pe "s/([^\n]\n)([-*]\s|\d+\.\s)/\$1\n\$2/g" README.md
perl -0777 -i -pe "s/((?:^[-*]\s.*\n|^\d+\.\s.*\n)+)(?!\n)/\$1\n/gm" README.md
(Use carefully; commit and review the diff.)

7) PR review + merge checklist

Files tab ? Display the rich diff for Markdown to verify rendering.
Checks tab:
markdownlint ? OK
mdl ? OK
yamllint ? OK
lychee ? OK (or allowed flake)
Request review (cannot self-approve).
Use Squash and merge with a clean, imperative message.
8) Post-merge housekeeping
git switch main
git pull --ff-only origin main

# tag human-visible milestones

git tag -a v0.0.1 -m "Initial ONEBLOCK landing page"
git push origin v0.0.1

# prune merged branches (local + remote)

git fetch --prune origin
git branch --merged origin/main | egrep -v '^\*|main' | xargs -r git branch -d
git remote prune origin

9) When Git Bash “hangs”

Make sure no command halfway-typed is sitting before a cat <<'EOF' block.
Use Ctrl+C once, then Ctrl+D if in a heredoc.
Close tab and reopen if the terminal is stuck in an interactive pager/editor.
We set GIT_PAGER=cat and GH_PAGER=cat in prequel to reduce this.

10) Why checks block merges

Branch protection expects green checks + 1 approval.
If you must override (e.g., unbreak main), leave a public comment with the reason and a follow-up task.

11) Small repo tweaks we adopted today

.mdlrc aligned to project style (120 col, allow inline HTML).
.mdlignore to skip legacy Issue Form MD.

Scoped yamllint line-length disables near GitHub-script blocks.
.gitignore now ignores *.bak.

12) Next small improvements (low lift)

Add a CONTRIBUTING.md ? “How to pass CI” section with the hygiene rules above.
Add a repo script ./admin/lint-fix.sh that runs the safe perl helpers.
Add a bot rule to label PRs touching README.md with needs/decision.
(Optional) A tiny Action to fail if the README loses the ONEBLOCK markers.

