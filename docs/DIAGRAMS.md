# DIAGRAMS

_JSON is canonical; blocks below are generated from docs/diagrams/examples/*.json._

## Mermaid
`mermaid
flowchart LR
  subgraph Misc
    CoCache["CoCache"]
    CoAgent["CoAgent"]
    AdviceInbox["Advice Inbox"]
    CoCivium["CoCivium"]
  end
  CoCache --> AdviceInbox
  AdviceInbox --> CoCivium
  CoCache --> CoAgent
  CoAgent --> CoCivium
  CoCivium -->|indexes| CoCache

// placeholder: CI will emit D2 from the same JSON sources
