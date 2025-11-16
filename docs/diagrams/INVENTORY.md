# Graphics & Diagrams Inventory

> **See also:** Hub Graphics Index (links-only): https://github.com/rickballard/CoCache/blob/main/docs/diagrams/HUB_GRAPHICS_INVENTORY.md

## Purpose
This inventory is the single source of truth for CoCivium diagrams. It ensures:
- **Discoverability:** Every diagram has a stable path and human-readable title.
- **Auditability:** Changes are reviewable via PRs; rendering is reproducible in CI.
- **Interlinking:** Diagrams link to related docs and issues; Mermaid `click` targets resolve.

## How-to (maintainers)
1. **Add a diagram**
   - Save source in `docs/diagrams/<topic>/<name>.<ext>` (Mermaid/D2/SVG/PNG).
   - Add a table row with: `| Title | Path (link) | Healthcheck | Owner | Notes |`.
   - For Mermaid, prefer `%%{init:...}%%` for theme/fit, keep it minimal.

2. **Link hygiene**
   - If using Mermaid `click`, ensure the target is a valid URL or repo-relative path on `main`.
   - No hardlinks to non-public resources.

3. **Render & preview**
   - Local: optional; CI renders on PR (see **diagram-previews** workflow).
   - If Inkscape isn’t installed locally, push—CI will render.

4. **Reviews**
   - Small: 1 reviewer; Large/structural: 2+ reviewers.
   - Blockers: broken links, missing owner, oversized assets (>1MB) without rationale.

5. **Healthcheck**
   - Keep **HEALTHCHECK.md** green. Fix `click` 404s and missing rows promptly.

## Conventions
- Filenames: `kebab-case`, ASCII, no spaces.
- Encodings: UTF-8 (no BOM). Line endings: LF.
- Images generated from source (SVG preferred) whenever possible.

## Links
- Inventory: `docs/diagrams/INVENTORY.md`
- Healthcheck: `docs/diagrams/HEALTHCHECK.md`
- Hub index (links-only): CoCache → `docs/diagrams/HUB_GRAPHICS_INVENTORY.md`

> **See also:** Hub Graphics Index (links-only): https://github.com/rickballard/CoCache/blob/main/docs/diagrams/HUB_GRAPHICS_INVENTORY.md

## Purpose
This inventory is the single source of truth for CoCivium diagrams. It ensures:
- **Discoverability:** Every diagram has a stable path and human-readable title.
- **Auditability:** Changes are reviewable via PRs; rendering is reproducible in CI.
- **Interlinking:** Diagrams link to related docs and issues; Mermaid `click` targets resolve.

## How-to (maintainers)
1. **Add a diagram**
   - Save source in `docs/diagrams/<topic>/<name>.<ext>` (Mermaid/D2/SVG/PNG).
   - Add a table row with: `| Title | Path (link) | Healthcheck | Owner | Notes |`.
   - For Mermaid, prefer `%%{init:...}%%` for theme/fit, keep it minimal.

2. **Link hygiene**
   - If using Mermaid `click`, ensure the target is a valid URL or repo-relative path on `main`.
   - No hardlinks to non-public resources.

3. **Render & preview**
   - Local: optional; CI renders on PR (see **diagram-previews** workflow).
   - If Inkscape isn’t installed locally, push—CI will render.

4. **Reviews**
   - Small: 1 reviewer; Large/structural: 2+ reviewers.
   - Blockers: broken links, missing owner, oversized assets (>1MB) without rationale.

5. **Healthcheck**
   - Keep **HEALTHCHECK.md** green. Fix `click` 404s and missing rows promptly.

## Conventions
- Filenames: `kebab-case`, ASCII, no spaces.
- Encodings: UTF-8 (no BOM). Line endings: LF.
- Images generated from source (SVG preferred) whenever possible.

## Links
- Inventory: `docs/diagrams/INVENTORY.md`
- Healthcheck: `docs/diagrams/HEALTHCHECK.md`
- Hub index (links-only): CoCache → `docs/diagrams/HUB_GRAPHICS_INVENTORY.md`

> **See also:** Hub Graphics Index (links-only): https://github.com/rickballard/CoCache/blob/main/docs/diagrams/HUB_GRAPHICS_INVENTORY.md


