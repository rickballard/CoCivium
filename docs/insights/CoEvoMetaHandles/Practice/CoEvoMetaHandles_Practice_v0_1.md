# CoEvo MetaHandles Practice v0.1

> How to actually use CoEvo meta handles in day to day CoCivium work.

## 1. Example meta handles

Some early canonical examples:

- CoPotential:
  - Metric of beneficial evolvability.
- CoBloat:
  - Metric of cognitive and session bloat (CU, PU, HU, WT tiers).
- CoTrust:
  - Metric of perceived and measured trustworthiness.
- CoAwe:
  - Marker for emergent insight or profound understanding.
- CoMegaTrain:
  - Contract for explicit, tracked training events.
- CoCrux:
  - Collection of core guardrails and ontology anchors.
- CoParallelity:
  - Pattern for coordinating many concurrent sessions.

These should be incrementally added to GIBindex with stable IDs.

## 2. Using meta handles in CoPre and CoBus

- CoPre:
  - Can encode meta handles in the CoSong payload:
    - For example: 'metrics = {copotential, cobloat}'.
  - Can reference autonomy tier meta handles:
    - CoAssist, CoPilot, CoAgent, CoArena.

- CoBus:
  - Can carry cross session hints:
    - 'cluster = CoParallelity'
    - 'intent = CoPreProductization'
    - 'epoch = 20251210T05Z'

This lets many sessions behave as one coordinated organism.

## 3. Using meta handles in PS7 and scripts

PS7 scripts can:

- Read and write small JSON or GIBconfig files that mention meta handles.
- Use them in:
  - Branch names
  - DO Block labels
  - Log file names

Example pattern:

- Branch:
  - feature/CoCrux_update_20251210T164939Z
- DO Block label:
  - DO CoCivium_Insights_CoCrux_CoEvoMetaHandles_v0_1_UTS
- Log messages:
  - 'CoPotential: +1, CoBloat: PU -> CU'

## 4. CoCTA and CoMetaTrain hooks

- CoCTA:
  - Call to action patterns based on meta handles.
  - Example:
    - If CoBloat = HU or WT, recommend session rotation.
    - If CoPotential drops for multiple waves, suggest new insight work.

- CoMetaTrain:
  - Training events should:
    - Declare which meta handles they intend to improve.
    - Log before and after snapshots in CoMeta.

Over time this creates a feedback loop where training and evolution decisions are traceable through meta handle histories.

## 5. Next steps

- Gradually:
  - Add GIBindex entries for each meta handle.
  - Update CoPre, CoMeta, and CC to reference them.
  - Build small dashboards (CoVitals) that visualize CoPotential, CoBloat, CoTrust, and others.

This file should evolve with real examples as CoCivium matures.
