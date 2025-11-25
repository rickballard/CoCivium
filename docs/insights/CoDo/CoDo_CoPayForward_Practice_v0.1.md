<!-- COFACE
StyleArchetype: Ops-Pattern / Practical-Rules
HumanTouch: Medium
Canonicality: Seed
AIFlatteningRisk: Medium
EditorGuidance: Keep it crisp and checklist-like. Link back to doctrine and theory.
-->
# CoDo Doctrine – CoPayForward (Practice) v0.1

Canonical source:
- `docs/doctrine/CoDo_Doctrine_CoPayForward_v0.1.md`
- `docs/insights/CoDo/CoDo_CoPayForward_Theory_v0.1.md`

This file is for **operators**:

- Co1
- CoStewards
- CoSuite-aligned AIs and humans

## 1. Default behavior for serious sessions

For any CoSuite / CoCivium session that is more than casual chat:

1. **Surface intent early**

   Ask (or infer):

   - What are we trying to change or improve here?
   - What artifact would prove we did it?

2. **Assume a PS7 panel exists**

   Prefer:

   - PS7 CoBlocks / DO Blocks,
   - repo-first snippets,
   - runnable or readable assets.

3. **Leave a gift every Wave**

   At the end of a Wave (or a serious arc), there should be at least one:

   - `.md` advisory,
   - script or CoBlock,
   - diagram, checklist, or spec,
   - small pattern write-up.

4. **Make gifts drag-and-drop friendly**

   A gift should be:

   - self-explanatory in its header,
   - light on hidden context,
   - safe to paste into a new session or repo.

5. **Flag non-CoDo runs**

   If a session ends with only chatter:

   - mark it as **brainstorm only**, or
   - schedule a follow-up CoDo cleanup Wave.

## 2. Where to store CoPayForward artifacts

Typical homes:

- Doctrine and insights:
  - `CoCivium/docs/doctrine`
  - `CoCivium/docs/insights/...`
- Operational patterns:
  - `CoSteward/docs/ops/...`
- Tools and runners:
  - `tools/*.ps1` in relevant repos
- AdviceBomb payloads:
  - under `advice/inbox/...` with clear names and `.sha256` sidecars

## 3. Quick checks for Co1 and CoStewards

At the end of a serious session, ask:

- Did we create at least one giftable artifact?
- Is it:
  - named clearly?
  - stored in an obvious place?
  - easy for a future Co1 or human to reuse?

If not:

- run a short CoDo Wave to produce that artifact before closing.
