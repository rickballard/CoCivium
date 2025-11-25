# SESSION  -  CoHarmony Immunity Layer (CoAudit-first)

> Track at major milestones. Check only when actually on **main** (or clearly landed via PR).

## Seed: CoAudit (producer, read-only)
- [x] coaudit-scout composite exists (v0.1) in CoAudit repo
- [ ] outputs: \coaudit/findings.json\, \coaudit/tension.json\, \coaudit/IMMUNITY_LOG.jsonl\
- [ ] schema + signals catalog committed (\docs/ops/immunity/signals.yml\, README)
- [ ] (optional) repository_dispatch \coaudit.alert\ emitted

## Consumer: CoCivium
- [ ] Quality workflow invokes coaudit-scout to build artifacts
- [ ] artifact \coaudit\ uploaded on PRs
- [ ] \	ension_comment\ job downloads artifact and posts **sticky** table
- [ ] fork-guard present; permissions set at workflow top

## Aggregation: CoPrime / CoCache
- [ ] listener ingests artifacts or dispatches into index
- [ ] visible in Advice/INTENT rollups

## Beacons & hygiene
- [ ] CoSync note for each major milestone
- [ ] labels applied (\ci\, \coharmony\)
- [ ] smoke PR merged & removed; stale branches pruned

### Notes
- This checklist is session-scoped; evolve into BPOE once patterns stabilize.
- Keep CoAudit non-mutating. All “fixes” stay in effectors.

**CoBloat**: CU=OK | PU=SOFT | HU=SOFT | WT=SOFT

