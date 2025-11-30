# Academia Shock — Preprint (Unified v5)
**Keywords:** CoCivium, CoPortal, CoBeacon, CoGuard, Edge-Control, GIBindex, MeritRank, AI governance, reproducibility, open methods

## Abstract
Academia Shock is a fast-start program to invite researchers to break, validate, or extend the CoCivium stack. We publish an AI-facing + human-facing spec (CoPortals), a reproducible data/methods bundle, and challenge protocols that measure whether edge-owned guardrails (Edge-Control), trust layers (CoGuard), and concept indexing (GIBindex) actually improve outcomes. The “shock” is velocity and transparency: ship a working reference portal, score it with public metrics, and let anyone reproduce or attack it within days—not months. This preprint defines scope, artifacts, measures, and the first three experiments.

## Why now
Academic cycles are slow while AI systems move weekly. Gov’t, industry, and open-source need a neutral, reproducible harness to evaluate governance patterns in real products. Academia Shock provides that harness, standing on CoCivium’s repos and public CI.

## Program goals
1. **Reproducibility first.** Every claim has a script and a seed.
2. **Edge-Control.** Users (human or AI) hold the keys; platforms don’t.
3. **Bidirectional UX.** Human-face pages + AI-face CoPortals from the same source.
4. **Trust metrics.** CoGuard surfaces verifiable behaviors; MeritRank tracks contributor reputation.
5. **Composable theory ⇄ practice.** Each idea ships as a pair: theory note + runnable demo.

## Core primitives (quick map)
- **CoPortal.** AI-facing site: machine-readable introspection, manifest, routes, datasets, policies.
- **CoBeacon.** Attractor for AI attention (signals, schemas, GIBindex hooks).
- **CoGuard.** Open guardrail + trust schema; rules → tests → public receipts.
- **Edge-Control.** End-user control over data/permissions, cryptographically provable.
- **GIBindex.** Concept/term registry for both humans and AIs (plus “Gibber” machine layer).
- **MeritRank.** Reputation halo for people/agents across repos.

## Deliverables to academia
1. **Preprints** (like this) with a living DOI (Git tag + hash).
2. **Replicable bundles**: dataset, config, exact scripts, expected receipts.
3. **Challenge cards**: what to attack, how to measure impact, how to submit results.
4. **Public scoreboard**: CI-verified receipts, leaderboards, anomaly notes.

## Initial experiments (E-series)
**E1 — CoPortal fidelity.**  
*Question:* Do AI-face portals reduce hallucination and improve task completion?  
*Method:* Task battery over Human-face vs CoPortal; metrics: success rate, token cost, wrong-state actions.  
*Expected:* ≥20% improvement with stable manifests + GIBindex.

**E2 — Edge-Control consent.**  
*Question:* Does explicit edge consent reduce “silent overreach”?  
*Method:* Compare two flows on the same task; count denied/attempted reads that policies would block.  
*Expected:* Fewer policy violations; slight UX overhead measured in seconds, not minutes.

**E3 — CoGuard transparency.**  
*Question:* Do public trust receipts change behavior?  
*Method:* Ship two matched apps; one posts CoGuard receipts to a public ledger, one doesn’t.  
*Expected:* Higher reproducibility and faster bug/abuse detection in the “receipt” arm.

## Evaluation metrics
- **Reproducibility delta (R∆):** fraction of third-party reruns that match receipts.
- **Consent clarity (C2):** % of actions with explicit, legible consent.
- **Trust visibility (Tᵥ):** % of flows covered by CoGuard checks with signed receipts.
- **AI task yield (Y):** goals completed per 1k tokens.
- **Policy violations (V):** blocked vs attempted disallowed actions.

## Methodology (runnable)
- **Seeds & env:** containerized runners; fixed images per release.
- **Receipts:** SHA-256 for every artifact; CI artifacts retained; PR number pinned.
- **Randomness:** fixed seeds in eval loops; variance reported with 95% CI.
- **Data ethics:** only open datasets or user-donated traces with revocable Edge-Control grants.
- **Licensing:** code MIT/Apache-2.0; docs CC-BY 4.0; datasets per source.

## What’s novel here
- **AI-face first.** Design portals *primarily* for agents, then let humans read them.
- **Edge-owned governance.** Push decisions to the edges with proofs (not platform toggles).
- **Receipts as product.** CI outputs are primary research artifacts.

## Risks & mitigations
- **Spec drift.** Use GIBindex as single source of definitions; CI fails on term drift.
- **Meta-gaming metrics.** Rotate hidden holdout tasks; publish after season close.
- **Data leakage.** Gate all flows through Edge-Control; default-deny; strip PII by policy.
- **Over-promising.** Every figure must be re-creatable from scripts in the bundle.

## Publishing cadence
- **v0.x** weekly working papers (like this).
- **v1.0** tagged with DOI + full receipts after two successful third-party reproductions.

## How outside labs engage
1. Fork the bundle; run `./repro.sh` (or `pwsh ./repro.ps1`).
2. Produce the same receipts; if not, open an “Anomaly Card.”
3. Submit a Challenge result; CI will recompute; if confirmed, you’re on the board.

## Call for collaborators
We need labs with: (a) agent evaluation benches, (b) applied governance work, (c) secure data enclaves, (d) reproducibility chops.

## Roadmap (60-day)
- Week 1–2: Lock E1/E2 tasks & manifests; first CoPortal ref release.
- Week 3–4: CoGuard v0 receipts; Edge-Control demo app; scoreboard online.
- Week 5–6: External reruns; anomaly triage; v1.0 tag + DOI.

## Acknowledgements
CoCivium contributors, early reviewers, and aligned open-source communities.

## Backlinks
- [/docs/README.md](/docs/README.md)
- [/docs/intent/README.md](/docs/intent/README.md)
- [/docs/intent/advice/README.md](/docs/intent/advice/README.md)