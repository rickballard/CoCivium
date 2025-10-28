# Handoff: Repo Hygiene touched DIAGRAMS wrapper (seed stage)

**What changed (this session)**
- Added/normalized docs/DIAGRAMS.md with two *closed* fenced blocks:
  - \\\mermaid … \\\
  - \\\d2 … \\\
- Added minimal example at docs/diagrams/examples/minimal.json (JSON is canonical).
- Expanded .codespell.words with intentional tokens to keep CI green.
- Added .github/CODEOWNERS entries so changes under docs/diagrams/** and docs/DIAGRAMS.md
  request Diagrams owner review.

**What to beware of**
- Do **not** hand-edit rendered blocks in DIAGRAMS.md; treat as generated views.
- CI Advisory enforces lint hygiene (markdownlint/yamllint/codespell). Prefer JSON-first changes; let generators update fences.
- If generators replace fences, they must always **close** both code blocks.

**Expectations**
- Diagrams session owns all of:
  - docs/diagrams/** (schemas, examples, tools, renders)
  - docs/DIAGRAMS.md
- Other sessions will avoid touching these paths except via PRs requesting your review.

**Next steps (Diagrams)**
1) Wire converters to read docs/diagrams/examples/*.json and overwrite both fenced blocks.
2) Add schema validation: docs/diagrams/schemas/graph.schema.json.
3) Add CI job: rebuild renders and **fail on diff** to enforce freshness.

— Repo Hygiene session @ 2025-10-28 00:16 -04:00
