# CoSync — Handoff to CoPrime: Diagrams & Systematics
UTC: 20251030T191019Z

## Scope
- Own **diagrams + systematics**: Inventory previews, CoRef/XRef wiring, indexing and conventions.

## Pointers
- Inventory: docs/diagrams/INVENTORY.md
- Auto-previews (CI): .github/workflows/diagram-previews.yml → docs/diagrams/_previews/**
- Guard: .github/workflows/mermaid-guard.yml
- Vitals:
  - Source (preview md): docs/diagrams/render/academy/vital-signs.mmd
  - Generator: tools/vitals-to-mermaid.ps1
  - Data (seed): docs/diagrams/vitals/data/vitals.csv

## Next
- Confirm previews render on **main** and show within Inventory cards.
- Replace demo CSV with sourced, **cited** metrics; add legend/units to charts.
- Add CoRef/XRef entries + section anchors; consider sort-by-updated for Inventory.
