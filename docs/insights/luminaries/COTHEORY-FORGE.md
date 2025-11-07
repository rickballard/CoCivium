# CoTheory Candidate — Multi‑Method Forge

We evolve CoTheory via **braided methods**. Each method outputs artifacts tied to guardrails and metrics.

## A) Canon Sweep & Crosswalk
- Build a cross-cultural canon (Greece–India–China–Islamic–African–Indigenous–Modern science/philosophy).
- Map each source to **ontology, knowledge norm, value stance, method of dispute resolution**.
- Deliverable: `canon/crosswalk.csv` + `canon/notes/*.md`

## B) Normative Axes Radar
- Axes: {harms, consent, reversibility, legibility, pluralism, entropy, dignity}.
- Score proposals (0–5) with rubric; store as JSON (`radar/*.json`).
- CI renders a radar chart per proposal (stub now; hook later).

## C) Argument Maps (Debate Graphs)
- Represent claims as graphs (nodes = claims/evidence; edges = support/attack).
- Export Graphviz `.dot` and Mermaid for docs.
- Deliverable: `debate/maps/*.md`, `.dot`

## D) Formalization Stubs
- Try to phrase guardrails in modal/spec form (▲ possibility, □ necessity).
- Keep stubs modest; link to evidence objects.
- Deliverable: `formal/*.md`

## E) Scenario Labs (Playbooks & Sims)
- “What if” playbooks with objective metrics and bounded risk.
- Deliverable: `labs/*/playbook.md` + `labs/*/metrics.json`

## F) Agent Trials (Sandboxes)
- Run governance patterns with agents (human/bot) in constrained sandboxes.
- Deliverable: `trials/*/protocol.md` + `trials/*/results.md`

## G) Civic Trials (Field Tests)
- Limited pilots with **objection windows** and **rollback rehearsals**.
- Deliverable: `civic/*/plan.md` + harms ledger.

Each braid is versioned, audited, and scored against the **Compact** metrics.
