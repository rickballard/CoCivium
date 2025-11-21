# CoEthicsGauge v0  -  Kit, Log & Dashboard

This README gives humans and AIs a single place to see how the CoEthicsGauge pieces fit together.

## 1. What lives where

- **Charter:** `docs/CoEthicsGauge/CoEthicsCharter.md`
- **Metric library:** `docs/CoEthicsGauge/CoEthicsKit/METRICS_LIBRARY_v1.md`
- **Lenses:** `docs/CoEthicsGauge/CoEthicsLens/LENSES_v0.md`
- **Log format + authoring:**
  - `docs/CoEthicsGauge/CoEthicsLog/ENTRY_FORMAT_v0.md`
  - `docs/CoEthicsGauge/CoEthicsLog/ENTRY_AUTHORING_v0.md`
  - `docs/CoEthicsGauge/CoEthicsLog/ENTRY_TEMPLATE_v0.json`
  - `docs/CoEthicsGauge/CoEthicsLog/ENTRY_SCHEMA_v0.json`
- **Entries:**
  - `docs/CoEthicsGauge/CoEthicsLog/entries/<region>/<brand>__<lens>__<stamp>.json`

- **Tools:**
  - `tools/CoEthicsGauge/New-CoEthicsLogEntry.ps1`
  - `tools/CoEthicsGauge/Test-CoEthicsLogEntries.ps1`
  - `tools/CoEthicsGauge/Export-CoEthicsDashboardSnapshot.ps1`  ⟵ wave6

- **Dashboard snapshot (generated):**
  - `docs/CoEthicsGauge/DASHBOARD_SNAPSHOT_v0.md`

## 2. Basic workflow (v0)

1. **Create an entry skeleton**

   ```powershell
   $RepoRoot = "$HOME/Documents\GitHub\CoCivium"

   & "$RepoRoot/tools/CoEthicsGauge/New-CoEthicsLogEntry.ps1" `
     -RepoRoot    $RepoRoot `
     -BrandId     "demo-brand" `
     -BrandName   "Demo Brand" `
     -Sector      "example-sector" `
     -RegionCode  "US-federal" `
     -LensId      "CoEthicsLens.DemocracyFirst.US2025" `
     -LensVersion "v1"
   ```

   This writes a JSON file under `CoEthicsLog/entries/...` using the template and then validates it against the schema.

2. **Fill in metrics + evidence**

   - Open the new JSON file.
   - For each metric:
     - set `score_numeric`,
     - update `summary`,
     - adjust `weight` if needed.
   - Add `evidence[]` items with URLs / citations.
   - Refresh `overall_score` fields if you change weights.

3. **Validate all entries**

   ```powershell
   & "$RepoRoot/tools/CoEthicsGauge/Test-CoEthicsLogEntries.ps1" `
     -RepoRoot $RepoRoot
   ```

4. **Export a dashboard snapshot**

   ```powershell
   & "$RepoRoot/tools/CoEthicsGauge/Export-CoEthicsDashboardSnapshot.ps1" `
     -RepoRoot $RepoRoot
   ```

   This generates/refreshes `DASHBOARD_SNAPSHOT_v0.md` with a table of entries
   (brand, region, lens, numeric score, band, nods/spanks).

5. **Commit + PR**

   - Commit any new/updated entries plus `DASHBOARD_SNAPSHOT_v0.md`.
   - Open a PR describing:
     - which brands/regions/lenses were touched,
     - any schema or metric-library changes,
     - any open questions.

## 3. Notes for future waves

- This is still v0:
  - bands, nod counts, and weight defaults may evolve,
  - additional lenses (WorkerFirst, ClimateFirst, etc.) are expected.
- Future work:
  - stable IDs for metrics and lenses across repos,
  - aggregation views for sectors / owner groups,
  - public CoEthicsGauge APIs and dashboards.

For now, the rule of thumb is simple:

> **If you change how we score or log something, make sure the template, schema, and tools stay in sync, and that the dashboard snapshot regenerates cleanly.**

## Advisory context

For additional strategic framing of CoEthics / CoEthicsGauge, see:

- \docs/CoEthics/CoEthics_IntegrityMap_StrategicAdvisory_Addendum_v0.md\ — Integrity Map strategic advisory addendum (product vision, pitfalls, and roadmap options).

