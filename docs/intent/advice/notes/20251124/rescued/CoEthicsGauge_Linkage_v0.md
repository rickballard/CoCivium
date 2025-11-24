# Academia Shock ↔ CoEthicsGauge  -  Linkage v0

- **Session label:** CoEThicsGauge
- **Date (local):** 2025-11-16
- **Context:**
  - Academia Shock: paper + dashboards exploring governance/ethics failures in academia.
  - CoEthicsGauge v0: reusable logging + scoring kit for brands/regions/lenses.

---

## 1. Branch + artifact map (2025-11-16 snapshot)

### Academia Shock branches (CoCivium)

Examples (non-exhaustive, from git branch survey):

- \docs/academia-shock-sessionplan-20251116T050919Z\  -  session plan / rails.
- \docs/academia-shock-dashboard-20251115T050257Z\  -  latest dashboard branch (prior to CoEthicsGauge wave6).
- \ci/academia-shock-receipts-20251115T053843Z\  -  CI receipts branch.
- \docs/academia-shock-mw1..mw6-*\  -  per-wave branches (paper, figures, parable, abstract, etc.).

### CoEthicsGauge branches (CoCivium)

- \docs/CoEthicsGauge-sessionplan-20251115T034852Z\  -  CoEthicsGauge session plan.
- \docs/CoEthicsGauge-kitloglens-20251115T040614Z\  -  initial kit/log/lens layout.
- \docs/CoEthicsGauge-wave3-metricslog-20251115T041148Z\  -  metrics/log work.
- \docs/CoEthicsGauge-wave4-entryschema-20251115T043732Z\  -  entry schema alignment.
- \	ools/CoEthicsGauge-wave5-entrytools-20251115T045322Z\  -  entry tools branch.
- \docs/CoEthicsGauge-wave6-dashboard-20251115T052216Z\  -  dashboard snapshot + exporter.

---

## 2. Current CoEthicsGauge v0 kit (summary)

See also: \docs/CoEthicsGauge/README_CoEthicsGauge_v0.md\

- \docs/CoEthicsGauge/CoEthicsLog/ENTRY_AUTHORING_v0.md\  -  authoring guidance.
- \docs/CoEthicsGauge/CoEthicsLog/ENTRY_FORMAT_v0.md\  -  format details.
- \docs/CoEthicsGauge/CoEthicsLog/ENTRY_SCHEMA_v0.json\  -  PS Test-Json-compatible schema.
- \docs/CoEthicsGauge/CoEthicsLog/ENTRY_TEMPLATE_v0.json\  -  template for new entries.
- \docs/CoEthicsGauge/CoEthicsLog/entries/US-federal/demo-brand__CoEthicsLens.DemocracyFirst.US2025__20251115.json\  -  demo entry.
- \docs/CoEthicsGauge/DASHBOARD_SNAPSHOT_v0.md\  -  auto-generated snapshot of all entries.
- Tools in \	ools/CoEthicsGauge\:
  - \New-CoEthicsLogEntry.ps1\
  - \Test-CoEthicsLogEntries.ps1\
  - \Export-CoEthicsDashboardSnapshot.ps1\
  - \README_CoEthicsGaugeTools_v0.md\

---

## 3. Linkage concept (v0 narrative)

**High-level idea:**

- Academia Shock wants to **tell a story** about governance/ethics regimes for institutions.
- CoEthicsGauge provides a **reusable scoring/logging lens** that can be applied to:
  - universities, publishers, funders, regulators, etc.
  - specific regions/jurisdictions (e.g. \US-federal\).
  - specific “lenses” (e.g. democracy-first, conflict-of-interest-first).

**v0 linkage pattern:**

1. For each Academia Shock case-study (university, journal, etc.):
   - Instantiate a CoEthicsGauge entry (demo pattern: \demo-brand__CoEthicsLens.DemocracyFirst.US2025__...\).
2. Use CoEthicsGauge metrics + evidence fields to:
   - Capture structured ethics metrics.
   - Attach sources (papers, news, governance docs).
3. Use Academia Shock dashboards to:
   - Visualize those metrics in a narrative-friendly way.
   - Embed links back to the underlying CoEthicsGauge entries + schema docs.

---

## 4. Next steps (future Waves)

These are **intentionally left for future Waves / Co1**:

- [ ] Define a small, stable **AcademiaShock lens family** (e.g. democracy-first, integrity-first).
- [ ] Create 2–3 real CoEthicsGauge entries for actual institutions in the paper.
- [ ] Wire \DASHBOARD_SNAPSHOT_v0.md\ (and future snapshots) directly into Academia Shock dashboards.
- [ ] Decide where CoEthicsGauge lives in the long-term index (CoCache / CoCore / CoCivium).


