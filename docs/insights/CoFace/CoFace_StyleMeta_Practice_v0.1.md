# CoFace Style Meta – Practice v0.1

CoFace metadata is stored as a comment block near the top of a human facing asset:

```markdown
<!-- COFACE
StyleArchetype: Ops-Manual / Mythic-Operational
HumanTouch: High
Canonicality: Seed
AIFlatteningRisk: High
EditorGuidance: Preserve narrative voice, mythos callouts, and poetic framings. Tighten for clarity, not conformity.
-->
Fields:

StyleArchetype:

Examples:

Mythic-Emotive

Executive-Advisory

Ops-Manual / Mythic-Operational

Snarky-Deck

Recruitment-Story

HumanTouch:

Low, Medium, High

Canonicality:

Seed, Working, Canonical, Archive

AIFlatteningRisk:

Low, Medium, High

EditorGuidance:

Short free text for future humans and AIs.

Example:

"Keep the poem-like close. It matters for motivation."

"Snark is intentional. Do not neutralize without a clear reason."

Usage guidance:

Add COFACE blocks to:

Human facing insights and doctrine

Mythos, CoStory, CoMeme pieces

High congruence and high HumanTouch assets

Keep COFACE blocks:

Short

Honest

Updated when the role of the asset changes

Future tooling:

CoIgniter style scans:

List files missing COFACE blocks

CoAudit:

Warn when high HumanTouch + high AIFlatteningRisk docs are auto-refactored

Dashboards:

Show HumanTouch distributions across the CoSuite
