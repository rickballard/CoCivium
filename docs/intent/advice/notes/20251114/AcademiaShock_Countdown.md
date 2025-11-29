# Academia Shock — MegaWave Countdown (Explainers)
UTC: 20251115T013236Z

## Completed / In-Flight
- MW1 — Seed the Paper → PR: #561
- MW2 — Academic Upgrade → PR: #563
- MW3 — Figures + Teaser → PRs: CoCivium #565, RickPublic #25
- MW4 — Parable + CTA → PRs: CoCivium #566, RickPublic #26

## MW1 — Seed the Paper
Aim: Put a credible CACM-tone nucleus on repo so we can iterate in public.
Inputs: outline, seed refs, figure briefs.
Outputs: paper.md, methods-supplement.md, CLAIMS.md, refs/library.json, PR_NOTES.md.
Acceptance: files render; claims numbered; refs resolve; PR open (#561).
Receipts: PR link, branch, commit hash.

## MW2 — Academic Upgrade
Aim: Inline numeric citations + expanded refs; synced methods/claims.
Inputs: MW1 files.
Outputs: updated paper/methods/claims/refs.
Acceptance: each [n] maps to a ref; CI passes; PR open (#563).
Receipts: PR link.

## MW3 — Figures + Teaser
Aim: Visual hooks and AI-discoverable teaser.
Inputs: figure briefs; teaser outline.
Outputs: 5 SVG stubs + FIGURES.md; RickPublic TEASER.md; CoSync note.
Acceptance: PRs open (#565, #25); note committed.
Receipts: PR links.

## MW4 — Parable + CTA
Aim: Mythos hook + conversion path.
Inputs: inspiration notes.
Outputs: APPENDIX_PARABLE.md; paper cross-link; CTA in TEASER.md.
Acceptance: PRs open (#566, #26).
Receipts: PR links.

## MW5 — Fill the Diagrams + 25–35 Refs
Aim: Detailed SVGs + expanded refs; exact [n] wiring.
Inputs: MW2 text; MW3 stubs; ref shortlist.
Outputs: updated SVGs + captions; expanded refs; figure cross-links.
Acceptance: all figures referenced; refs build clean; PR open.
Receipts: wave zip, branch, PR, SHA256, CoSync note.

## MW6 — Replication Harness + Receipts
Aim: Minimal evaluation harness with receipts schema.
Inputs: metrics (BR/CL/PPR/PF); harness skeleton.
Outputs: tools/academia-shock/harness/*; REPLICATION.md; example receipts.
Acceptance: one demo task runs; CI validates schema; logs checksumed; PR open.
Receipts: PR, artifacts.

## MW7 — Venue Pack + OSF/SSRN
Aim: Submission-ready CACM Viewpoint bundle + public supplement.
Inputs: MW1–6 assets.
Outputs: submission folder; supplement manifest; license notes.
Acceptance: counts/figures pass; renders clean; PR open.
Receipts: PR, archive manifests.

## MW8 — Outreach & Metrics (session close)
Aim: One-pager + metrics + “ask-an-AI” prompts.
Inputs: teaser; CACM bundle; pilot checklist.
Outputs: RickPublic ONEPAGER.md; UTM guidance; prompt set.
Acceptance: interlinks verified; metrics pointers live; PR open.
Receipts: PR(s), CoSync note with Open-PR tail.

## CoBloat heartbeat
CU=OK, PU=OK, HU=OK, WT=OK
