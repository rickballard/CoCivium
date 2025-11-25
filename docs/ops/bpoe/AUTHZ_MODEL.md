# BPOE  -  Authorization Model (CI & PR Bots)

**Scope:** Same-repo PRs (no forks), artifact-only jobs; no pull_request_target.

## Required capabilities
- **Actions workflow permissions:** repository default must allow **Read & write** or per-job:
  \permissions:\n  contents: read\n  pull-requests: write\
- **PR commenting:** uses default \GITHUB_TOKEN\; no extra secrets.
- **Label management:** create/curate labeling needed by checks (e.g., pr-labeler).
- **Branch protection:** required vs advisory checks set by Co1 policy.

## Guardrails
- No commenting on **fork** PRs.
- No write-on-PR jobs (no commits)  -  artifacts only.
- No \pull_request_target\ escalation.
- Changes additive + reversible.

## Snapshots
- See \docs/ops/bpoe/_snapshots/20251107/*.json\ for current repo settings & recent runs.

