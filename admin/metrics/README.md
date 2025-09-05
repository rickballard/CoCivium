# Metrics Pipeline (MVP)

This folder contains the nightly metrics collector and SVG renderer for the CoCivium progress map.

- `collect_metrics.py` — scans the repo to compute provisional scores (CI, Coverage, OFS, LSH, DTI, Throughput, LT_norm, EE, RD) and writes `metrics.json` plus a dated snapshot in `history/`.
- `render_progress_map.py` — reads `metrics.json` and outputs `site/assets/progress_map_v0.svg` (static).
- `build_metrics.yml` — GitHub Action scheduled nightly at 02:00 UTC (and manual via **Run workflow**). It runs the collector, renders the SVG, and commits any changes.

> Notes
> - Coverage requires an optional `admin/manifest.json` with `must` and `should` arrays of file paths.
> - LT and EE are placeholders until GitHub API integration is added.
> - v0 does not render RD dents; that arrives in v1.

