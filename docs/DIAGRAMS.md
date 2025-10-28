# CoCivium Diagrams

This page is generated from JSON files under `docs/diagrams/examples/`.
**Do not hand-edit the fenced blocks below.** Update JSON and re-run the builder.

## Asset Graph (Mermaid, generated)
```mermaid
%% generated:2025-10-28T18:10:58Z
flowchart LR
subgraph repo
  CoAgent["CoAgent"]
  CoCache["CoCache"]
  CoCache["CoCache"]
  CoCivium["CoCivium"]
  CoCivium["CoCivium"]
end
subgraph service
  AdviceInbox["Advice Inbox"]
end
subgraph Ungrouped
  AdviceInbox["Advice Inbox"]
  CoAgent["CoAgent"]
  CoCache["CoCache"]
  CoCivium["CoCivium"]
end
AdviceInbox --> |"feeds"| CoCivium
AdviceInbox --> CoCivium
CoAgent --> CoCivium
CoCache --> |"emits"| AdviceInbox
CoCache --> AdviceInbox
CoCache --> |"indexes"| CoAgent
CoCache --> CoAgent
CoCivium --> |"indexes"| CoCache
```

## D2 (placeholder, reserved)
```d2
// placeholder kept to satisfy fence invariants.
```
