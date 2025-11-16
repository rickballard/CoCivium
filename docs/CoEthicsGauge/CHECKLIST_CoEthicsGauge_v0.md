# CoEthicsGauge v0 — Intent & Checklist

This checklist describes what “v0 ready” means for CoEthicsGauge and how future waves should CoSync.

---

## 1. v0 readiness checklist (methods & data)

- [ ] Tier-1 axes confirmed and documented in CoEthicsKit:
  - Democracy & Civic Power
  - Human Dignity & Labour
  - Health & Wellbeing
  - Planet & Future Generations
  - Data, Information & AI
  - Integrity, Fairness & Governance
- [ ] Metric library v0 drafted:
  - At least 3–5 metrics per axis.
  - Scale and anchors defined (e.g. -2..+2).
  - Evidence hints for each metric.
- [ ] Lens pattern defined:
  - Lenses declare which axes they use and how they weight them.
  - Lenses are region-specific when needed (e.g. *.US2025).
- [ ] Spanks/Nods mapping agreed:
  - Numeric core (0–100).
  - Band names (Halo Nod, Solid Nod, Small Nod, Mixed Signals, Side-Eye, Spank Zone, Major Spank).
  - Rules for per-metric mini nods/spanks.

---

## 2. CoEthicsLog checklist

- [ ] Entry format documented (JSON/YAML + human-readable view).
- [ ] Required fields include:
  - brand (id, name, sector),
  - region,
  - owners (group links),
  - lens id + version,
  - overall_score (numeric + band + nods/spanks count),
  - metrics[] (id, axis, score, weight, mood, summary),
  - evidence[],
  - contributors,
  - timestamps.
- [ ] At least one demo entry authored as a worked example.
- [ ] Clear statement that entries are:
  - lens-based evaluations,
  - grounded in cited evidence,
  - not legal findings or investment advice.

---

## 3. CoSync & governance checklist

For each material CoEthicsGauge change:

- [ ] Change landed on a feature branch with a descriptive name.
- [ ] PR opened with:
  - what changed,
  - why,
  - which Tier-1 axes, metrics, or lenses were touched.
- [ ] CoSync / CoStatus note updated to:
  - link to PR(s),
  - summarise intent shifts,
  - note TODOs for the next wave.
- [ ] CoEthicsCharter kept in sync with:
  - humour and opinions stance,
  - AI+Human pairing patterns,
  - moderation / safety expectations.

---

## 4. Product/UX checklist (for first public tool)

- [ ] Brand card shows:
  - brand, sector, region,
  - lens used,
  - Spanks/Nods mood + numeric score,
  - short lists: “Nods earned for…” / “Spanks earned for…”.
- [ ] Advanced view exposes:
  - per-axis scores,
  - metrics and evidence links.
- [ ] AI+Human grading flow:
  - choose brand, lens, region,
  - AI gathers and summarises evidence per metric,
  - human reviews and sets scores,
  - log entry preview before publishing,
  - explicit consent before adding to CoEthicsLog.
- [ ] Front-end copy includes:
  - explanation of lenses,
  - explanation of humour vs seriousness,
  - disclaimers around opinion, evidence, and limits.

