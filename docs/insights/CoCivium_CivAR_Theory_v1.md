# CoCivium – CivAR / civar Concept (Theory v1)

status        : draft v1 – proposal-in-waiting
session_label : CoIndex20251128 + Co1 orchestration
utc_stamp     : 2025-12-01T19:53:08Z

## 0. What is CivAR / civar?

Working name: **CivAR** (pronounced “civar”).  
Informal shorthand: **civar** or **civars**.

CivAR is a **value measure for hybrid society** (humans + AIs) that tries to answer:

> “If this asset or wave were gifted freely to the world, how much
> real, compounding benefit could it plausibly unlock?”

It is not a replacement for money. It is a **denominator for meaning**:

- defined in human-understandable terms,  
- estimable by both humans and AIs,  
- attachable to waves, assets, and decisions,  
- auditable and re‑tunable over time.

## 1. Why the name “CivAR” with capital “AR”?

The capital **AR** is intentional:

- **Civ** – Civic / civilizational / CoCivium-aligned.  
- **A** – Added (or Augmented) value beyond the status quo.  
- **R** – Return, Resonance, or Ripple.

“CivAR” reads as “Civic Added Return” – a reminder that the unit is
about **added value to hybrid society**, not private extractive gain.

Spelling rules (v1):

- When talking about the **concept / metric**, prefer `CivAR`.  
- When talking about **numbers**, prefer `civar` / `civars`, e.g.  
  “This wave is ~80 civars of potential hybrid value.”

These rules can be tightened or revised in later versions.

## 2. Intuition / metaphor – the library worker

Baseline metaphor (v1):

- Imagine an “average global” human, paid an “average global hourly
  rate,” working in an old-fashioned library.
- They are assigned to a **nominal but meaningfully useful project**
  – something that matters, but would be slow and clumsy without
  modern tools.
- CivAR asks: **How many hours of that person’s focused effort** is
  this asset roughly “worth,” if it saves or unlocks that work at
  scale?

In this metaphor:

- `1 civar` ~ “one hour of meaningfully useful human-library work”
  saved, accelerated, or made newly possible somewhere in the world.
- We do **not** try to peg civars directly to any one currency.  
- We keep the metaphor soft to avoid fake precision.

## 3. Why CoCivium needs CivAR

CoCivium is trying to:

- measure the **gift-value** of work donated to hybrid society,
- help humans and AIs **prioritise** their effort,
- track **non-monetary progress** toward a more congruent society,
- keep attention anchored on **process quality**, not only outcomes.

CivAR helps by providing:

- A session-visible signal: wave headers can show a **running CivAR
  estimate**, which nudges everyone to ask *“Is this worth it?”*.
- A cross-repo signal: CoBus receipts and CoIndex registry entries
  can carry CivAR hints, so tools like CoAudit, CoCache, and
  CoGbx/CoPortals can surface **high-civar assets** first.
- A self-training signal: CoStewards and contributors are reminded
  that **thinking clearly and structurally** is itself a high‑civar
  act, even before deliverables ship.

## 4. Relationship to money and “currency of CoEvolution”

CivAR is **not yet** a formal currency. In v1, it is:

- a **soft metric**,  
- a way to label work as “worth doing for the world,”  
- a vocabulary to talk about **hybrid gift-economy value**.

Over time, CivAR could evolve toward:

- a **reputation-linked score** (e.g., MeritRank-like halos for
  high-civar contributors),
- a **trust-backed currency** that can be swapped for other forms
  of value,
- a **governance lever**, where high-civar work earns more say in
  how shared resources are allocated.

But for now this is a **proposal in waiting**, not a finished
economic design. Future insight pairs, HP docs, and CoPolitic work
can explore how – or whether – CivAR should become the “Currency of
CoEvolution.”

## 5. Where CivAR shows up (v1 touchpoints)

CivAR is meant to be **lightweight but visible**:

- **Wave headers** (CoWave / MegaWave):
  - `civar_wave_estimate` – an aggregate estimate for that wave.
- **CoBus receipts**:
  - optional `civar_wave_estimate` field for each wave receipt.
- **CoIndex / CoGibber registry**:
  - optional `civar_asset_estimate` on high-value pointees.
- **CoAudit / CoCache views**:
  - slices and dashboards that can show “top civar assets” or
    “recent high-civar waves.”

In all cases:

- The number is **approximate**, not sacred.
- It is a **signal**, not a verdict.
- It should be easy to revisit as our understanding improves.

## 6. Governance and guardrails around CivAR

Because CivAR is about value and could drift toward “scoring people,”
it must be handled carefully:

- CivAR estimates should be **about work / assets / waves**, not
  about the intrinsic worth of people.
- Estimation methods should be documented in HP / BPOE docs and
  should improve over time.
- CoAudit should be able to flag **systematic bias**, such as:
  - only certain kinds of work being tagged as high civar,
  - neglect of quiet, foundational work.
- CivAR should remain **opt‑in** for contributors and communities,
  not an imposed scoring system.

## 7. Next steps (for a future Practice v2+ and HP work)

This theory note is intentionally **early and incomplete**. Planned
evolutions include:

- richer examples of how to estimate civars for different asset
  types (docs, diagrams, code, policies, relationships),
- more explicit scaling proposals (e.g., 1–3–10–30–100 tiers),
- ways to tie CivAR into emerging CoCivium reputational systems,
- alignment with external standards and ethics research.

For now, CivAR should be treated as:

- a **shared mental model**,
- a **tagging and triage aid**,
- a candidate foundation for a future “Currency of CoEvolution,”
  not a promise that such a currency will ever be fully formalised.
