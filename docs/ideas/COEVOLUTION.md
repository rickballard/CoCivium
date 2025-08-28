# CoEvolution in CoCivium — Practical & Mythic

**Why this exists.** We change fast, but we don’t break people. CoEvolution = many small, reversible moves guided by shared forces.

## Practical Forces (guardrails that don’t block)
- **IssueOps first.** Ideas land as issues/PRs with checklists and owners; conversation lives with the change.
- **CoPing → CoPong.** Human-in-the-loop handoffs; transcripts pasted, not streamed; visible demarks.
- **Sentinels.** Simple repo checks (style, line endings, required links) that *nudge* not punish.
- **Session-only power.** Local helpers wash away on shell exit; no hidden machine-wide hooks.
- **Protected docs.** Open core; sensitive plans live as `*.age` with Bitwarden-gated opens.
- **Telemetry (opt-in).** Only what helps teams improve, never to surveil individuals.
- **Rollbackable by design.** Small PRs, squash merges, tags, and inventory snapshots.

## Evolutionary Pattern
1. Make the smallest real improvement.
2. Leave a breadcrumb (WHY/WHAT/NEXT) in the PR.
3. Prefer add/rename over delete; deprecate with pointers.
4. If it’s sharp, wrap it in a helper with a switch.
5. If you had to explain it in chat—document the step in-repo.

## Anti-Forces to Resist
- Hidden state, irreversible scripts, policy in private DMs, “big bang” PRs.

## Cosmic / Mythic Thread (our north star)
We’re gardeners, not gatekeepers. The code and the crews co-shape each other. Tools are scaffolds for people; people are the reason for tools.

## How to Propose a Change
- Open an issue with **Intent → Risks → Rollback**.
- Add a sentinel or doc tweak alongside behavior changes.
- Mark with `canonical-bp` only when it’s lived in main with a tag.

