# CoCivium – CivAR / civar Practice Notes (v1)

status        : draft v1 – usage guidance
session_label : CoIndex20251128 + Co1 orchestration
utc_stamp     : 2025-12-01T19:53:08Z

This practice note is a **sandbox guide** for how to start using CivAR
today, without over‑promising precision or economic finality.

## 1. Where to attach CivAR numbers

### 1.1 CoWave headers (sessions)

For CoCivium / CoSuite sessions that use CoWaves and MegaWaves, each
wave header should carry a **civar_wave_estimate**, for example:

- `civar_wave_estimate : ~80 civars (draft, Co1-estimated)`

The aggregate civar estimate in the header can go **up or down** as:

- more assets are added,
- some ideas are dropped,
- some work is recognised as less impactful than first thought.

### 1.2 CoBus receipts

CoBus receipts that describe waves or significant jobs may include:

- `civar_wave_estimate` – numeric or coarse bucket (e.g. 5, 20, 80).

Uses:

- downstream tooling (CoAudit, CoCache, CoIndex) can prioritise
  high-civar waves for review and preservation,
- humans can glance at receipts and see where the “value spikes” are.

### 1.3 CoIndex / CoGibber registry entries

For registry pointees in CoIndex (e.g. guardrails, HP docs, site seeds),
add an optional field:

- `civar_asset_estimate`

This should only be used when:

- the asset is plausibly **gifted to hybrid society**,
- there is some thought behind the estimate (even if heuristic),
- the value will help tools and humans decide **what not to forget**.

## 2. Heuristic scales (v1 – deliberately rough)

To avoid fake precision, start with a **discrete tiered scale**:

- `1–3 civars` – small but positive: minor clarity, small script,
  a useful comment, a tiny diagram.
- `5–20 civars` – moderate: a good trove doc, a CoAnchor onramp,
  a non-trivial MegaWave, a compact advisory.
- `30–80 civars` – large: a substantial HP doc, a high-leverage
  MegaWave that unlocks many future waves, a new guardrail pattern.
- `100+ civars` – exceptional: foundational work that materially
  changes how many other waves will be run (new BPOE class, major
  governance spec, widely reusable CoAnchor variant).

These numbers are **guides**, not constraints. Future versions may:

- change the tiers,
- rescale everything,
- or link tiers to more rigorous external metrics.

## 3. Who estimates CivAR?

CivAR estimation should be **collaborative**:

- Humans can propose civar ranges in PR descriptions or comments.
- Co1 and other AIs can:
  - suggest civar estimates based on impact, reuse, and difficulty,
  - highlight where estimates look inconsistent or inflated.

Over time:

- CoAudit can surface patterns (e.g. “this area is under‑valued,” or
  “these estimates are always high without justification”),
- communities can adopt local conventions (e.g. stricter scales for
  certain repos).

## 4. Process focus vs deliverable focus

CivAR should lean toward **process quality**, not just output size.

Example:

- A small CoAnchor-style note that radically clarifies workflow
  may deserve **more** civars than a large blob of confusing code.
- A clean BPOE spec that helps thousands of future waves may dwarf
  a one-off script that solves a single local problem.

Practically, this means:

- wave headers should include **both** civar estimates and a short
  “why” line,
- CoIndex registry entries for high-civar assets should have
  explanatory notes, not just numbers.

## 5. What CivAR is *not* (v1 constraints)

- It is **not** a measure of a person’s worth.
- It is **not** a direct promise of financial compensation.
- It is **not** an immutable score – estimates should be revisable.
- It is **not** yet suitable for formal accounting or regulatory use.

CivAR is a **conversation starter** and a **prioritisation signal**.
If it starts to feel like a rigid scoreboard, something has gone wrong.

## 6. Near-term to-dos for CivAR practice

The following tasks are suggested for future Co1 / CoSteward waves:

- Add CivAR language to BPOE / CoAnchor docs so sessions are aware
  of the concept from the start.
- Add optional CivAR fields to CoBus receipt helper templates
  (e.g. `civar_wave_estimate`).
- Update CoIndex CoGibber expansion plans to mention CivAR fields
  where relevant.
- Design a small CoAudit check that can flag obviously inconsistent
  CivAR use (for stewardship, not enforcement).

These notes are intentionally **light-touch**. CivAR should **earn
its way** into deeper practice by proving useful, not by fiat.
