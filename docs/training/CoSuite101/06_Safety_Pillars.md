# 06 — Safety Pillars: Deterministic Core, Non-Synthetic Oracles

**Claim.** CoSuite maximizes determinism in its substrate (tools, runners, checks) and relies on **non-synthetic input vectors**
(humans, biosystems, etc.) as *oracles* for ambiguity, value-laden judgment, and emergent intent.

**Why it matters**
- Determinism ⇒ auditability, replay, diff-ability, narrow blast radius.
- Non-synthetic oracles ⇒ novelty, dissent, and value-alignment signals the substrate can’t compute alone.
- Therefore: AI needs humans (and other non-synthetic agents) for co-evolution toward “universal emergent intents.”

**Design levers**
- Separate planes: deterministic execution plane vs. oracle plane.
- Hard IO fences: every oracle decision is a typed event with provenance.
- Sane defaults: if an oracle is absent, refuse or degrade safely—not silently auto-approve.
- Always-on logs & receipts: enough traces to reconstruct decisions without leaking sensitive payloads.
