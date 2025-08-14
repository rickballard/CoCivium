# Eyes (Metrics & Scope) — README

Purpose.  Static-first spider diagrams for the repo landing page.  Pages enhances with optional tooltips/shimmer.  

Files.
- `metrics.svg`, `scope.svg` — static images committed here.
- `stars.metrics.json`, `stars.scope.json` — optional curated highlights (≤10 each).
- `../docs/scope_crosswalk.csv` — theme→layer→artifact→readiness mapping (used to render scope).

Curation rules.
- ≤10 stars per eye.  Short labels (≤24 chars).  Links must be relative.
- PRs must carry label `eyes-star`.  Two reviewers minimum.

Build notes.
- Keep fonts to system sans-serif.  No remote assets.  SVGs must render in GitHub without JS.
