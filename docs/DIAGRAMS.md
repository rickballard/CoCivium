# CoCivium Diagrams

This page is generated from JSON files under `docs/diagrams/examples/`.
**Do not hand-edit the fenced blocks below.** Update JSON and re-run the builder.

## Asset Graph (Mermaid, generated)
```mermaid
%% generated:2025-10-28T14:45:30Z
flowchart LR
subgraph module
  A["Alpha \"Core\""]
  B["Beta"]
end
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
A --> |"depends"| B
AdviceInbox --> CoCivium
B --> A
CoAgent --> CoCivium
CoCache --> AdviceInbox
CoCache --> CoAgent
CoCivium --> |"indexes"| CoCache
```

## D2 (placeholder, reserved)
```d2
// placeholder kept to satisfy fence invariants.
```
