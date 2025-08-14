# CoCivium Scope Specification (c1)

**Purpose.** Define the boundaries, priorities, and milestones for CoCivium’s initial phases.  Serve as both an internal roadmap and a public‑facing invitation for contributors.

**Lineage.** Derived from “CoCivium Scope Specification — Skeleton Draft” (2025‑08‑13).

**Maintainer.** Admin Council (HumanGate) until delegated to CoCivAI Circle.  

**Status.** Draft for Review (HumanGate).  

**Audience.** Contributors, advisors, and partners across social sciences, policy, and engineering.  

**Version.** c1 • 2025-08-13 • CID: TBD

---

## Contents
1. Vocabulary and Scales  
2. In‑Scope Themes (Spokes)  
3. Out‑of‑Scope (Initial Phases)  
4. Dependencies and Crosswalk  
5. Phase Objectives and Triggers  
6. Review and Governance  
7. Marketing and Onboarding Integration  
8. Evolution Clause  

---

## 1. Vocabulary and Scales

**Theme (Spoke).** A coherent area of work tracked on the scope “right‑eye” spider diagram.  Each theme maps to one or more layers of the classification hierarchy.

**Layer (0..4).**  
- **Layer 0 — Charter (normative).** Cognocarta Consenti (CC).  Principles, rights, limits on power.  
- **Layer 1 — Operating Constitution (normative).** Org structure, roles, assemblies, budgets, appeals.  
- **Layer 2 — Process Specs (normative/technical).** YAML/JSON canonical flows and state machines.  
- **Layer 3 — Policies & Standards (informative).** Domain rules, safety playbooks, procurement.  
- **Layer 4 — Implementations (informative).** Adapters, identity providers, funding rails, CI, dashboards.

**Readiness Level (RL).** RL0 Concept → RL1 Draft → RL2 V1 → RL3 Iterating → RL4 Mature.  Readiness is recorded per theme×layer pair.

---

## 2. In‑Scope Themes (Spokes)

> Short labels shown in **bold**.  Brackets list principal layers and target readiness this phase.

1. **Principles & Rights** — Layer 0/1 (target RL2).  Consolidate rights, limits, amendment wall.  
2. **Decision Frameworks** — Layer 2 (target RL2).  Lifecycle from proposal → deliberation → vote (QV/QF/etc.) → execution.  
3. **Ethical AI Integration** — Layer 1/3 (target RL2).  Guardrails, model‑use policy, audit hooks.  
4. **Transparency & Oversight** — Layer 1/3 (target RL2).  Records, DRs, public logs, appeals.  
5. **Reference Domains** (economy/health/education/justice/security) — Layer 3 (target RL1).  Minimal exemplars, not doctrine.  
6. **Identity & Voting** — Layer 2/4 (target RL1).  Pluggable identity, eligibility proofs, coercion‑resistant voting adapters.  
7. **Contributor Experience** — Layer 3/4 (target RL3).  Onboarding, templates, CI, docs architecture.  
8. **Sustainability & Funding** — Layer 3 (target RL1).  Non‑capture funding rails, disclosure norms.  
9. **Tools & Infrastructure** — Layer 4 (target RL2).  GitHub automations, link‑check, pages, observability.  
10. **Interoperability & Standards** — Layer 2/3 (target RL1).  Schema registry, export formats, API contracts.

---

## 3. Out‑of‑Scope (Initial Phases)

1. Partisan or doctrinal policy positions beyond illustrative domain exemplars.  
2. Binding endorsements of a single software stack or identity provider.  
3. Real‑money treasury mechanics beyond mocks/sandboxes.  
4. Production deployment promises to specific jurisdictions.  
5. Biometric data collection or any privacy‑sensitive identifiables.

---

## 4. Dependencies and Crosswalk

Create a machine‑readable table (CSV/JSON) that maps **Theme → Layer(s) → Artifacts → Readiness**.  Use the table to auto‑draw the right‑eye diagram and to gate releases.  Example rows:

| Theme | Layers | Key Artifacts | RL |
|---|---|---|---|
| Principles & Rights | 0,1 | CC charter text; amendment wall | RL2 |
| Decision Frameworks | 2 | CPS.yaml; statecharts; test vectors | RL2 |
| Transparency & Oversight | 1,3 | Appeals flow; DR template; logs spec | RL2 |

---

## 5. Phase Objectives and Triggers

- **Phase 1 — Crown Jewel Delivery.** Public README narrative, CC Charter (L0) at RL2, CPS baseline (L2) at RL2, contributor templates and CI at RL3.  **Exit trigger:** both eyes show ≥60% median spoke readiness.  
- **Phase 2 — Sustainability Launch.** Funding rails (mock), governance rituals, growing contributor base.  **Exit trigger:** 3+ adapters live, 1+ pilot.  
- **Phase 3 — Systems Integration.** Adapters to Decidim/pol.is/others; schema registry online.  
- **Phase 4 — Global Engagement.** Translation cadence, advisory network, pilot reports.

---

## 6. Review and Governance

- Maintainer proposes changes via PR tagged `scope-spec`.  HumanGate approval required.  
- Quarterly review cadence.  Each release notes a **Scope Changelog** with rationale and impacts.  
- Normative edits to Layers 0–2 require assembly‑level supermajority once constituted.

---

## 7. Marketing and Onboarding Integration

- Surface a 30‑second **Why/Who/How** triad near the README lede.  
- Link **Start Here** and the latest release.  
- Use scope summaries in outreach posts and contributor issues.

---

## 8. Evolution Clause

This document is **Informative** until ratified.  Normative sections will be explicitly labeled and versioned.  Breaking changes must include a migration note and deprecation window.

---

### Footer (standardized)

DocType: Informative (pre‑ratification)  •  Layers: 0–4 (see mappings above)  •  Version: c1 (2025-08-13)  •  CohNote: Coherence tag **_c1_**; supersede via **_c2_** with a clear changelog.  Hash: TBD.
