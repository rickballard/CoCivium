# CoEthics Product Seed (v0) — Spend Better Money, Spend Better Attention

- **Status:** draft / v0
- **Scope:** free-to-world concept seed (not yet a full app)
- **Backbone:** CoEthicsGauge v0 + CoEthics IntegrityMap Strategic Advisory Addendum

## 1. What CoEthics is for

CoEthics exists to help people aim their **money** and **attention** at
brands and content that better match their values.

Early focus:

- **Cash** — where you spend your dollars:
  - retailers, brands, platforms, funds.
- **Viewing time / attention** — where you spend your hours:
  - streaming, social, podcasts, news, creators.

The goal is not to be perfect or prescriptive, but to make it **easier
to choose “better enough” options** given constraints (budget, access,
habits).

## 2. How this ties to CoEthicsGauge

CoEthicsGauge v0 provides:

- A structured **log + schema** for ethics/impact entries.
- A **metrics library** and dashboard snapshot tooling.
- A way to attach **lenses** (e.g., democracy, climate, labour, DEI) to
  brands, sectors, regions.

This product seed treats CoEthicsGauge as the **engine**:

- CoEthicsGauge holds the **data + lenses**.
- CoEthics (product) handles **stories, UX, and “which choice is better?” flows**.

## 3. Early user journeys (v0)

### 3.1 Money: “Which brand deserves my dollars more?”

Example flows:

- Compare **Brand A vs Brand B** on:
  - Core price/value (rough bands only in v0),
  - Ethics lenses (using CoEthicsGauge entries),
  - Known red flags (controversies, governance failures).
- Suggest **“better swaps”**:
  - “If you currently buy X, here are 2–3 brands that may align better
    with democracy / climate / labour lenses, with rough pros/cons.”

### 3.2 Attention: “Which platforms/creators deserve my time?”

Example flows:

- See how a platform or creator scores on:
  - Misinformation / democracy,
  - Harassment / safety,
  - Transparency / governance.
- Generate simple “attention swaps”:
  - “You watch a lot of Y; here are alternatives that may be less
    harmful while still scratching a similar itch.”

## 4. What v0 could actually ship (free to world)

For a first public artefact (even before any app):

- A **static, shareable doc or microsite** that:
  - Explains CoEthics + CoEthicsGauge in plain language.
  - Shows a few **worked examples** of better money/attention choices.
  - Links clearly to:
    - CoEthicsGauge README,
    - CoEthics advisory addendum,
    - Academia Shock ↔ CoEthicsGauge linkage (for deeper context).

- Optionally, a **simple “scorecard” format**:
  - Markdown/CSV templates that others can fork and fill in.
  - Makes it easy for activists / analysts to contribute evaluations
    before any full-blown database or UI exists.

## 5. Design principles (v0)

- **Transparent, not mystical** — show how scores/flags are derived.
- **Lens-based** — make it explicit which lens is being used (e.g.,
  “Democracy-first 2025” vs “Climate-first 2025”).
- **Edge-owned** — keep data and tooling in repos (CoCivium, CoEthicsGauge)
  so communities can fork, audit, and extend.
- **Free-to-world** — default licensing posture:
  - Likely an OSS license (MIT/Apache/AGPL/TBD),
  - With a clear statement that public access and forkability are part
    of the design, not an afterthought.

## 6. Next steps (beyond this session)

- Decide on **canonical name** and tagline for the consumer-facing layer
  (may remain “CoEthics” or gain a sub-brand).
- Draft a **public-facing landing page** outline under CoCivium or
  CoPolitic (e.g., “Spend better money. Spend better attention.”).
- Define 2–3 **example scorecards**:
  - One “money” example (brands/retail),
  - One “attention” example (platforms/creators),
  - One “mixed” example (e.g., streaming platforms with both money and
    attention dimensions).
- Wire future waves:
  - data model extensions in CoEthicsGauge,
  - simple UI prototyping (could be static site, CoPortal, or app later).

This document is intentionally lightweight but opinionated, so future
waves and contributors have something solid to react to.
