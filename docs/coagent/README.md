# CoAgent — Run Flow & Custody

This page embeds the canonical Mermaid source:
$diagramPath

`mermaid
%% (rendered from the source file path)
%% NOTE: Keep edits in the .mmd to pass diagram guards.
%% CoAgent Run Flow & Custody (Box + Connector Diagram)
%% Style: clean monochrome; rectangles; dashed = optional; fit half-page; min font ~10pt

flowchart LR
  classDef box fill:#ffffff,stroke:#222,stroke-width:1px,color:#111
  classDef opt fill:#ffffff,stroke:#666,stroke-dasharray:4 2,color:#111
  classDef note fill:#fff,stroke:#888,stroke-dasharray:3 2,color:#111,font-size:10px
  classDef bold fill:#ffffff,stroke:#000,stroke-width:2px,color:#000

  %% === Boundaries / Swimlanes ===
  subgraph CT[Customer Tenant]
    direction LR
    subgraph UD[User Device (Phone/PC)]
      direction LR
      N1[1) CoAgent App<br/><span style="font-size:10px">Intent + Inputs (pre-approved, anonymized as needed)</span>]:::box
      C1["Only pre-approved, anonymized data leaves device"]:::note
    end

    subgraph CTS[Customer Tenant Services]
      direction LR
      N2[2) Policy Pack (YAML)<br/><span style="font-size:10px">Residency • PII • allowlist • retention</span>]:::box
      N3[3) CoAgent Router<br/><span style="font-size:10px">Applies policy; selects vendor driver</span>]:::box
      N6[6) Signed Receipt Generator<br/><span style="font-size:10px">Receipt (JSON): hashes, model, cost, policy verdicts</span>]:::box
      N7[7) Customer SIEM / KMS<br/><span style="font-size:10px">SIEM (logs)  |  KMS (keys)</span>]:::box
      C2["Policy as code enforced"]:::note
      C3["Hashes + metadata only; CoAgent stores no client content"]:::note
    end
  end

  subgraph VCLE[Vendor Clouds / Local Engine]
    direction LR
    N4a[4a) Vendor Driver: OpenAI]:::box
    N4b[4b) Vendor Driver: Azure]:::box
    N4c[4c) Vendor Driver: Local LLM]:::box
    SB[(Suite Bridge<br/><span style="font-size:10px">M365 / Google Workspace / GitHub</span><br/><span style="font-size:10px">Optional</span>)]:::opt
  end

  %% === Connectors ===
  N1 -- "Intent + policy applied" --> N2
  N2 --> N3

  N3 -- "Run executes (single, chained, agent steps, or batch)" --> N4a
  N3 -- "Run executes (single, chained, agent steps, or batch)" --> N4b
  N3 -- "Run executes (single, chained, agent steps, or batch)" --> N4c

  N4a -- "Outputs + usage" --> N6
  N4b -- "Outputs + usage" --> N6
  N4c -- "Outputs + usage" --> N6

  N6 -- "Signed receipt; no content custody" --> N7

  SB -. "Context/Docs (optional)" .-> N4a
  SB -. "Context/Docs (optional)" .-> N4b
  SB -. "Context/Docs (optional)" .-> N4c

  %% Callout anchors
  N3 --- C2
  N6 --- C3
  N1 --- C1

  %% Boundary emphasis
  class CT,UD,CTS,VCLE bold

  %% === Legend (tiny) ===
  subgraph LEGEND[Run Variants]
    direction LR
    L1["Single call"]:::note
    L2["Chained calls"]:::note
    L3["Agent steps"]:::note
    L4["Batch items"]:::note
  end

  LNOTE["Still one run if same window + policy pack"]:::note
  LEGEND --- LNOTE