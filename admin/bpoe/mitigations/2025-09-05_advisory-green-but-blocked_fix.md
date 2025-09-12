<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
# Advisory checks green, PR still BLOCKED (mergeability cache) — cookbook

**Symptom:** PR shows `mergeStateStatus=BLOCKED` even though the _required_ checks are green.  
**Cause:** GitHub’s mergeability cache can report `statusCheckRollup.state=FAILURE` because *advisory* jobs (non-required) are included in the rollup.

## What “good” looks like
Branch protection:
- `required_status_checks.checks` pins:
  - `safety-gate/gate`
  - `readme-smoke/check`
- `strict=true`
- **Admin bypass ON** (enforce_admins=false) by policy.

CI:
- Required jobs named exactly as above (produce those contexts).
- Advisory jobs may fail (`continue-on-error: true`) without blocking.

## Fix sequence (prefer order)
1) Push a no-op commit (cache nudge)  
2) Close → Reopen PR (hard refresh)  
3) Reseed as a fresh PR  
4) Manual merge (admin) only if required checks are green and cache is stale  
5) Re-assert protections using `checks` (not `contexts`)

_This doc is part of BPOE “Known Issues & Mitigations”._





