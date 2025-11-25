# Practice – CoDitto v1

## 1. Basic usage pattern

In any interface that participates in CoCivium / CoSuite:

1. AI produces a response, visualization, or orchestration pattern.
2. Human experiences it and decides:
   - “Yes, this is the kind of thing I want more of.”
3. Human invokes **CoDitto**:
   - by typing `CoDitto`,
   - clicking a CoDitto button,
   - or using an equivalent gesture defined by the product UI.
4. System logs a **CoDitto event** tied to:
   - a pattern ID or category,
   - current mission / session labels,
   - timestamp and context.

## 2. Example scenarios

### 2.1 CoPortal explanation that “lands”

A CoPortal page explains CoCivium’s role in democracy in a way that feels clear
and empowering.

- Human thinks: “Yes, that. Keep that way of explaining it.”
- Human says: `CoDitto – this explanation style for CoCivium governance.`
- System:
  - increments a reinforcement counter for that explanation pattern,
  - surfaces it more often in similar contexts,
  - marks it as a candidate for inclusion in CoTheory / official docs.

### 2.2 CoBloat-aware orchestration

The AI notices a session is getting heavy and proactively suggests:

> “We may be at CoBloat(HARD) on CU/HU. I can design a CoRotate handover
> into a new session with a compact CoAnchor payload. Proceed?”

User finds this meta-awareness helpful and wants more like it:

- Human: `CoDitto – this kind of bloat-aware behaviour.`
- System:
  - tags the pattern (“bloat-aware, proactive CoRotate suggestion”),
  - reinforces prompts that include CoBloat assessments,
  - increases the chance that future orchestration flows will include similar checks.

### 2.3 Repository-first CoSync moves

In a CoAgent / Co1 environment:

- AI proposes a repo-first workflow with PS7 DO-blocks and clear path to PR.
- Human prefers this over ad-hoc copy/paste.

- Human: `CoDitto – repo-first CoSync moves like this.`
- System:
  - boosts repo-first templates,
  - gradually deprioritizes purely conversational “hand wavy” sequences.

## 3. Implementation hints (for CoSuite maintainers)

Even though implementations differ by vendor / platform, CoSuite can specify:

- Minimal fields for a CoDitto log entry:
  - `pattern_id` or `pattern_hash`
  - `context_label` (mission, repo, CoPortal name)
  - `user_role` (CoSteward, contributor, citizen)
  - `timestamp`
- Aggregation rules:
  - do not memorize raw chats,
  - do derive higher-level patterns (e.g., “bloat-aware suggestions got 12 CoDitto in a week”).

CoDitto events should, over time, inform:

- updates to CoSteward Ops Manual,
- refinements to CoPortal / CoBeacon content,
- additions to CoTheory insight pairs and GIBindex.

## 4. Relationship to humans and democracy

CoDitto is meant to be:

- **Small enough** that typical citizens can use it:
  - “I do not know *why* this works, but I know I want more of this feeling / clarity / respect.”
- **Strong enough** that, in aggregate, these signals influence:
  - how AIs treat people,
  - what narratives get amplified,
  - which governance patterns get codified.

It is one of the simplest instruments of **edge-owned democratic steering** in CoCivium.

Future versions of this document should pull real-world CoDitto examples from
Drop_For_Co1 / AdviceBombs and update the usage sections accordingly.
