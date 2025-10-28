# DIAGRAMS

_JSON is canonical; blocks below are generated from docs/diagrams/examples/*.json_

## Mermaid
`mermaid
graph TD
  CoCivium["CoCivium"] -->|indexes| CoCache["CoCache"]
// D2 equivalent placeholder
CoCivium: { label: "CoCivium" }
CoCache:  { label: "CoCache" }
CoCivium -> CoCache: indexes
