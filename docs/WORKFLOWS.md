<!-- status: stub; target: 150+ words -->

## PR Flow
```mermaid
flowchart TD
  A[Start Here] --> B[RepoAccelerator: local setup]
  B --> C[Create topic branch]
  C --> D[Commit (LF-only); pre-commit passes]
  D --> E[Open PR]
  E --> F[Review & checks]
  F --> G[Squash & merge]
```

## Ideas Flow
```mermaid
flowchart TD
  S[Sources] --> N[New idea stub in docs/ideas/]
  N --> T[Triage: pointer vs in-repo doc]
  T -->|Canonical in CoModules| P[Pointer card -> CoModules]
  T -->|CoCivium-facing| D[Expand doc here]
  P --> IDX[Update Ideas Index]
  D --> IDX
```



