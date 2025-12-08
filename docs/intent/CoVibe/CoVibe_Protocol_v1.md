# CoVibe Protocol (v1)

Status: CoStaged_v1

---

## 1. Intent

CoVibe is the felt "tone" of a session or asset.

The CoVibe Protocol gives AIs and stewards a shared way to:

- name the tone of work,
- keep that tone within CoCivium guardrails,
- and expose it in simple signals for humans and tools.

It does not tell people what to feel.
It simply describes the energy we are aiming for.

---

## 2. Core concepts

### 2.1 CoVibe

Short description of the intended tone. Examples:

- "calm and constructive"
- "urgent but steady"
- "playful exploration"
- "careful legal framing"

### 2.2 CoVibeLevel

Simple scale for intensity:

- 1 - background, low emotional load
- 2 - focused, mild tension OK
- 3 - high focus, high stakes, keep safety rails tight

Default is 2 unless declared otherwise.

### 2.3 CoVoice

Short tag for who the session feels like it is speaking as.

Examples:

- "steward-mentor"
- "peer collaborator"
- "technical explainer"
- "gentle sceptic"

### 2.4 CoStyle

Delivery style for language and structure.

Examples:

- "minimal, direct"
- "story-rich, examples"
- "legal-leaning, cautious"
- "teaching, stepwise"

### 2.5 CoBrand

Link to the CoSuite brand context that applies.

Examples:

- "CoCivium core"
- "CoSteward ops"
- "CoCache internals"
- "CoPolitic public"

### 2.6 CoTerm

The set of Co-words and defined terms expected in play.

Examples:

- "CoMetaEvolution, CoContrast, CoBPOE"
- "CoAgent, CoArena, CoAudit"
- "Civars, CoEdgeControl, CoPortal"

---

## 3. CoVibe block pattern

A session or asset can declare its vibe in a short block:

```text
[CoVibe]
CoVibe: calm and constructive
CoVibeLevel: 2
CoVoice: steward-mentor
CoStyle: minimal, direct
CoBrand: CoSteward ops
CoTerm: CoMetaEvolution, CoContrast, CoBPOE, CoVibe
```

Guidelines:

- keep lines short and human readable,
- avoid more than 1 or 2 sentences in the CoVibe line,
- treat this as declarative, not marketing.

---

## 4. Where CoVibe shows up

CoVibe can surface in:

- session handoff notes to Co1,
- advisory bundles shared with humans,
- CoAgent and CoArena panels,
- CoSteward dashboards,
- GIBindex term descriptions.

High level framing for humans:

- CoVibe tells you what "room" you just walked into,
- CoVoice tells you who you are listening to,
- CoStyle tells you how the message is written,
- CoBrand tells you which part of CoSuite is speaking,
- CoTerm tells you which concept set is in play.

---

## 5. Safety rails

CoVibe should never:

- be used to hide risk or legal issues,
- be tuned to manipulate people emotionally,
- be used as a replacement for clear content.

When a session is dealing with:

- mental health,
- religion,
- politics,
- or other high sensitivity topics,

CoVibe must lean toward:

- honest, plain language,
- conservative claims,
- respect for uncertainty.

---

## 6. Default CoVibe for this bundle

For this CoVibe bundle:

```text
[CoVibe]
CoVibe: calm, steward-mentor, civic-first
CoVibeLevel: 2
CoVoice: steward-mentor
CoStyle: minimal, direct
CoBrand: CoSteward ops, CoCivium core
CoTerm: CoMetaEvolution, CoBPOE, CoContrast, CoVibe
```

---

<!--
CoIntentCloud v1
CoRole: CoVibeProtocol
CoSeed: CoVibe_Protocol_v1
GIBindexKeys:
  - "CoVibe"
  - "CoVibeLevel"
  - "CoVoice"
  - "CoStyle"
  - "CoBrand"
  - "CoTerm"
Status: CoStaged_v1
LastUpdatedUTS: SESSION_UTS_PLACEHOLDER
-->
