<!-- status: stub; target: 150+ words -->
# Mitigation: Auto-merge **BLOCKED** with advisory failures (GitHub mergeability cache & required checks mapping)
**Date:** 2025-09-05 (America/Toronto)  
**Branch/PR:** [docs/bpoe-known-issues-20250905](docs/bpoe-known-issues-20250905) / PR #347

## Symptoms
- `gh pr view --json mergeStateStatus` ⇒ `BLOCKED`
- `statusCheckRollup.state` ⇒ `FAILURE`, but only *advisory* jobs (e.g., `codespell`, `markdownlint`, `yamllint`) are failing.
- Required checks (`safety-gate/gate`, `readme-smoke/check`) are ✅.
- `reviewDecision` empty; review threads resolved.

## Likely root causes
1) Mergeability cache staleness after branch-protection changes.  
2) Protection pinned legacy **contexts** while Actions exposes **check runs**.

## Resolution (worked here)
1. Set protection using **required_status_checks.checks** (include Actions app id 15368).
2. Push a no-op commit to force GitHub to recompute mergeability.
3. Verify with `gh pr view ...` and status check rollup.

## Preventatives
- Prefer **checks** over **contexts** for Actions jobs; include app id.
- After protection changes: no-op commit (or close/reopen PR) to refresh mergeability.
- Keep admin bypass ON (policy choice). Make required checks minimal and explicit.
- When blocked with required checks green: confirm `reviewDecision` isn’t `CHANGES_REQUESTED` and threads are resolved.

## PS/gh pitfalls to avoid
- Put `} else {` on the same line (or avoid else entirely).
- Pass `-H "Accept: application/vnd.github+json"` as literal strings (not hashtables).
- Escape `$` in GraphQL here-strings or pass variables via `-f/-F`.
- Wrap Markdown/YAML in single-quoted here-strings.
- Keep `.gitattributes` enforcing LF on `main`. Unify codespell wordlists.



