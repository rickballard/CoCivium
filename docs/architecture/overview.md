# CoCivium — Architecture & Repo Layout

This repo organizes canonical content (what we stand behind) separately from drafts/imports (what we triage).

## Top-level
- **/insights** — canonical essays with provenance.
- **/codex, /consent, /intent, /resolution, /ethos, /identity, /discussions, /amendments, /domains, /seed, /lexicon** — themed canonicals.
- **/projects** — one folder per project; canonical README per project, extra docs under \docs/\.
- **/notes** — ops notes and status reports (non-canonical).
- **/docs** — handbooks, architecture, style guides.
- **/staging/_imported** — imported drafts/assets awaiting curation (kept out of CI expectations).
- **/legacy** — archived material.

## Content lifecycle
1) Import draft → \staging/_imported/<repo>/...\
2) Curate + canonicalize → move into the right top-level folder, add frontmatter
3) Update indexes (section READMEs); delete or mark superseded drafts
4) Keep the landing page clean; heavy/disorganized docs stay in \docs/\ or \
otes/\

## Frontmatter contract
Every canonical doc should have:

\\\yaml
---
title: "Title Case Name"
canonical_slug: some-slug
source:
  repo: OriginRepo
  original_path: ./staging/_imported/OriginRepo/path/to/file.md
  imported_on: YYYY-MM-DD
  version: c3
  date: 20250801
supersedes:
  - ./staging/_imported/OriginRepo/path/older_draft.md
---
\\\

