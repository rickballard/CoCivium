# CoEthicsGauge Tools v0

This directory contains helper scripts for working with CoEthicsLog entries.

## 1. New-CoEthicsLogEntry.ps1

Create a new entry JSON file from the template and validate it against the schema.

Example:

```powershell
$RepoRoot = "$HOME/Documents/GitHub/CoCivium"

& "$RepoRoot/tools/CoEthicsGauge/New-CoEthicsLogEntry.ps1" `
  -RepoRoot $RepoRoot `
  -BrandId "demo-brand" `
  -BrandName "Demo Brand" `
  -Sector "example-sector" `
  -RegionCode "US-federal" `
  -LensId "CoEthicsLens.DemocracyFirst.US2025" `
  -LensVersion "v1"
```

Then open the generated file under:

- `docs/CoEthicsGauge/CoEthicsLog/entries/<RegionCode>/...`

…and update:

- metrics,
- evidence,
- overall score and bands,
- contributors, if needed.

## 2. Test-CoEthicsLogEntries.ps1

Validate all entries under `docs/CoEthicsGauge/CoEthicsLog/entries`:

```powershell
$RepoRoot = "$HOME/Documents/GitHub/CoCivium"

& "$RepoRoot/tools/CoEthicsGauge/Test-CoEthicsLogEntries.ps1" -RepoRoot $RepoRoot
```

This uses `ENTRY_SCHEMA_v0.json` and `Test-Json` to check structure. Any failures are printed with the file path.

These tools are intentionally simple v0 helpers so future waves (or CoAgent / CoArena) can script around them.
