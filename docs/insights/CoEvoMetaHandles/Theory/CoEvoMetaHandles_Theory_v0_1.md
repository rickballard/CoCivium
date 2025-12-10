# CoEvo MetaHandles Theory v0.1

> CoEvo meta handles = named control knobs and conceptual levers that let stewards shape the evolution of CoCivium without rewriting everything each time.

## 1. What are CoEvo meta handles?

CoEvo meta handles are:

- Stable names for:
  - Metrics (CoPotential, CoBloat, CoTrust)
  - Modes (CoAssist, CoPilot, CoAgent, CoArena)
  - Events (CoAwe, CoMegaTrain)
  - Collections (CoCrux, CoEdgeRails)
- That can be:
  - Referenced by GIBindex
  - Toggled in configs
  - Used as conditions in scripts and CoPre payloads.

They are the API for CoAutoEvo: how CoCivium evolves itself.

## 2. Why they matter for CoCivium

- Without meta handles:
  - Every change requires rewriting prose and code.
- With meta handles:
  - Stewards can:
    - Say 'increase CoPotential, reduce CoBloat, keep CoTrust above threshold'.
    - Target specific autonomy tiers or modes.
    - Evolve guardrails without losing track of what changed.

CoEvo meta handles make CoCivium governable at scale.

## 3. Relationship to other concepts

- CoCrux:
  - Defines which meta handles are non negotiable.
- CoPre:
  - Injects meta handle references into every prompt and wave.
- CoMeta:
  - Logs meta handle values and changes in headers and footers.
- CoParallelity:
  - Uses meta handles to coordinate many concurrent sessions.

## 4. GIBindex and CoIndex integration

Each meta handle should have:

- GIBindex entry:
  - ID (machine key)
  - Label (human name)
  - Category (metric, mode, event, collection)
  - Links to:
    - Insights docs
    - Specs
    - Case studies
- CoIndex links:
  - Pointers to where it appears across repos.
  - Diagrams and explanation pages.

This document defines the theory; practice lives in the companion CoEvoMetaHandles_Practice file.
