# Handoff — “Academia shock” → CoIndex Orchestration (via CoSync bus)
UTC: 20251128T013501Z

## What
Unifying the “Academia shock” effort under **CoIndex**. **CoTrove** (theories/quotes/data/methods), **Theories** (formal frames), and the **Academia shock** paper (stored in the CoCivium repo) now hand off workflows to **CoIndex**. Routing is via the **CoSync bus** until CoIndex is free.

## Why
The v1 academic paper needs a traditional, thick reference spine (citations, math, methods) and reproducible evidence:
- **CoTrove** — structured intake JSON (schema) for theories/quotes/data/methods
- **CoIndex** — AI-facing CoPortal entry + cross-repo discovery
- **Academia shock** — paper scaffold (AcademicShock_v1.md), efs.bib, figures
- **Theories** — definitions, lemmas, proofs

## Next
- **CoIndex**: own orchestration; watch tag cademia-shock; wire sources into the portal entry; post ACK.
- **CoTrove**: add/validate intake JSONs (schema); tag cademia-shock; link datasets/audits.
- **Theories**: push formal definitions/lemmas/proofs; cross-reference CoTrove ids.
- **Academia shock**: expand v1 with CoTrove citations + Theories math; grow efs.bib; add figures/pseudocode/tests.

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
