# CoHarmony  -  Session Plan (Live Checklist)

- [x] Quality workflow (linkcheck, tension-detector, norms-radar)  -  artifacts only
- [x] PR labeler config present
- [x] PR tension comment path documented (permissions + same-repo)
- [ ] Composite action for PR tension table
- [ ] DOI allow-list policy (doc + code)
- Priors: #515, #516, #517

## Immunity Layer (CoAudit-first)  -  seed plan (20251109T143325Z)

**Intent**: Keep CoAudit strictly read-only; emit findings + artifacts; let other systems act (CoHarmony/CoPrime/CoForge).  
**Outcome**: A minimal, repeatable “immunity” scout ships; CoCivium consumes artifacts for a sticky PR tension table; CoPrime indexes findings.

### Milestones
1) **CoAudit seed** (producer, read-only)
   - Composite: \.github/actions/coaudit-scout@v0.1\
   - Artifacts: \coaudit/findings.json\, \coaudit/tension.json\, \coaudit/IMMUNITY_LOG.jsonl\
   - Schema + signals catalog: \docs/ops/immunity/signals.yml\, explainer README
2) **CoCivium consumer**
   - Quality workflow uses \coaudit-scout\ to produce artifacts
   - \	ension_comment\ job downloads artifact and posts sticky table
3) **CoPrime/CoCache listener**
   - Ingest artifacts or \epository_dispatch: coaudit.alert\
   - Index into Advice/INTENT for cross-repo view
4) **Beacons + guards**
   - CoSync notes at major steps
   - Labels: \ci\, \coharmony\ (effectors apply any audit:* labels)
5) **Success criteria**
   - Artifacts exist on PR runs
   - Sticky tension table visible on PRs
   - One AdviceBomb entry describing the Immunity Layer roadmap

**CoBloat heartbeat**: CU=OK | PU=SOFT | HU=SOFT | WT=SOFT

