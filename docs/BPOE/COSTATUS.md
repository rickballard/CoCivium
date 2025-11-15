# CoStatus BPOE
- Put `Use-CoStatus` FIRST in every DO block.
- ADOPT.md: operator guidance for live heartbeat.
- Guard CI: minimal invariant and drift checks.
- Nightly roll-up: `.github/workflows/nightly-costatus.yml`.

## Quick Start
```powershell
Import-Module ./tools/heartbeat/CoStatus.Adapter.psm1 -Force
Use-CoStatus -Pulse 'CU:OK · PU:SOFT · HU:SOFT · WT:OK' -Note 'hello'
