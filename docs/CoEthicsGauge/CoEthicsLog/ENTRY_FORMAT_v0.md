# CoEthicsLog — Entry Format v0

CoEthicsLog entries capture **lens-based opinions grounded in evidence**.

Each entry represents an evaluation of:

- a brand,
- in a region,
- through a specific lens,
- at a point in time.

---

## Core fields

**brand**

- id (slug, e.g. "brand-example")
- display_name
- sector (retail, messaging, food & beverage, etc.)

**region**

- code (e.g. "US-federal", "US-CA", "EU", "Global")
- notes (optional context)

**owners** (optional but recommended)

- array of:
  - group_id (slug)
  - group_display_name
  - ownership_type (majority, subsidiary, franchise, etc.)

**lens**

- id (e.g. "CoEthicsLens.DemocracyFirst.US2025")
- version (e.g. "v1")

**overall_score**

- numeric (0–100)
- band (one of: HaloNod, SolidNod, SmallNod, MixedSignals, SideEye, SpankZone, MajorSpank)
- nods_count (integer, e.g. 0–3)
- spanks_count (integer, e.g. 0–3)

---

## Metrics array

Each metric entry:

- metric_id (e.g. "D1_PoliticalFundingAlignment")
- axis (e.g. "Democracy")
- score_numeric (e.g. -2..+2)
- weight (0..1, as used in lens)
- mood (Nod, Neutral, or Spank, derived from score)
- summary (short text, e.g. “heavy donation skew to anti-democratic PACs”)

---

## Evidence array

Each evidence item:

- source_type (e.g. RegulatorFiling, WatchdogReport, NewsArticle, CompanyDisclosure)
- source_name (short label)
- url or citation
- notes (optional; e.g. page numbers, dataset ids)

---

## Contributors

- circle_id (name/slug of grading circle; may be pseudonymous)
- ai_tools_used (optional text)
- conflicts_of_interest (declared string or "none known")

---

## Timestamps

- created_at_utc
- updated_at_utc

---

## Interpretation and safety

- Entries are **lens-based evaluations**, not universal facts.
- Numeric scores and bands are derived from declared metrics and weights.
- Claims should point to evidence in the vidence[] array.
- CoEthicsGauge tools should:
  - make it easy to inspect the underlying metrics and evidence,
  - clearly state which lens was used for any given gauge.

Future versions may define a JSON/YAML schema to validate entries before accepting them into shared registries.

