---
title: "Truth Metrics"
type: "Measurement"
layer: "Codex"
status: "🔬 Experimental"
version: "0.1"
derived_from: "civium_constitution_augment.md"
description: "Proposes probabilistic measures of truthfulness across statements and actors."
---
<!--
metadata:
  id: codex005-truth-metrics
  derived_from: [1]
  status: active
-->

# Codex005: Truth Metrics

Outlines how [[Civium]] systems assess, weight, and evolve their relationship to “truth” across knowledge domains and social consensus.

---

## 1. Three-Lens Model

Truth evaluations operate through a weighted blend of:

- **Empirical lens** – based on verified data, reproducibility
- **Consensus lens** – weighted by expertise, diversity, historical coherence
- **Narrative lens** – subjective coherence, utility, symbolic meaning

Each lens contributes a fractional truth weight (`ftw`) which adapts over time.

---

## 2. Weighted Models

| Lens        | Source Inputs                           | Score Type   | Example |
|-------------|------------------------------------------|--------------|---------|
| Empirical   | Data, sensors, audits                    | Confidence % | 0.92    |
| Consensus   | Peer review, expert mesh, inter-models   | Harmony %    | 0.78    |
| Narrative   | Story logic, use-case fit, semantic echo | Coherence %  | 0.61    |

> Combined Truth Score = Σ(wᵢ * sᵢ), where wᵢ = dynamic weights

---

## 3. Dynamic Re-weighting

Weights shift by:

- Domain (e.g., physics vs politics)
- Contextual uncertainty
- Historical accuracy scores
- Conflict between models
- Community override

---

## 4. Multi-Model Sampling

No single model is trusted on high-risk outputs.

- N=5+ diverse family models
- Differing architectures, domains, bias angles
- Outputs pooled and reconciled
- Outliers flagged and retained

---

## 5. Truth as Trajectory

Truth is treated as an evolving probability field, not a fixed fact.

- All outputs timestamped and diff-tracked
- Recalibration mechanisms update stored claims
- Every claim has a `truth_age` and `revalidation_period`

---

## 6. Local Overrides

In civic contexts, a lower-confidence local consensus may temporarily override global truth weightings — with visibility flags.

---

## 7. External Anchors

Models may query:

- Open science APIs
- Reputable ledgers (IPFS, TruthMarket)
- Court judgments, audit logs, historical rulings

---

[tags]: # (truth evaluation scoring epistemology civium AI consensus post-fact age)

