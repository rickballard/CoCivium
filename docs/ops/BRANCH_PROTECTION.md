# Branch Protection — Minimal Gates (stub)
- Required checks: safety-gate/gate, readme-smoke/check
- Merge style: squash + delete branch
- Relax gates only for migration, then re-enable
  
**Tooling.** See `tools/SetBranchProtection.ps1`.  Default is **DRY RUN**.  Use `-Relax -Apply` only during migration windows, then `-Reenable -Apply`.
