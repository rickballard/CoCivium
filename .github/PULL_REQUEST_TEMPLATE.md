### Launch / RickGuard checklist
- [ ] If this PR is part of a **launch**, run:
      `Set-RickGuardAll -Owner rickballard -Mode Off -CriticalSet @("CoCivium")`
- [ ] If we’re entering **seeding** again, run:
      `Set-RickGuardAll -Owner rickballard -Mode Seed -CriticalSet @("CoCivium")`
- [ ] Confirm CoCivium remains **Critical** (checks + 1 review).