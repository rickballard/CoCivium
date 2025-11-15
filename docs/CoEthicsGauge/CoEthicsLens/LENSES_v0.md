# CoEthicsLens — v0 Lens Definitions

Lenses are **viewpoint bundles** that:

- pick which metrics/axes to use,
- assign weights,
- provide a short ethical rationale.

Each log entry records which lens was used.

---

## Lens 1 — CoEthicsLens.DemocracyFirst.US2025

**Scope:** Brands evaluated for their impact on democracy and civic power in the United States (circa 2025).

**Primary axes:**

- Democracy & Civic Power — heavy weight
- Integrity, Fairness & Governance — heavy weight

**Supporting axes:**

- Data, Information & AI — moderate weight
- Human Dignity & Labour — low/moderate weight

**Weights (v0 sketch):**

- Democracy: 0.40
- IntegrityGov: 0.30
- DataAI: 0.15
- DignityLabour: 0.10
- HealthWellbeing: 0.03
- PlanetFuture: 0.02

**Rationale (short):**

> This lens focuses on whether a brand, through its owners and operations, strengthens or weakens democratic institutions, civic space, and information integrity in the US context.

---

## Lens 2 — CoEthicsLens.HealthFirst.Global

**Scope:** Brands evaluated primarily on health and wellbeing impact globally.

**Primary axes:**

- Health & Wellbeing — heavy weight

**Supporting axes:**

- Human Dignity & Labour — moderate weight
- Planet & Future Generations — moderate weight
- Integrity, Fairness & Governance — low/moderate weight

**Weights (v0 sketch):**

- HealthWellbeing: 0.45
- DignityLabour: 0.20
- PlanetFuture: 0.20
- IntegrityGov: 0.10
- DataAI: 0.03
- Democracy: 0.02

**Rationale (short):**

> This lens cares most about whether brand products, workplaces and supply chains are compatible with long-term human health and wellbeing, while still accounting for dignity, planetary limits and basic governance integrity.

---

## Lens evolution notes

- Lenses should be versioned (e.g. .v1, .v2) when weights or metric sets change.
- Region is part of the lens id when context matters (e.g. *.US2025).
- Alternative lenses (e.g. WorkerFirst, ClimateFirst) can be added by new grading circles via PRs.

