# CoCivium Diagrams

This page is generated from JSON files under `docs/diagrams/examples/`.
**Do not hand-edit the fenced blocks below.** Update JSON and re-run the builder.

## Asset Graph (Mermaid, generated)
```mermaid
%% generated:2025-10-28T06:23:23Z
flowchart LR
subgraph repo
  CoCache["CoCache"]
  CoCivium["CoCivium"]
end
subgraph Ungrouped
  AdviceInbox["Advice Inbox"]
  CoAgent["CoAgent"]
  CoCache["CoCache"]
  CoCivium["CoCivium"]
end
AdviceInbox --> CoCivium
CoAgent --> CoCivium
CoCache --> AdviceInbox
CoCache --> CoAgent
CoCivium --> |"indexes"| CoCache
```

## D2 (placeholder, reserved)
```d2
// d2 placeholder; kept to satisfy fence invariants.
```
