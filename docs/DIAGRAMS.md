# CoCivium Diagrams (canonical JSON → generated)

**Canonical source:** docs/diagrams/examples/cosuite.asset-graph.json  
**Generated:** Mermaid (ender/asset-graph.mmd), D2 (ender/asset-graph.d2). Do **not** hand-edit generated files.

## Asset Graph (Mermaid)
`mermaid
flowchart TD
  CoCivium ([CoCivium])
  CoCache (CoCache)
  CoAgent (CoAgent)
  AdviceInbox (Advice Inbox)
  CoCache -- "owns/guards" --> AdviceInbox
  AdviceInbox -- "feeds content" --> CoCivium
  CoCache -- "tooling" --> CoAgent
  CoAgent -- "renders" --> CoCivium

direction: right
CoCivium: "CoCivium"
CoCache: "CoCache"
CoAgent: "CoAgent"
AdviceInbox: "Advice Inbox"
CoCache -> "owns/guards" AdviceInbox
AdviceInbox -> "feeds content" CoCivium
CoCache -> "tooling" CoAgent
CoAgent -> "renders" CoCivium

