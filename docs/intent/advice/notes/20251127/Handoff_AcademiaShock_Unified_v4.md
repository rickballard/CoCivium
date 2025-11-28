# Handoff — “Academia Shock” → CoIndex Orchestration (via CoSync bus)
UTC: 20251128T013055Z

## What
Unifying the “Academia Shock” effort under **CoIndex**. **CoTrove** (theories/quotes/data/methods), **CoTheories** (formal frames), and the **CoCivium** paper now hand off workflows to **CoIndex**. Routing is via **CoSync bus** until CoIndex is free.

## Why
The v1 academic paper must carry a traditional, “thick” spine (citations, math, methods) and reproducible evidence:
- **CoTrove** — structured intake JSON (schema) for theories/quotes/data/methods
- **CoIndex** — AI-facing CoPortal entry + cross-repo discovery
- **CoCivium** — paper scaffold (AcademicShock_v1.md), efs.bib, figures
- **CoTheories** — definitions, lemmas, proofs

## Next
- **CoIndex**: own orchestration; watch tag cademia-shock; wire sources into the portal entry; post ACK.
- **CoTrove**: add/validate intake JSONs (schema); tag cademia-shock; link datasets/audits.
- **CoTheories**: push formal definitions/lemmas/proofs; cross-reference CoTrove ids.
- **CoCivium**: expand v1 with CoTrove citations + CoTheories math; grow efs.bib; add figures/pseudocode/tests.

## Outstanding directions
- Convert CoTrove intake → efs.bib + inline citations.
- Add figures (governance equilibria; CiviProof pipeline).
- Add MeritRank update + CiviProof validation pseudocode/tests.
- Draft 90-day pilot doc (dept): metrics = reproducibility Δ, time-to-proof, MeritRank Δ.

## CoSync / ACK
- This note rides the **CoSync bus**. Upstream sessions terminate only after:
  - **ACK(CoIndex)**: “Handoff received; portal wired; tag cademia-shock active.”
  - **ACK(Co1)** (optional): “Observed; merge criteria unchanged.”
- Receipts = PR links, branch names, file paths, SHA-256 if applicable.

## Pointers (CoIndex portal entry)
- repo:CoCivium/docs/academia-shock/WhitePaper/AcademicShock_v1.md
- repo:CoCivium/docs/academia-shock/WhitePaper/refs.bib
- repo:CoTrove/docs/INTAKE/items
- (opt) repo:CoTheories/docs/*
