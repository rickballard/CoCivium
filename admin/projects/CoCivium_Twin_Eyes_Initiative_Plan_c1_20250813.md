# CoCivium Initiatives Plan — Scope Specification & Twin‑Eyes Diagram (c1)

**Purpose.** Deliver a scope specification and twin spider‑web diagrams that convey process health (left eye) and scope progress (right eye).  Improve onboarding and outreach while keeping GitHub‑rendered fallbacks safe.

**Lineage.** Derived from “CoCivium Initiatives Plan — Scope Specification & Twin‑Eyes Diagram” (2025‑08‑13).

**Maintainer.** Admin Council (HumanGate) until delegated to CoCivAI Circle.  

**Status.** Draft for Review (HumanGate).  

**Audience.** Repo maintainers, comms, and contributors.  

**Version.** c1 • 2025-08-13 • CID: TBD

---

## 1. Objectives

1. Publish `docs/scope_specification.md` (public‑facing) and supporting crosswalk data.  
2. Add twin eyes to the landing page: **metrics.svg** (left) and **scope.svg** (right).  
3. Provide JSON star sets and a Pages‑only shimmer/tooltip layer, with README‑safe static SVGs.

---

## 2. Deliverables (files and paths)

- `docs/scope_specification.md` (public).  
- `site/eyes/metrics.svg` and `site/eyes/scope.svg` (static).  
- `site/eyes/stars.metrics.json`, `site/eyes/stars.scope.json` (curated highlights).  
- `site/eyes/README.md` (workflow).  
- `ci/linkcheck.yml` (fallback integrity).

---

## 3. Acceptance Criteria

- README renders both eyes from committed SVGs without JS.  
- GitHub Pages enhances with shimmer + tooltips if JS/CSS load; README remains accessible.  
- Broken/moved targets do not 404 the page; stars degrade gracefully.  
- Scope doc links appear in README lede and in “Start Here.”

---

## 4. Tasks

1. Lock metric and theme labels; define abbreviations ≤4 chars for spokes.  
2. Draft `docs/scope_specification.md` and machine‑readable crosswalk.  
3. Design eye geometry to match existing spider style; export static SVGs.  
4. Curate 6–10 “stars” per eye by significance and recency.  
5. Implement Pages shimmer + tooltips.  
6. Add link‑check CI and fallback logic.  
7. Document star curation in `site/eyes/README.md`.

---

## 5. Data Schemas

**Star JSON (example).**
```json
{
  "stars": [
    {"spoke":"CI","r":0.72,"href":"docs/ci/overview.md","label":"CI overhaul PR#45"},
    {"spoke":"DTI","r":0.40,"href":"docs/specs/dti_v1.md","label":"DTI v1 draft"}
  ]
}
```

**Crosswalk CSV (columns).**
```
theme,layer,artifact,readiness
Principles & Rights,0,docs/charter/cc.md,RL2
Decision Frameworks,2,docs/specs/cps.yaml,RL2
...
```

---

## 6. Fallback and Integrity

- **No‑JS fallback.** README always displays static SVGs.  
- **Missing targets.** Stars without valid `href` render without link styling.  
- **CI link‑check.** Nightly job fails softly by opening an issue labelled `eyes-broken-link` with a diff of failures.  
- **SVG hygiene.** No remote assets; fonts default to system sans‑serif.

---

## 7. Risks and Mitigations

- **Visual clutter.** Strict cap on stars (≤10/eye); abbreviations enforced.  
- **Drift from reality.** Treat stars as editorial; require PR label `eyes-star` and 2 reviewers.  
- **Over‑engineering.** Keep Pages layer optional; prefer static assets first.  
- **Accessibility.** Provide alt text and long‑desc notes; ensure color‑contrast in SVG.

---

## 8. Timeline (post‑migration)

- **Day 1:** Draft scope spec, internal review.  
- **Day 2:** Finalize public version; integrate excerpts to README.  
- **Day 3–4:** Design eyes; curate star sets.  
- **Day 5:** Pages interactivity; CI link‑check live.

---

## 9. Governance

- Both artifacts governed by HumanGate.  Scope major revisions require assembly‑level approval once constituted.  Eye updates require labelled PR and review.

---

### Footer (standardized)

DocType: Informative  •  Layers: N/A (planning)  •  Version: c1 (2025-08-13)  •  CohNote: Coherence tag **_c1_**; supersede via **_c2_** with a clear changelog.  Hash: TBD.
