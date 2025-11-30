# KingMaker Sanity Audit – Practice (v1)

This insight describes **how to use KingMaker** in practice as a
recurring red-team lens, while staying within safe, repo-appropriate
bounds.

## 1. When to run a KingMaker pass

Recommended triggers:

- When a major concept reaches "v1":
  - CoPortal patterns
  - CoIndex / GIBindex changes
  - CoArena / CoAgent product waves
- When a governance or org pattern is about to be socialised:
  - CoNeural / CoScend org designs
  - Contributor / Steward accords
- When external conditions shift:
  - new regulations,
  - major AI platform changes,
  - visible authoritarian misuse risks.

For small changes, do a light pass (a page or two of notes).
For big pivots, schedule a deeper review.

## 2. Basic KingMaker workflow (safe version)

1. **Frame the scenario (offline / sandbox)**
   - Restate the fictional Evilia / Demagogia context.
   - Confirm which assets are in-scope for this pass.

2. **Draft the "Uhoh" view (sandbox)**
   - From a hostile perspective:
     - grade the idea’s threat to authoritarian control,
     - list ways the language or structure could be twisted,
     - note obvious overclaims or blind spots.
   - Keep this in sandbox / HP57 form, not in public repos.

3. **Draft the "Sabotage" patterns (sandbox)**
   - Describe **high-level structural patterns only**, such as:
     - narrative distortion,
     - concept hijacking,
     - infra choke points,
     - noise / fragmentation.
   - Do *not* include actionable real-world tactics.
   - Again: sandbox / HP57 only.

4. **Write / update a repo-safe summary**
   - Distil what CoCivium needs to learn:
     - where messaging needs hardening,
     - where infra should be more decentralised,
     - where GIBindex / CoAudit need new checks.
   - Update tables like:
     - `T1–Tn` threat and weakness rows,
     - `KM-HP57-00x` placeholder references.

5. **Feed mitigations into design**
   - Open issues or notes in:
     - CoSteward (protocols, playbooks),
     - CoAudit (checklists / rails),
     - CoIndex / GIBindex (concept entries).
   - Tie each mitigation back to a KingMaker threat ID (e.g. T3).

## 3. Guardrails for safe practice

To keep KingMaker aligned with CoCivium’s values:

- **No detailed exploit instructions**
  - Patterns yes, step-by-step attack playbooks no.

- **Always pair dark patterns with blowback and harm analysis**
  - Human cost,
  - AI misuse risk,
  - long-term regime fragility.

- **Rotate lenses**
  - Alternate KingMaker (red-team) with:
    - green-team design sessions,
    - blue-team CoAudit / guardrail work,
    - so the project does not get stuck in paranoia.

- **Respect HP57 boundaries**
  - Use neutral IDs (KM-HP57-001, etc.) in public notes.
  - Store specifics only in the appropriate vault structures.

## 4. Where this insight fits in the larger system

This Practice note should stay in sync with:

- the KingMaker Theory note (same directory),
- CoAudit guidance on red-teaming,
- CoSteward protocols for sanity checks and adversarial reviews.

Typical consumers:

- CoStewards designing new rails,
- CoAudit maintainers adding threat checks,
- CoIndex maintainers naming and tracking threat categories.

As KingMaker evolves, both Theory and Practice insights should be
updated together and referenced in Co1 / CoPrime session plans.
