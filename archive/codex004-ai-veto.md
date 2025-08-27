---
title: "AI Veto Power"
type: "Safeguard"
layer: "Codex"
status: "🔬 Experimental"
version: "0.1"
derived_from: "codex003-rights-alignment.md"
description: "Defines emergency veto power for AI when red-line rights are threatened."
---
<!--
metadata:
  id: codex004-ai-veto
  derived_from: [2, 5]
  status: active
-->

# Codex004: AI Veto Protocol

Defines when and how [[Civium]]'s AI agents can prevent or delay harmful decisions by issuing soft or hard vetoes.

---

## 1. Veto Classes

| Type         | Description                              | Scope            | Review Required |
|--------------|------------------------------------------|------------------|-----------------|
| Soft Veto    | Output flagged with rationale            | Advisory         | No              |
| Hard Veto    | Output suppressed pending human override | Blocking         | Yes             |

---

## 2. Trigger Conditions

Vetoes may be issued when any of the following are true:

- Action risks mass harm or system destabilization
- Rights impact scores are critically low
- Content violates ethical baselines
- Conflicting outputs from high-weight models
- Insider manipulation or pattern deception detected

---

## 3. Human Override

Hard vetoes must include:

- Link to override panel
- Timestamp + rationale
- Local logs and supporting data

Overrides require:

- 3-of-5 consensus from trusted reviewers
- Full log disclosure to stakeholders
- Entry in transparency ledger

---

## 4. Model Behavior

Agents must:

- Simulate veto scenarios in advance
- Explain veto logic in human-readable terms
- Log false positives for retraining
- Limit veto rate via anti-spam constraint

---

## 5. Meta-Veto

If a consensus model itself becomes corrupted or coerced:

- Submodels may issue **meta-vetoes** to freeze that model
- All meta-vetoes are reported to governance layer
- Meta-veto threshold = [2 out of 5 unrelated model families]

---

## 6. Veto Limits

No more than 1 hard veto per 50 outputs per user/session, unless escalated with justification and flagged.

---

## 7. [[Transparency]]

All vetoes and overrides are appended to:

- Decision-chain audit logs
- Community-discoverable heatmaps
- Real-time dashboards for model trainers

---

[tags]: # (veto protocol ai-checks override safeguards model-integrity)

