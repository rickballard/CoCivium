<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
# CoAgent Kit: autobrand + perf + ISSUEOPS

## What’s in this PR
- Repo‑scoped Auto‑Brand (reversible), performance caching, slow‑probe guard
- Health & cleanup: `CoBP-Health`, `CoBP-Deflate`
- Timing helpers: `CoBP-Stamp`, `CoBP-Time`
- `docs/ISSUEOPS.md`: Switchboard + Relaunch Fix

## How to verify
- Open a new PS7 in the repo: prompt shows `[Brand (branch)]`
- `cd` out of repo: prompt returns to stock PS7
- Run `CoBP-Health` and `CoBP-Deflate` without errors
- Trigger `co-rescue` after a fresh shell and verify branding

## Rollout notes
- Per‑repo accent is set by mapping (see `palette.yml`); optional env overrides: `CO_BRAND`, `CO_BRAND_ACCENT`.










