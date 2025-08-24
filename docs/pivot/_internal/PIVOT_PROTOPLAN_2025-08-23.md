# PIVOT PROTOPLAN — v0.1 (Internal / Do Not Link)
**Purpose:** Park the minimum plan for the pivot so we can execute tomorrow without re-litigating scope.
**Public posture (unchanged during migration):** “Maintenance and housekeeping while preparing small, testable transparency and guardrail modules. Standards-anchored. Evidence-first.”

## Anchors
- Advisory PR: https://github.com/rickballard/CoCivium/pull/148  (migration/advisory-pivot-prep)
- Rule: No new ideas; no README polish until pivot. Keep CI/Pages green.

## 1) Objectives (next 7 days)
- Finish Grand Migration (structure clean, CI/Pages green).
- Prepare two founding modules (skeletons only): Emergency Guardrails; Open-Gov Transparency (DCAT/OCDS/BODS).
- Produce three internal proofs (no PR): 
  1) Evidence Table template (IRM-style) 
  2) Conformance Checklist template (YAML) 
  3) Crosswalk template (YAML)
- Draft **CC — Core Principles** (≤500 words) for later promotion.
- Prep InSeed commercial keel: boardroom workshop outline + micro-pilot SOW skeleton.

## 2) Tomorrow (T+1) — checklist
- [ ] Point the migration tab at PR #148 comment with marching orders (done).
- [ ] Create stubs (no links, no PR):  
      docs/pivot/_internal/Evidence_Table_Template.md  
      docs/pivot/_internal/Conformance_Checklist_template.yml  
      docs/pivot/_internal/Crosswalk_template.yml
- [ ] Draft docs/pivot/_internal/CC_Core_Principles_DRAFT.md (≤500 words).
- [ ] InSeed one-pager skeleton (local file; not in repo until later).

## 3) 7-Day Sprint plan (internal)
**D1–D2:** Stubs + CC Principles; pick sample data shape for validators (mock OK).  
**D3–D5:** Demo-only validators (DCAT/OCDS/BODS) on high-fidelity samples; Emergency checklist YAML + Risk & Abuse Register skeleton.  
**D6:** Reviewer shortlist (3–5); draft outreach notes.  
**D7:** Review + Gate check; decide if we start selling **training** (not pilot) next.

## 4) Decision Gates (ship/no-ship)
- **Gate-0 (Migration Done):** structural moves merged; CI/Pages green; root README archived; advisory satisfied.
- **Gate-1 (Internal Proofs):** templates exist; pass a DCAT/OCDS/BODS sample through validators locally; emergency checklist parses.
- **Gate-2 (Sales Ready):** InSeed workshop deck outline + micro-pilot SOW skeleton complete.
- **Gate-3 (Public Pivot PR Go/No-Go):** only after Gate-1 + two reviewer soft yes’s.

## 5) Messaging (use verbatim)
- One-liner: **“Maintenance & housekeeping while preparing small, testable transparency and guardrail modules. Standards-anchored. Evidence-first.”**
- Change explainer: “Less manifesto, more conformance and proof. We’ll publish modules mapped to open standards with validators — pass/fail visible in public.”
- Constitution Q: “Principles stay. Detailed clauses will track the working modules so practice leads text.”

## 6) Risks & counters
- Scope creep → park in _internal/ideas.md, not in PRs.  
- Premature exposure → no links to _internal/; no PR from this branch.  
- Merge friction → keep pivot work off main and off migration PRs.  
- Fatigue → no new Idea Cards; two modules only.

## 7) Next artifacts to create (internal, unlinked)
- Evidence_Table_Template.md (columns: Commitment | Evidence link | Updated | Status | Notes)
- Conformance_Checklist_template.yml (id | must[] | should[] | tests[])
- Crosswalk_template.yml (standard refs + equivalents + validation tools)
- CC_Core_Principles_DRAFT.md (≤500 words)
- InSeed_Workshop_Outline.md (local/private for now)

— End —
