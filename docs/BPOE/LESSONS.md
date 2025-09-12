<!-- status: stub; target: 150+ words -->
- 2025-08-24T13:27:41 — PS7 microtext + scan-for-red speeds selection and reduces visual load.
- 2025-08-24T13:27:43 — Block IDs with datestamps improve etiquette cues and human recall between sessions.
- 2025-08-24T13:27:44 — Duplicate section headers and blank lines in output make copy-back easier.



### Seed-mode merges (admin)

- Prefer `gh pr merge --admin --squash` for early repos.
- After merging, hard-sync locals: `git fetch origin --prune && git reset --hard origin/main`.
- For `gh api` probes that may 404, use the PS 5/7-safe wrapper (`tools/gh-safe.ps1`) instead of relying on `$PSNativeCommandUseErrorActionPreference`.
- Move seed tags deterministically: `git tag -a <tag> -m "..." -f && git push -f origin <tag>`.

## BPOE Mandates (2025-09-12)

- **CoTemps-first & programmatic**: never ask for manual steps when we can script them. Canonical logic lives in-repo under 	ools/; wrappers live in CoTemps.
- **No blank waits**: any long operation must show a heartbeat (one dot per second). Implemented via 	ools/heartbeat.ps1; used by admin helpers.
- **Admin seeding**: use gh pr merge --admin --squash; then hard-sync local to origin/main.
- **Deterministic seed tags**: git tag -fa <tag> -m "<msg>" && git push -f origin <tag>. CI guard ensures annotated & points-at origin/main.
- **Branch protection (seed-mode)**: remove rules; treat 404 as success. Use 	ools/bp-unprotect.ps1 (safe GH API wrapper).
- **.gitattributes**: repo LF; CRLF only for .bat/.cmd; explicit inary globs; run git add --renormalize . after changes.
- **Never paste YAML/.gitattributes into the shell**: create files then commit.

## BPOE Runtime Mandates (2025-09-12)

- **CoTemps-first**: never paste long DO blocks; scripts live in 	ools/, thin wrappers live in %USERPROFILE%\CoTemps\CoCivium\.
- **No blank waits**: all long ops must show a visible heartbeat (one dot/sec). Implemented via 	ools/heartbeat.ps1; used by admin helpers.
- **Admin seeding**: gh pr merge --admin --squash, then hard-sync local to origin/main.
- **Deterministic seed tags**: move tags with git tag -fa ... && git push -f origin <tag>; CI guards that tags are annotated and on origin/main.
- **Seed-mode branch protection**: remove rules; treat HTTP 404 as success. Use 	ools/bp-unprotect.ps1 (GH API wrapper).
- **Line-endings**: repo LF; CRLF only for .bat/.cmd; run git add --renormalize . after .gitattributes changes.

### BPOE Runtime Addendum (2025-09-12)
- **Heartbeat is dot-source-safe**: state kept in Global:__BPOE_* with guarded lookups; no blank PS7 lines during long ops.
