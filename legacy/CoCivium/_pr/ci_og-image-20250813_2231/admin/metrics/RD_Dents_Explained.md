# Redundancy-Debt “Dents” (v1.1)

**What is a dent?**  A *dent* is a small inward notch along an axis of the progress polygon.  It visualizes **Redundancy Debt (RD)** on that axis: duplicated files, overlapping docs, drift between sources, or ambiguous single-source-of-truth.

- **0% RD** → no dent (smooth edge).
- **50% RD** → moderate dent.
- **100% RD** → deep dent (strong penalty on apparent coverage for that dimension).

**Why?** High metric values can hide duplication/entropy. Dents subtract *signal quality* from *raw quantity* so the perimeter shape shows where consolidation is needed.

**Inputs (per axis):** If `admin/metrics/metrics.json` has an `rd` object (e.g., `{ "CI": 0.1, "COV": 0.3 }`), those values are used. Otherwise v1.1 assumes 0 (or a mild uniform dent if `duplication_ratio` exists).

**Formula:** `radius = base_radius × (1 − 0.15 × blended_rd)`. RD is blended around each axis with a Gaussian so notches look organic.
