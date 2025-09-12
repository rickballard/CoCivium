<!-- status: stub; target: 150+ words -->
- 2025-08-24T13:27:41 — PS7 microtext + scan-for-red speeds selection and reduces visual load.
- 2025-08-24T13:27:43 — Block IDs with datestamps improve etiquette cues and human recall between sessions.
- 2025-08-24T13:27:44 — Duplicate section headers and blank lines in output make copy-back easier.



### Seed-mode merges (admin)

- Prefer `gh pr merge --admin --squash` for early repos.
- After merging, hard-sync locals: `git fetch origin --prune && git reset --hard origin/main`.
- For `gh api` probes that may 404, use the PS 5/7-safe wrapper (`tools/gh-safe.ps1`) instead of relying on `$PSNativeCommandUseErrorActionPreference`.
- Move seed tags deterministically: `git tag -a <tag> -m "..." -f && git push -f origin <tag>`.
