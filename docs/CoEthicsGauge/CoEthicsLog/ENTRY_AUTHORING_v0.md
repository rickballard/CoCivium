# CoEthicsLog Entry Authoring v0

This guide explains how to create new CoEthicsLog entries that match:

- `ENTRY_FORMAT_v0.md`
- `ENTRY_SCHEMA_v0.json`

## 1. Recommended workflow (v0)

1. Pick a **brand**, **region**, and **lens** (e.g. `CoEthicsLens.DemocracyFirst.US2025`).
2. Use AI tools to collect evidence for a small set of metrics (start with the ones in `METRICS_LIBRARY_v1.md`).
3. As a human (or circle), review the evidence and assign numeric scores.
4. Fill in:
   - `overall_score` (numeric + band + nod/spank counts),
   - `metrics[]` array,
   - `evidence[]` array,
   - `contributors` and `timestamps`.
5. Save the entry as a JSON file (e.g. `docs/CoEthicsGauge/CoEthicsLog/entries/<region>/<brand>_<lens>.json`).
6. Run a JSON-schema validator (or PowerShell `Test-Json`) against `ENTRY_SCHEMA_v0.json`.

## 2. Validating with PowerShell (example)

From the repo root in PowerShell 7:

```powershell
$entry   = "docs/CoEthicsGauge/CoEthicsLog/ENTRY_TEMPLATE_v0.json" # or your new file
$schema  = "docs/CoEthicsGauge/CoEthicsLog/ENTRY_SCHEMA_v0.json"

Get-Content $entry -Raw | Test-Json -SchemaFile $schema
```

If the result is `True`, the entry matches the schema. If not, PowerShell will throw an error indicating where it failed.

## 3. File naming (suggested)

- Directory: `docs/CoEthicsGauge/CoEthicsLog/entries/<region>/`
  - Example region codes:
    - `US-federal`
    - `US-CA`
    - `EU`
    - `Global`

- File name pattern:

  - `<brand-id>__<lens-id>__<yyyymmdd>.json`

  Example:

  - `demo-brand__CoEthicsLens.DemocracyFirst.US2025__20251115.json`

This keeps entries sortable and traceable over time.

## 4. Lens transparency

Every entry must:

- Specify a **lens id** and **version**.
- Use metrics and weights consistent with that lens.
- Include enough evidence so that others can understand the judgement, even if they disagree with it.

## 5. Future improvements

Later waves can add:

- Helper scripts (e.g. `New-CoEthicsLogEntry.ps1`) that:
  - prompt for scores,
  - assemble JSON,
  - validate against the schema automatically.
- CI checks that validate all entries in `entries/` against `ENTRY_SCHEMA_v0.json`.
