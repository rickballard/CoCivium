# CoEthicsKit — Metric Library v0

This file defines the **Tier-1 axes** and starter metrics for CoEthicsGauge.

Each metric has:

- **Axis**: which high-level dimension it belongs to.
- **Description**: what behaviour it captures.
- **Scale (v0)**: suggested rating scale (-2, -1, 0, +1, +2).
- **Evidence hints**: where AI+Human pairs should look for data.

---

## Tier-1 Axes

1. Democracy & Civic Power (CoEthicsAxis.Democracy)
2. Human Dignity & Labour (CoEthicsAxis.DignityLabour)
3. Health & Wellbeing (CoEthicsAxis.HealthWellbeing)
4. Planet & Future Generations (CoEthicsAxis.PlanetFuture)
5. Data, Information & AI (CoEthicsAxis.DataAI)
6. Integrity, Fairness & Governance (CoEthicsAxis.IntegrityGov)

Lenses select and weight metrics under these axes.

---

## Axis 1 — Democracy & Civic Power

Example metrics:

### D1. Political Funding Alignment

- **Description:** How political donations, PACs and related spend align with democratic norms (rule of law, electoral integrity, independent courts).
- **Scale (v0):**
  - -2: Major spend backing actors undermining democratic safeguards.
  - -1: Noticeable skew towards anti-democratic positions.
  -  0: Mixed or low-intensity spending; impact unclear.
  - +1: Mostly supports actors strengthening democratic norms.
  - +2: Strong, consistent support for democratic safeguards.
- **Evidence hints:** donation registries, watchdog reports, credible press.

### D2. Lobbying and Regulatory Capture Risk

### D3. Government and Regime Relationships

### D4. Treatment of Civic Space & Dissent

(Each metric to be fully expanded in v1 with detailed anchors and evidence examples.)

---

## Axis 2 — Human Dignity & Labour

Example metrics:

### L1. Core Labour Standards

- **Description:** Respect for ILO-style core labour standards (no forced labour, child labour, discrimination; freedom of association).
- **Scale (v0):** from -2 (systemic violations, repeated scandals) to +2 (clear policies, enforcement, independent verification).
- **Evidence hints:** NGO reports, audit summaries, court cases, worker testimony.

### L2. Workplace Health & Safety

### L3. Supply-Chain Labour Conditions

---

## Axis 3 — Health & Wellbeing

Example metrics:

### H1. Product Health Impact

- **Description:** Contribution of flagship products to major public health concerns (e.g. obesity, diabetes, cardiovascular disease), relative to guidelines.
- **Scale (v0):**
  - -2: Portfolio dominated by high-risk products with little mitigation.
  - -1: Significant share of high-risk products; some reformulation.
  -  0: Mixed portfolio; unclear net impact.
  - +1: Majority moderate/low risk; visible reformulation efforts.
  - +2: Portfolio strongly aligned with public health guidance.
- **Evidence hints:** nutrient profiles, public health guidance, peer-reviewed studies.

### H2. Marketing to Vulnerable Groups

### H3. Community & Worker Wellbeing

---

## Axis 4 — Planet & Future Generations

Example metrics:

### E1. Emissions Trajectory vs Public Targets

### E2. Pollution and Local Harm

### E3. Transition Honesty vs Greenwash

---

## Axis 5 — Data, Information & AI

Example metrics:

### A1. Data Exploitation & Consent

### A2. Surveillance & State Collaboration

### A3. AI Transparency & Red-Teaming

---

## Axis 6 — Integrity, Fairness & Governance

Example metrics:

### G1. Corruption & Bribery Exposure

### G2. Tax Justice & Profit Shifting

### G3. Competition & Market Power Abuse

---

## Next steps for this library

- Flesh out each metric:
  - full description,
  - scale anchors,
  - evidence examples,
  - relevant external standards.
- Mark some metrics as **core** (expected in most lenses) vs **optional**.
- Align naming with CoCivium, CoPolitic and CoCore taxonomies over time.

