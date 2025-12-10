# CoCrux Practice v0.1

> How to work with CoCrux in daily CoCivium operations.

## 1. Where CoCrux lives on repo

At minimum, CoCrux should be discoverable via:

- CoCivium:
  - This insights couplet (Theory and Practice).
  - CC (Cognocarta Consenti) and its GIB spec.
- CoSteward:
  - CoAnchor BPOE rails quickstart.
  - Local OE inventory scripts.
- CoModules:
  - BPOE docs in docs/bpoe.
  - CoPre module and related configs.

Over time, GIBindex entries will give CoCrux explicit GIB IDs.

## 2. Daily workflow patterns

- Sessions:
  - Always assume 'repo first, memory last'.
  - Always CoSync, MegaWave, CoBloat heartbeat.
  - Treat on session ideas as hypotheses until landed in repo.

- PS7 panels:
  - Emit DO Blocks for any structural or code work.
  - Use branches, PRs, and squash merges as standard.
  - Never silently change core CoCrux docs without notes.

- Language evolution:
  - New CoTerms must update GIBindex.
  - CoCrux terms should be rare, stable, and clearly defined.

## 3. CoEdgeRails in practice

CoEdgeRails is the portion of CoCrux dealing with:

- Edge ownership of:
  - Guardrails
  - Training data choices
  - Constitutional variations
- Practical implications:
  - Users should be able to:
    - See which guardrails apply.
    - Adjust preferences within safe bounds.
    - Export and import their guardrail profiles.

## 4. Working with sessions and CoPre

- CoPre should:
  - Inject a small CoCrux aware pre prompt every wave.
  - Reference CC, CoGibberCC, CoMeta, and CoOntos.
  - Treat CoCrux as authoritative over model defaults.

- Humans should:
  - See as little visual clutter as possible (glyphs, Mini lines).
  - Be able to request explanations in plain language (CoExplain mode).

## 5. CoCrux change management

- Any change that affects CoCrux:
  - Must be proposed via a feature branch.
  - Must include a design note in a sandbox or intent folder.
  - Should be reviewed by steward minded humans or trusted AI agents.

- CoCrux should be:
  - Difficult to change accidentally.
  - Easy to audit via version history and GIBindex.

This document is a practical companion to CoCrux Theory v0.1 and is intended to evolve as the stack matures.
