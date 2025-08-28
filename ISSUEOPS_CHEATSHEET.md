# IssueOps Cheat Sheet (fast path)

> Skim first. Deep details stay in `ISSUEOPS.md`.

## Purpose
Make tiny, safe changes fast; keep coordination visible in issues/PRs.

## Start here (tiny change, 60–120s)
1. **Branch** — `git switch -c docs/<slug>-c1` (or `ops/`, `fix/`, `chore/`, `test/`)
2. **Edit + commit** — prefix with scope: `docs:`, `ops:`, `fix:`, `test:`, `chore:`
3. **Push + PR** — `git push -u origin HEAD` → `gh pr create --title "<scope>: <summary>" --body "<why/what>"`

## CoPingPong
- Ping (author): tiny PR, ask yes/no.
- Pong (reviewer): quick comment/suggestion commit.
- Merge: squash + delete branch when green.

## CoTips
- PR paths: `gh pr view <num> --json files --jq '.files[].path'`
- No commits between…: add a real change or `git commit --allow-empty -m "chore: kick"` then push.
- CRLF → LF quick fix: `Get-Content X -Raw | % {$_ -replace "`r`n","`n" -replace "`r","`n"} | Set-Content X -Encoding utf8`
- Merge: `gh pr merge <num> --squash --delete-branch`
- Scope creep? Split the PR.

## Common flows
### Tiny docs tweak
git switch -c docs/readme-typo-c1
# edit
git commit -am "docs: fix README typo (tiny)"
git push -u origin HEAD
gh pr create --title "docs: fix README typo (tiny)" --body "One-liner."