This inventory is generated. For each asset, include a short **purpose** and a quick **how-to-use** tip.

| File | Kind | Title | Purpose | How to Use | Preview |
|---|---|---|---|---|---|
| assets\badges\build.svg | SVG | build | TODO: add '<!-- purpose: ... -->' near top of SVG. | Embed directly in Markdown or include as <img>; prefer SVG for crispness. | assets\badges\build.svg |
| assets\badges\docs.svg | SVG | docs | TODO: add '<!-- purpose: ... -->' near top of SVG. | Embed directly in Markdown or include as <img>; prefer SVG for crispness. | assets\badges\docs.svg |
| assets\badges\license.svg | SVG | license | TODO: add '<!-- purpose: ... -->' near top of SVG. | Embed directly in Markdown or include as <img>; prefer SVG for crispness. | assets\badges\license.svg |
| assets\cc\cc-crest.png | Raster | cc-crest | TODO: document purpose. | Reference from docs; consider exporting a web-friendly preview. | assets\cc\cc-crest.png |
| assets\cc\cc-crest.svg | SVG | cc-crest | TODO: add '<!-- purpose: ... -->' near top of SVG. | Embed directly in Markdown or include as <img>; prefer SVG for crispness. | assets\cc\cc-crest.svg |
| assets\cc\crest-hold.gif | Raster | crest-hold | TODO: document purpose. | Reference from docs; consider exporting a web-friendly preview. | assets\cc\crest-hold.gif |
| assets\cognocarta-scroll.svg | SVG | cognocarta-scroll | TODO: add '<!-- purpose: ... -->' near top of SVG. | Embed directly in Markdown or include as <img>; prefer SVG for crispness. | assets\cognocarta-scroll.svg |
| assets\diagrams\bio_vs_synth_observers_c1_20250809.svg | SVG | bio_vs_synth_observers_c1_20250809 | TODO: add '<!-- purpose: ... -->' near top of SVG. | Embed directly in Markdown or include as <img>; prefer SVG for crispness. | assets\diagrams\bio_vs_synth_observers_c1_20250809.svg |
| assets\diagrams\two-eyes.png | Raster | two-eyes | TODO: document purpose. | Reference from docs; consider exporting a web-friendly preview. | assets\diagrams\two-eyes.png |
| assets\diagrams\two-eyes.svg | SVG | two-eyes | TODO: add '<!-- purpose: ... -->' near top of SVG. | Embed directly in Markdown or include as <img>; prefer SVG for crispness. | assets\diagrams\two-eyes.svg |
| assets\hero\hero.gif | Raster | hero | TODO: document purpose. | Reference from docs; consider exporting a web-friendly preview. | assets\hero\hero.gif |
| assets\hero\hero.jpg | Raster | hero | TODO: document purpose. | Reference from docs; consider exporting a web-friendly preview. | assets\hero\hero.jpg |
| assets\hero\quote-960w.png | Raster | quote-960w | TODO: document purpose. | Reference from docs; consider exporting a web-friendly preview. | assets\hero\quote-960w.png |
| assets\hero\quote-960w@2x.png | Raster | quote-960w@2x | TODO: document purpose. | Reference from docs; consider exporting a web-friendly preview. | assets\hero\quote-960w@2x.png |
| assets\hero\quote.svg | SVG | quote | TODO: add '<!-- purpose: ... -->' near top of SVG. | Embed directly in Markdown or include as <img>; prefer SVG for crispness. | assets\hero\quote.svg |
| assets\icons\broken-line.svg | SVG | broken-line | TODO: add '<!-- purpose: ... -->' near top of SVG. | Embed directly in Markdown or include as <img>; prefer SVG for crispness. | assets\icons\broken-line.svg |
| assets\icons\coevolve-line.svg | SVG | coevolve-line | TODO: add '<!-- purpose: ... -->' near top of SVG. | Embed directly in Markdown or include as <img>; prefer SVG for crispness. | assets\icons\coevolve-line.svg |
| assets\icons\feels-line.svg | SVG | feels-line | TODO: add '<!-- purpose: ... -->' near top of SVG. | Embed directly in Markdown or include as <img>; prefer SVG for crispness. | assets\icons\feels-line.svg |
| assets\icons\for-you-line.svg | SVG | for-you-line | TODO: add '<!-- purpose: ... -->' near top of SVG. | Embed directly in Markdown or include as <img>; prefer SVG for crispness. | assets\icons\for-you-line.svg |
| assets\icons\governments-line.svg | SVG | governments-line | TODO: add '<!-- purpose: ... -->' near top of SVG. | Embed directly in Markdown or include as <img>; prefer SVG for crispness. | assets\icons\governments-line.svg |
| assets\icons\how-line.svg | SVG | how-line | TODO: add '<!-- purpose: ... -->' near top of SVG. | Embed directly in Markdown or include as <img>; prefer SVG for crispness. | assets\icons\how-line.svg |
| assets\icons\life-line.svg | SVG | life-line | TODO: add '<!-- purpose: ... -->' near top of SVG. | Embed directly in Markdown or include as <img>; prefer SVG for crispness. | assets\icons\life-line.svg |
| assets\icons\solutions-line.svg | SVG | solutions-line | TODO: add '<!-- purpose: ... -->' near top of SVG. | Embed directly in Markdown or include as <img>; prefer SVG for crispness. | assets\icons\solutions-line.svg |
| assets\icons\until-line.svg | SVG | until-line | TODO: add '<!-- purpose: ... -->' near top of SVG. | Embed directly in Markdown or include as <img>; prefer SVG for crispness. | assets\icons\until-line.svg |
| assets\icons\who-line.svg | SVG | who-line | TODO: add '<!-- purpose: ... -->' near top of SVG. | Embed directly in Markdown or include as <img>; prefer SVG for crispness. | assets\icons\who-line.svg |
| assets\icons\why-line.svg | SVG | why-line | TODO: add '<!-- purpose: ... -->' near top of SVG. | Embed directly in Markdown or include as <img>; prefer SVG for crispness. | assets\icons\why-line.svg |
| assets\status\two-eyes.png | Raster | two-eyes | TODO: document purpose. | Reference from docs; consider exporting a web-friendly preview. | assets\status\two-eyes.png |
| docs\diagrams\_previews\render\academy\vital-signs-chart.svg | SVG | vital-signs-chart | TODO: add '<!-- purpose: ... -->' near top of SVG. | Embed directly in Markdown or include as <img>; prefer SVG for crispness. | docs\diagrams\_previews\render\academy\vital-signs-chart.svg |
| docs\diagrams\_previews\render\asset-graph-map.svg | SVG | asset-graph-map | TODO: add '<!-- purpose: ... -->' near top of SVG. | Embed directly in Markdown or include as <img>; prefer SVG for crispness. | docs\diagrams\_previews\render\asset-graph-map.svg |
| docs\diagrams\assets\blank-1x1.png | Raster | blank-1x1 | TODO: document purpose. | Reference from docs; consider exporting a web-friendly preview. | docs\diagrams\assets\blank-1x1.png |
| docs\diagrams\co-loop.svg | SVG | co-loop | TODO: add '<!-- purpose: ... -->' near top of SVG. | Embed directly in Markdown or include as <img>; prefer SVG for crispness. | docs\diagrams\co-loop.svg |
| docs\diagrams\engagement-ladder.svg | SVG | engagement-ladder | TODO: add '<!-- purpose: ... -->' near top of SVG. | Embed directly in Markdown or include as <img>; prefer SVG for crispness. | docs\diagrams\engagement-ladder.svg |
| docs\diagrams\one-week-microproject.svg | SVG | one-week-microproject | TODO: add '<!-- purpose: ... -->' near top of SVG. | Embed directly in Markdown or include as <img>; prefer SVG for crispness. | docs\diagrams\one-week-microproject.svg |
| docs\diagrams\render\academy\vital-signs.mmd | Mermaid | vital-signs | TODO: add '%% purpose: ...' comment on the first lines. | Embed in Markdown using \`mermaid fences; CI exports previews under docs/diagrams/_previews when available. | docs\diagrams\render\academy\vital-signs.mmd |
| docs\diagrams\render\academy\vital-signs.vl.json | Vega-Lite | vital-signs.vl | TODO: add a 'description' field in the JSON root. | Render via Vega/Vega-Lite; for docs, include a PNG/SVG export or link to a viewer. | docs\diagrams\render\academy\vital-signs.vl.json |
| docs\diagrams\render\advice\advicebomb-lifecycle.mmd | Mermaid | advicebomb-lifecycle | TODO: add '%% purpose: ...' comment on the first lines. | Embed in Markdown using \`mermaid fences; CI exports previews under docs/diagrams/_previews when available. | docs\diagrams\render\advice\advicebomb-lifecycle.mmd |
| docs\diagrams\render\architecture\coagent-4-panel.mmd | Mermaid | coagent-4-panel | TODO: add '%% purpose: ...' comment on the first lines. | Embed in Markdown using \`mermaid fences; CI exports previews under docs/diagrams/_previews when available. | docs\diagrams\render\architecture\coagent-4-panel.mmd |
| docs\diagrams\render\architecture\cosuite-high-level.mmd | Mermaid | cosuite-high-level | TODO: add '%% purpose: ...' comment on the first lines. | Embed in Markdown using \`mermaid fences; CI exports previews under docs/diagrams/_previews when available. | docs\diagrams\render\architecture\cosuite-high-level.mmd |
| docs\diagrams\render\asset-graph.d2 | OtherDiagram | asset-graph | TODO: document purpose. | Reference from docs; consider exporting a web-friendly preview. | docs\diagrams\render\asset-graph.d2 |
| docs\diagrams\render\asset-graph.mmd | Mermaid | asset-graph | TODO: add '%% purpose: ...' comment on the first lines. | Embed in Markdown using \`mermaid fences; CI exports previews under docs/diagrams/_previews when available. | docs\diagrams\render\asset-graph.mmd |
| docs\diagrams\render\audit\coaudit-flow.mmd | Mermaid | coaudit-flow | TODO: add '%% purpose: ...' comment on the first lines. | Embed in Markdown using \`mermaid fences; CI exports previews under docs/diagrams/_previews when available. | docs\diagrams\render\audit\coaudit-flow.mmd |
| docs\diagrams\render\cosuite.asset-graph.mmd | Mermaid | cosuite.asset-graph | TODO: add '%% purpose: ...' comment on the first lines. | Embed in Markdown using \`mermaid fences; CI exports previews under docs/diagrams/_previews when available. | docs\diagrams\render\cosuite.asset-graph.mmd |
| docs\diagrams\render\data\data-flows.mmd | Mermaid | data-flows | TODO: add '%% purpose: ...' comment on the first lines. | Embed in Markdown using \`mermaid fences; CI exports previews under docs/diagrams/_previews when available. | docs\diagrams\render\data\data-flows.mmd |
| docs\diagrams\render\governance\governance-container.mmd | Mermaid | governance-container | TODO: add '%% purpose: ...' comment on the first lines. | Embed in Markdown using \`mermaid fences; CI exports previews under docs/diagrams/_previews when available. | docs\diagrams\render\governance\governance-container.mmd |
| docs\diagrams\render\identity\meritrank-reptag.mmd | Mermaid | meritrank-reptag | TODO: add '%% purpose: ...' comment on the first lines. | Embed in Markdown using \`mermaid fences; CI exports previews under docs/diagrams/_previews when available. | docs\diagrams\render\identity\meritrank-reptag.mmd |
| docs\diagrams\render\inseed-timeline.mmd | Mermaid | inseed-timeline | TODO: add '%% purpose: ...' comment on the first lines. | Embed in Markdown using \`mermaid fences; CI exports previews under docs/diagrams/_previews when available. | docs\diagrams\render\inseed-timeline.mmd |
| docs\diagrams\render\legend.mmd | Mermaid | legend | TODO: add '%% purpose: ...' comment on the first lines. | Embed in Markdown using \`mermaid fences; CI exports previews under docs/diagrams/_previews when available. | docs\diagrams\render\legend.mmd |
| docs\diagrams\render\metrics\metrics-index.mmd | Mermaid | metrics-index | TODO: add '%% purpose: ...' comment on the first lines. | Embed in Markdown using \`mermaid fences; CI exports previews under docs/diagrams/_previews when available. | docs\diagrams\render\metrics\metrics-index.mmd |
| docs\diagrams\render\pipelines\ci-diagrams-export.mmd | Mermaid | ci-diagrams-export | TODO: add '%% purpose: ...' comment on the first lines. | Embed in Markdown using \`mermaid fences; CI exports previews under docs/diagrams/_previews when available. | docs\diagrams\render\pipelines\ci-diagrams-export.mmd |
| docs\diagrams\render\politic\copolitic-spectrum.mmd | Mermaid | copolitic-spectrum | TODO: add '%% purpose: ...' comment on the first lines. | Embed in Markdown using \`mermaid fences; CI exports previews under docs/diagrams/_previews when available. | docs\diagrams\render\politic\copolitic-spectrum.mmd |
| docs\diagrams\render\repos\repo-map.mmd | Mermaid | repo-map | TODO: add '%% purpose: ...' comment on the first lines. | Embed in Markdown using \`mermaid fences; CI exports previews under docs/diagrams/_previews when available. | docs\diagrams\render\repos\repo-map.mmd |
| docs\diagrams\render\security\threat-model.mmd | Mermaid | threat-model | TODO: add '%% purpose: ...' comment on the first lines. | Embed in Markdown using \`mermaid fences; CI exports previews under docs/diagrams/_previews when available. | docs\diagrams\render\security\threat-model.mmd |
| docs\diagrams\render\timeline\roadmap-milestones.mmd | Mermaid | roadmap-milestones | TODO: add '%% purpose: ...' comment on the first lines. | Embed in Markdown using \`mermaid fences; CI exports previews under docs/diagrams/_previews when available. | docs\diagrams\render\timeline\roadmap-milestones.mmd |
| docs\diagrams\vitals\humanity-vitals.mmd | Mermaid | humanity-vitals | TODO: add '%% purpose: ...' comment on the first lines. | Embed in Markdown using \`mermaid fences; CI exports previews under docs/diagrams/_previews when available. | docs\diagrams\vitals\humanity-vitals.mmd |

## CoAgent — Run Flow & Custody

- Source: [docs/diagrams/coagent/coagent_run_flow_and_custody.mmd](docs/diagrams/coagent/coagent_run_flow_and_custody.mmd)
- Preview: [docs/coagent/README.md](docs/coagent/README.md)

## Diagram index

<!-- DIA3_TABLE_START -->
_(Auto-generated by Dia3 WAVE3 at 20251116T073142Z. Edit purposes manually as needed.)_

| Diagram | Purpose / what it explains | Source | Rendered |
| --- | --- | --- | --- |
| Engagement Ladder | TBD — update with human-readable description. | _none yet_ | [$fn](docs\diagrams\engagement-ladder.svg) |
| Vital Signs.Vl | TBD — update with human-readable description. | [$fn](docs\diagrams\render\academy\vital-signs.vl.json) | _none yet_ |
| Req Resp Map | TBD — update with human-readable description. | _none yet_ | [$fn](docs\diagrams\_previews\coagent\req-resp-map.svg) |
| GRAPHICS_MANIFEST | TBD — update with human-readable description. | [$fn](docs\diagrams\vitals\_scan\GRAPHICS_MANIFEST.json) | _none yet_ |
| Data__Data Flows.Mmd | TBD — update with human-readable description. | [$fn](docs\diagrams\meta\data__data-flows.mmd.json) | _none yet_ |
| Roadmap Milestones | TBD — update with human-readable description. | [$fn](docs\diagrams\render\timeline\roadmap-milestones.mmd) | _none yet_ |
| Trust Loop | TBD — update with human-readable description. | [$fn](docs\diagrams\coaudit\trust-loop.mmd) | _none yet_ |
| Pipelines__Ci Diagrams Export.Mmd | TBD — update with human-readable description. | [$fn](docs\diagrams\meta\pipelines__ci-diagrams-export.mmd.json) | _none yet_ |
| Humanity Vitals | TBD — update with human-readable description. | [$fn](docs\diagrams\vitals\humanity-vitals.mmd) | _none yet_ |
| Hub Topology | TBD — update with human-readable description. | [$fn](docs\diagrams\hub\hub-topology.mmd) | _none yet_ |
| Cosuite.Asset Graph.Mmd | TBD — update with human-readable description. | [$fn](docs\diagrams\meta\cosuite.asset-graph.mmd.json) | _none yet_ |
| Architecture__Cosuite High Level.Mmd | TBD — update with human-readable description. | [$fn](docs\diagrams\meta\architecture__cosuite-high-level.mmd.json) | _none yet_ |
| Req Resp | TBD — update with human-readable description. | [$fn](docs\diagrams\coagent\req-resp.mmd) | _none yet_ |
| Advice__Advicebomb Lifecycle.Mmd | TBD — update with human-readable description. | [$fn](docs\diagrams\meta\advice__advicebomb-lifecycle.mmd.json) | _none yet_ |
| Asset Graph.Mmd | TBD — update with human-readable description. | [$fn](docs\diagrams\meta\asset-graph.mmd.json) | _none yet_ |
| Co Loop | TBD — update with human-readable description. | _none yet_ | [$fn](docs\diagrams\co-loop.svg) |
| Vital Signs Chart | TBD — update with human-readable description. | _none yet_ | [$fn](docs\diagrams\_previews\render\academy\vital-signs-chart.svg) |
| Audit__Coaudit Flow.Mmd | TBD — update with human-readable description. | [$fn](docs\diagrams\meta\audit__coaudit-flow.mmd.json) | _none yet_ |
| 05_Ai.Governance | TBD — update with human-readable description. | [$fn](docs\diagrams\examples\05_ai.governance.json) | _none yet_ |
| Blank 1X1 | TBD — update with human-readable description. | _none yet_ | [$fn](docs\diagrams\assets\blank-1x1.png) |
| Timeline__Roadmap Milestones.Mmd | TBD — update with human-readable description. | [$fn](docs\diagrams\meta\timeline__roadmap-milestones.mmd.json) | _none yet_ |
| Copolitic Spectrum | TBD — update with human-readable description. | [$fn](docs\diagrams\render\politic\copolitic-spectrum.mmd) | _none yet_ |
| Cosuite.Asset Graph | TBD — update with human-readable description. | [$fn](docs\diagrams\examples\cosuite.asset-graph.json)<br>[$fn](docs\diagrams\render\cosuite.asset-graph.mmd) | _none yet_ |
| Metrics__Metrics Index.Mmd | TBD — update with human-readable description. | [$fn](docs\diagrams\meta\metrics__metrics-index.mmd.json) | _none yet_ |
| ABSOLUTE_LINKS | TBD — update with human-readable description. | [$fn](docs\diagrams\ABSOLUTE_LINKS.json) | _none yet_ |
| Inseed Timeline.Mmd | TBD — update with human-readable description. | [$fn](docs\diagrams\meta\inseed-timeline.mmd.json) | _none yet_ |
| Asset Graph Map | TBD — update with human-readable description. | _none yet_ | [$fn](docs\diagrams\_previews\render\asset-graph-map.svg) |
| Intake To Inbox Map | TBD — update with human-readable description. | _none yet_ | [$fn](docs\diagrams\_previews\advicebomb\intake-to-inbox-map.svg) |
| 04_Sites.Outputs | TBD — update with human-readable description. | [$fn](docs\diagrams\examples\04_sites.outputs.json) | _none yet_ |
| Legend | TBD — update with human-readable description. | [$fn](docs\diagrams\render\legend.mmd) | _none yet_ |
| Ci Diagrams Export | TBD — update with human-readable description. | [$fn](docs\diagrams\render\pipelines\ci-diagrams-export.mmd) | _none yet_ |
| Threat Model | TBD — update with human-readable description. | [$fn](docs\diagrams\render\security\threat-model.mmd) | _none yet_ |
| Politic__Copolitic Spectrum.Mmd | TBD — update with human-readable description. | [$fn](docs\diagrams\meta\politic__copolitic-spectrum.mmd.json) | _none yet_ |
| Trust Loop Map | TBD — update with human-readable description. | _none yet_ | [$fn](docs\diagrams\_previews\coaudit\trust-loop-map.svg) |
| Architecture__Coagent 4 Panel.Mmd | TBD — update with human-readable description. | [$fn](docs\diagrams\meta\architecture__coagent-4-panel.mmd.json) | _none yet_ |
| Inventory | TBD — update with human-readable description. | [$fn](docs\diagrams\inventory.json) | _none yet_ |
| Vital Signs | TBD — update with human-readable description. | [$fn](docs\diagrams\render\academy\vital-signs.mmd) | _none yet_ |
| Metrics Index | TBD — update with human-readable description. | [$fn](docs\diagrams\render\metrics\metrics-index.mmd) | _none yet_ |
| 03_Indexing.Gib | TBD — update with human-readable description. | [$fn](docs\diagrams\examples\03_indexing.gib.json) | _none yet_ |
| Legend.Mmd | TBD — update with human-readable description. | [$fn](docs\diagrams\meta\legend.mmd.json) | _none yet_ |
| 01_Repos.Core | TBD — update with human-readable description. | [$fn](docs\diagrams\examples\01_repos.core.json) | _none yet_ |
| Academy__Vital Signs.Mmd | TBD — update with human-readable description. | [$fn](docs\diagrams\meta\academy__vital-signs.mmd.json) | _none yet_ |
| Inseed.Timeline | TBD — update with human-readable description. | [$fn](docs\diagrams\data\inseed.timeline.json) | _none yet_ |
| Identity__Meritrank Reptag.Mmd | TBD — update with human-readable description. | [$fn](docs\diagrams\meta\identity__meritrank-reptag.mmd.json) | _none yet_ |
| Repos__Repo Map.Mmd | TBD — update with human-readable description. | [$fn](docs\diagrams\meta\repos__repo-map.mmd.json) | _none yet_ |
| Governance__Governance Container.Mmd | TBD — update with human-readable description. | [$fn](docs\diagrams\meta\governance__governance-container.mmd.json) | _none yet_ |
| Coagent 4 Panel | TBD — update with human-readable description. | [$fn](docs\diagrams\render\architecture\coagent-4-panel.mmd) | _none yet_ |
| Security__Threat Model.Mmd | TBD — update with human-readable description. | [$fn](docs\diagrams\meta\security__threat-model.mmd.json) | _none yet_ |
| Asset Graph | TBD — update with human-readable description. | [$fn](docs\diagrams\render\asset-graph.mmd) | _none yet_ |
| Cocache Handoff | TBD — update with human-readable description. | [$fn](docs\diagrams\ciprime\cocache-handoff.mmd) | _none yet_ |
| Data Flows | TBD — update with human-readable description. | [$fn](docs\diagrams\render\data\data-flows.mmd) | _none yet_ |
| Meritrank Reptag | TBD — update with human-readable description. | [$fn](docs\diagrams\render\identity\meritrank-reptag.mmd) | _none yet_ |
| Repo Map | TBD — update with human-readable description. | [$fn](docs\diagrams\render\repos\repo-map.mmd) | _none yet_ |
| Advicebomb Lifecycle | TBD — update with human-readable description. | [$fn](docs\diagrams\render\advice\advicebomb-lifecycle.mmd) | _none yet_ |
| Governance Container | TBD — update with human-readable description. | [$fn](docs\diagrams\render\governance\governance-container.mmd) | _none yet_ |
| Cosuite High Level | TBD — update with human-readable description. | [$fn](docs\diagrams\render\architecture\cosuite-high-level.mmd) | _none yet_ |
| Intake To Inbox | TBD — update with human-readable description. | [$fn](docs\diagrams\advicebomb\intake-to-inbox.mmd) | _none yet_ |
| Coaudit Flow | TBD — update with human-readable description. | [$fn](docs\diagrams\render\audit\coaudit-flow.mmd) | _none yet_ |
| One Week Microproject | TBD — update with human-readable description. | _none yet_ | [$fn](docs\diagrams\one-week-microproject.svg) |
| Inseed Timeline | TBD — update with human-readable description. | [$fn](docs\diagrams\render\inseed-timeline.mmd) | _none yet_ |
| Seed.Asset Graph | TBD — update with human-readable description. | [$fn](docs\diagrams\examples\seed.asset-graph.json) | _none yet_ |
| Diagram.Schema | TBD — update with human-readable description. | [$fn](docs\diagrams\schemas\diagram.schema.json) | _none yet_ |
| Minimal | TBD — update with human-readable description. | [$fn](docs\diagrams\examples\minimal.json) | _none yet_ |
| 02_Services.Pipelines | TBD — update with human-readable description. | [$fn](docs\diagrams\examples\02_services.pipelines.json) | _none yet_ |
<!-- DIA3_TABLE_END -->


