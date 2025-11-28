# Handoff — Academia Shock -> CoIndex Orchestration (via CoSync bus)
UTC: 20251128T012322Z

## What
Unifying the "Academia Shock" effort under CoIndex. CoTrove (theories/quotes), CoTheories (formal frames), and the Academia Shock paper in CoCivium now hand off workflows to CoIndex. Routing occurs via the CoSync bus until CoIndex is free.

## Why
The academic v1 needs a thick literature spine (citations), formal math, and reproducible evidence:
- CoTrove: structured intake of theories/quotes/data/methods
- CoIndex: AI-facing CoPortal entries + cross-repo discovery
- CoCivium: paper scaffold, figures, refs
- CoTheories: definitions, lemmas, proofs

## Next
- CoIndex: own orchestration; watch tag cademia-shock; wire sources into portal entry.
- CoTrove: add intake JSONs (schema); tag cademia-shock; link datasets/audits.
- CoTheories: contribute formalism; cross-reference CoTrove ids.
- CoCivium: expand v1 with CoTrove citations + CoTheories math; keep efs.bib in sync.

## Outstanding directions
- Convert CoTrove intake -> refs.bib + inline citations.
- Add figures (governance equilibria; CiviProof pipeline).
- Define MeritRank update + CiviProof validation pseudocode/tests.
- 90-day pilot doc (dept): metrics = reproducibility delta, time-to-proof, MeritRank delta.

## CoSync / ACK protocol
- Posted via CoSync bus; sessions can terminate only after:
  - ACK(CoIndex): "Handoff received; portal entry wired; tag 'academia-shock' active."
  - ACK(Co1) (optional): "Observed; merge criteria unchanged."
- Receipts: PR links, branch names, file paths, and SHA-256 where applicable.

## Pointers for CoIndex portal entry
- repo:CoCivium/docs/academia-shock/WhitePaper/AcademicShock_v1.md
- repo:CoCivium/docs/academia-shock/WhitePaper/refs.bib
- repo:CoTrove/docs/INTAKE/items
- (opt) repo:CoTheories/docs/*
