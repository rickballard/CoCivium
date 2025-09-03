# CoEvolution in CoCivium — Practical & Mythic (v0.1)

**Why this exists.** We change fast, but we don’t break people. CoEvolution = many small, reversible moves guided by shared forces.

## How to use this
When proposing a change, name **one Force** and **one Assumption** you’re relying on, plus a falsifiable test. Canonical BP = green on “Signals,” tagged release, lived on main.

## Fundamental Assumptions (state → test → hedge)
- **FA‑1 Reversibility > prediction.** Small, reversible steps beat big‑bang plans.
  *Signals:* short PRs, steady merges, few rollbacks. *Test:* small PRs vs big PR defect rate. *Hedge:* squash merges, tags, rollback notes.
- **FA‑2 Conversation attaches to change.** Issue/PR threads > side DMs.
  *Signals:* fewer surprise reversions; more reviewers/PR. *Test:* 2‑week IssueOps trial. *Hedge:* Intent ⟂ Risks ⟂ Rollback, timeboxes.
- **FA‑3 Guardrails > gates.** Nudging sentinels beat hard fails (by default).
  *Signals:* warnings resolved quickly; low hard‑fail rate. *Test:* flip one to hard‑fail for 1 week. *Hedge:* rotate messages; “fix in <60s.”
- **FA‑4 Adoption follows 2‑minute value.** First value in ≤2 minutes or redesign.
  *Signals:* first‑run success; new‑contrib time‑to‑green. *Test:* 5–7 user checks. *Hedge:* expert knobs behind flags/helpers.
- **FA‑5 Narrative shapes behavior.** Symbols + rituals keep the garden tended.
  *Signals:* consistent demarks; self‑policing language. *Test:* remove a symbol for a week. *Hedge:* prune rituals that don’t move outcomes.

## Forces we lean on
IssueOps first; CoPing ⟂ CoPong; Sentinels; Session‑only power; Protected docs; Rollbackable by design.
**Anti‑forces:** hidden state, irreversible scripts, policy in DMs, big‑bang PRs, hero work with no trail.

## Operating loop
1) Idea → Issue (Intent, Risks, Rollback)
2) Spike behind flag/helper + one‑liner in PR
3) Add/update sentinel
4) Breadcrumb in nearest README/INDEX
5) Two‑Eyes review
6) Squash + tag + link
7) Observe and roll forward/back.

## Critique checklist
- [ ] Names clear
- [ ] Reversible (rollback steps)
- [ ] Sentinel nudge touched
- [ ] Breadcrumb (WHY/WHAT/NEXT)
- [ ] Falsifiable test stated
- [ ] Session‑only / no hidden global state

## Signals
**Leading:** small PRs; review latency ≤1 day; newcomer to green ≤15 min.
**Trailing:** low change‑failure; fewer “what broke?” pings; ≥80% warnings fixed ≤7 days.

## Mythic thread
We’re gardeners, not gatekeepers. Plant small, prune often, compost mistakes, grow shade for the next team.

## Appendix A — Recipes
Sandbox → Standard (ship helper/flag first; promote after 2 teams say “kept”).
Deprecate with pointers (keep old path 1 release).
Canonize only after a tagged release lived on main.

## Appendix B — Open questions
Hard‑fail criteria; protected‑docs lint; weekly vs monthly pruning.
