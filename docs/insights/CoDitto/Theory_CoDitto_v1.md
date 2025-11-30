# Theory – CoDitto v1

## 1. Definition

**CoDitto** is the intentional gesture a human uses to say:

> “Yes, do more of *this exact pattern*.”

It is the micro-level driver of CoNudge and CoEvolution: a way for humans to
signal which behaviours, formats, or responses should be reinforced by AIs and
CoSuite.

## 2. Motivation

- CoCivium depends on **edge-owned guardrails** and **co-evolution** between
  humans and AIs.
- Most users do not want to tune prompts or fiddle with settings; they need a
  simple gesture that says “That. Keep that.”
- CoDitto turns casual approval into a **structured reinforcement event** that
  systems can log, count, and eventually fold into:
  - CoImprintStream (long-lived preferences),
  - CoTraceStream (short-lived context),
  - updates to BPOEs, insights, and patterns.

## 3. Relationship to other concepts

- **CoNudge** – macro concept: shaping system behaviour by repeated prompting
  and reinforcement. CoDitto is the *unit action* that feeds CoNudge.
- **CoEvo** – broader idea of co-evolution between humans, AIs, and institutions.
  CoDitto is one of the simplest human tools for steering that evolution.
- **CoTraceStream / CoImprintStream** – platform-side memories that can record
  CoDitto events and treat them as signals to:
  - revisit prompts,
  - adjust templates,
  - prioritize certain response styles.
- **System.Func`2[System.Text.RegularExpressions.Match,System.String] / CoBeacon** – CoDitto events happening on System.Func`2[System.Text.RegularExpressions.Match,System.String] surfaces help
  discover which explanations, on-ramps, and patterns actually serve humans.

## 4. Design considerations

A good CoDitto pattern should:

- Be **easy to invoke** (a single word, button, or equivalent gesture).
- Be **transparent**:
  - Users should know: “When I say CoDitto, I’m helping shape how this system behaves.”
- Be **bounded**:
  - CoDitto reinforces *patterns*, not raw chat logs.
  - System implementations should aggregate events by pattern/category, not simply
    memorize specific conversations.

## 5. Risks and guardrails

- Over-reinforcement of low-quality patterns if CoDitto is overused or gamed.
- Misinterpretation if CoDitto is not clearly explained to users.
- Drift away from edge-owned standards if CoDitto is allowed to override:
  - core governance constraints,
  - legal/ethical limits,
  - non-negotiable BPOEs.

CoDitto must always operate inside CoCivium’s edge-owned guardrails, not above them.

## 6. Future directions

- Define standard **CoDitto event schemas** (fields, tags, pattern IDs).
- Explore CoDitto variants:
  - CoDitto+ (strong reinforcement),
  - CoDitto? (uncertain but interesting),
  - CoDitto- (soft “less of this”).
- Integrate CoDitto into:
  - System.Func`2[System.Text.RegularExpressions.Match,System.String] UX,
  - CoSteward Ops Manual (how to interpret patterns),
  - CoAudit (auditing reinforcement dynamics).

See `Practice_CoDitto_v1.md` for concrete usage scenarios.
