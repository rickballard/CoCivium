# CoBus Events (append-only log)
#### CoBusEvent CB_20251128_CoCiviaHeartbeat_20251128T061154Z

- when      : 20251128T061154Z
- session   : CoPrime20251128
- kind      : cocivia_heartbeat_processed
- repo      : CoCivium
- heartbeat : docs\intent\advice\heartbeat\CoCivia\Heartbeat_20251128T055009Z.md
- cosync    : CoSync_CoCiviaHeartbeat_20251128T061154Z.md
- summary   : Scaffolded CoSync note for latest CoCivia heartbeat; human to fill in intent decisions and actions, then commit via normal BPOE.


#### CoBusEvent CB_20251128_CoCiviaHeartbeat_20251128T072417Z

- when      : 20251128T072417Z
- session   : CoPrime20251128
- kind      : cocivia_heartbeat_processed
- repo      : CoCivium
- heartbeat : docs\intent\advice\heartbeat\CoCivia\Heartbeat_20251128T072411Z.md
- cosync    : CoSync_CoCiviaHeartbeat_20251128T072417Z.md
- summary   : Scaffolded CoSync note for latest CoCivia heartbeat; human to fill in intent decisions and actions, then commit via normal BPOE.


## EVT-CoIndex-SeedHelpers-20251128T083646Z – CoIndex seed helpers wave

- timestamp_utc: 20251128T083646Z
- session_label: CoIndex20251128
- kind: index-update
- repos:
  - CoIndex
  - CoSteward
  - CoPlan
  - CoCivium
  - InSeed
- notes:
  - Auto-generated helper entries from CoIndex/docs/intent/CoIndex_SeedAssets_v1.md
    into the latest CoIndex_SeedHelpers_*.md file.
  - See CoIndex/docs/helpers/CoIndex_SeedHelpers_*.md for details.
  - See CoSteward/docs/intent/CoStatus_Pulses_v1.md for the related CoIndex pulse.
## EVT-CoIndex-AcademiaShockPilot-20251128T151500Z – CoIndex academia-shock pilot export

- timestamp_utc: 20251128T151500Z
- session_label: CoIndex20251128
- kind: index-export
- lane_id: academia-shock
- repos:
  - CoIndex
  - CoSteward
  - CoCivium
  - InSeed
- artifacts:
  - CoIndex/exports/work/CoIndex_academia-shock_Harvest_v1.json
  - CoIndex/exports/work/CoIndex_academia-shock_Annotated_v1.json
  - CoIndex/exports/pointees/CoIndex_AcademiaShock_Pilot_v1.json
- notes:
  - First CoIndex HARVEST H/A/E pipeline run for academia-shock lane.
  - Export shape is "CoIndex_ExportSchema_v2-pilot" pointees for System.Func`2[System.Text.RegularExpressions.Match,System.String] consumption.
