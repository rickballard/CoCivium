# Vital Signs - live Mermaid preview

> Source: `vital-signs.mmd` (canonical). This file exists to make GitHub render a preview.

```mermaid
flowchart LR
%% seed placeholder - refine freely
%% Keep style/classDef after header
classDef metric fill:#eef6ff,stroke:#0a66c2,stroke-width:1.4px,color:#0b0b0b;
classDef warn   fill:#fff5f0,stroke:#b43b00,stroke-width:1.4px,color:#0b0b0b;

subgraph "Humanity's Vital Signs (themes)"
  Economy[Economy]:::metric
  Health[Health]:::metric
  Ecology[Ecology]:::metric
  Rights[Rights & Governance]:::metric
  Cohesion[Social Cohesion]:::metric
end

Economy -->|feeds| Cohesion
Health  -->|enables| Cohesion
Ecology -->|constrains| Economy
Rights  -->|stabilizes| Cohesion

%% examples of concrete metrics you can link out to:
click Economy "vitals/economy-index.mmd" "open"
click Health  "vitals/health-index.mmd"  "open"
click Ecology "vitals/ecology-index.mmd" "open"
click Rights  "vitals/rights-index.mmd"  "open"
click Cohesion "vitals/cohesion-index.mmd" "open"
```


