# MegaWave Fork Numbering Standard (MW Fork Scheme)
Version 1.0

## Purpose
This document defines a flexible and stable numbering scheme for MegaWave countdowns. It prevents renumbering, protects intent trails, and allows sessions to insert new MegaWave waves at any location without disrupting existing structure or references. It also aligns future sessions with CoSync bus expectations, BPOE defaults, and the CoSurfer workflow methodology.

## Background
Standard MegaWave countdowns use integers such as MW23, MW22, MW21, continuing until MW0. This works only when all waves are known in advance. When new waves need to be inserted between existing ones, simple integers force a renumbering of all later waves. Renumbering breaks reproducibility, PR trails, checkpoints, lineage, and CoBloat metrics.

A forkable numbering system avoids renumbering and allows insertion at any point.

## MW Forkable Numbering Scheme

### Identifier Format
MW<main>.<fork>

- main: primary countdown integer.
- fork: secondary segment used when inserting waves between existing ones.
- Waves without forks use only the main segment (MW23).
- Fork segments start at 1 and increase as needed.
- Forks may themselves be forked (MW23.1.1).

### Rules
1. Do not change main numbers once created.
2. To insert a wave after MW23 and before MW22, use MW23.1.
3. Multiple insertions: MW23.1, MW23.2, MW23.3.
4. Nested forks allowed: MW23.1.1, MW23.1.2.
5. Sorting is path-based: MW23, MW23.1, MW23.1.1, MW23.2, MW22.
6. MW0 marks the canonical end of countdown.
7. Waves after zero use negatives: MW0, MW-1, MW-2.
8. Forks allowed in negative region: MW0.1, MW-1.1.
9. Every wave must begin with a download link and a CoBlock.

## Alignment With CoSync Bus and BPOE Defaults
- Fork scheme stabilizes cross-session references for CoSync reconciliation.
- Prevents fragmentation of MegaWave lineage during multi-session orchestration.
- Supports BPOE-default workflows by locking identifiers early.
- Reduces ambiguity during CoSurfer workflow transitions.
- Ensures PR lineage remains clean and auditable.

## CoSurfer Workflow Methodology Notes
CoSurfers follow the flow of a MegaWave sequence similar to surfers following a wave.  
The fork numbering allows:
- smooth merging of new waves,
- collaborative additions without renumbering,
- predictable flow of CoBlocks,
- stable scheduling during CoSurfing.

This terminology will appear in the GIBindex terms listings as required.

## Required Behaviors for All Future Sessions
1. New MegaWave countdowns must use this forkable schema.
2. Legacy countdowns may complete unchanged but must adopt the schema afterward.
3. Insertions must always use fork identifiers.
4. All logs, PRs, zips, and CoBlocks must use the exact identifier assigned.
5. Co1 must reject attempts to renumber existing MW identifiers.

## Implementation Notes for Co1
- Parse identifiers using integer path segments.
- Detect and warn about collisions.
- Auto-suggest the next forked identifier when inserting.
- Surface deviations through CoAudit or CoSurfer UI panels.

## Ending Note
This MegaWave forkable numbering standard is now recommended for all new sessions. It aligns with BPOE defaults and the CoSurfer methodology and supports robust CoSync reconciliation.
