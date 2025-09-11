<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
# Repo Map

```mermaid
flowchart TD
  A[README] --> S[START-HERE]
  A --> M[Repo Map]
  A --> W[Workflows]
  A --> C[CONTRIBUTING]

  subgraph Docs
    I[docs/ideas/*]:::dir
    R[docs/REPO-MAP.md]
    WF[docs/WORKFLOWS.md]
    SH[docs/START-HERE.md]
  end

  subgraph Ops
    GH[.github/workflows/*]:::dir
  end

  X[CoModules (canonical modules)]:::ext
  I -->|pointer cards| X
  M --- R
  W --- WF
  S --- SH
  A --- C
  GH:::dir

  click R "REPO-MAP.md" "Repo Map"
  click WF "WORKFLOWS.md" "Workflows"
  click SH "START-HERE.md" "Start Here"
  click I "ideas/INDEX.md" "Ideas Index"

  classDef dir fill:#eef,stroke:#99c;
  classDef ext fill:#efe,stroke:#7a7;
```






