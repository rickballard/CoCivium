# CoCivium Diagrams

This page is generated from JSON files under `docs/diagrams/examples/`.
**Do not hand-edit the fenced blocks below.** Update JSON and re-run the builder.

## Asset Graph (Mermaid, generated)
```mermaid
%% generated:2025-10-28T18:36:45Z
flowchart LR
subgraph module
  ElevenLaws["11 Laws"]
  GIBindex["GIBindex"]
  GovContainer["AI Governance Container"]
  MeritRank["MeritRank"]
  RepTag["RepTag"]
end
subgraph repo
  CoAgent["CoAgent"]
  CoAudit["CoAudit"]
  CoCache["CoCache"]
  CoCache["CoCache"]
  CoCivium["CoCivium"]
  CoCivium["CoCivium"]
  CoCore["CoCore"]
  CoPolitic["CoPolitic"]
  RickPublic["RickPublic"]
end
subgraph service
  AdviceInbox["Advice Inbox"]
  CoAgentSvc["CoAgent (svc)"]
  CoCacheGlobal["CoCacheGlobal"]
  CoEvo["CoEvo Loop"]
end
subgraph site
  CoCiviumOrg["CoCivium.org"]
  CoPoliticOrg["CoPolitic.org"]
  GroupBuildOrg["GroupBuild.org"]
end
subgraph Ungrouped
  AdviceInbox["Advice Inbox"]
  CoAgent["CoAgent"]
  CoCache["CoCache"]
  CoCivium["CoCivium"]
end
AdviceInbox --> |"ingests"| CoAgentSvc
AdviceInbox --> |"feeds"| CoCivium
AdviceInbox --> CoCivium
CoAgent --> CoCivium
CoAgentSvc --> |"triggers"| CoEvo
CoAudit --> |"audits"| GovContainer
CoCache --> |"emits"| AdviceInbox
CoCache --> AdviceInbox
CoCache --> |"indexes"| CoAgent
CoCache --> CoAgent
CoCache --> |"feeds"| CoAudit
CoCacheGlobal --> |"syncs"| CoCache
CoCivium --> |"indexes"| CoCache
CoCivium --> |"publishes"| CoCiviumOrg
CoCore --> |"indexes"| CoCache
CoCore --> |"feeds"| GroupBuildOrg
CoPolitic --> |"indexes"| CoCache
CoPolitic --> |"publishes"| CoPoliticOrg
ElevenLaws --> |"constrains"| GovContainer
GIBindex --> |"writes"| CoCache
GovContainer --> |"wraps"| CoAgentSvc
MeritRank --> |"augments"| CoCore
RepTag --> |"augments"| CoCore
RickPublic --> |"indexes"| CoCache
```

> **Caption:** CoSuite asset relationships (best-effort; see JSON in `docs/diagrams/examples/`).

## D2 (placeholder, reserved)
```d2
// placeholder kept to satisfy fence invariants.
```


---
**Legend:** see [docs/diagrams/render/legend.mmd](docs/diagrams/render/legend.mmd)
