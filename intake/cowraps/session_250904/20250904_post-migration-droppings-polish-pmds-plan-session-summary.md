---
session: "Grand Migration Cleanup"
date: 2025-09-04
summary: ""
outcomes: []
open_items: []
next_session_hint: ""
---

# Post‑Migration Droppings & Polish (PMDS) — Plan & Session Summary

# Post‑Migration Droppings & Polish (PMDS) — Plan & Session Summary
*Date: 2025-09-04*

---

## Session status note (why you’re getting this file)
This chat session became bloated.  To make handoff to a fresh session clean, here is a concise, ready‑to‑run plan plus a record of what we completed, what remains, and what we intended to do next.

### What we did
- Created a **pilot “Dropped Idea Cards” sweep** from recent CoCivium‑relevant chats, and flagged 15 items as **Missing** or **Partial**, each with a next action.  
- Reframed the effort as a **post‑migration polishing process (PMDS)** rather than an all‑history crawl.  
- Produced a **clean, minimal PMDS plan** with schema, target repo layout, and a paste‑safe PowerShell scaffold to add `ideas/` and refactor logs.  

### What we did not complete (yet)
- Did not run the one‑time scaffold in the repo.  
- Did not convert the top three Missing items into IdeaCards.  
- Did not widen the sweep beyond the initial, recent‑chats pilot.  
- Did not apply any restructuring or renames; only specified the pattern.  

### What we were working on / planned to do next
- After migration close: run the scaffold PR, then convert **three** high‑value Missing items into IdeaCards:  
  1) **CoPush‑AI** (AI→PR injector + Matrix bridge).  
  2) **CoCleanse** (housekeeping + lexicon entry).  
  3) **Open‑Standards Map** (adopt/align/fork stance).  
- Start the **first PMDS batch**: recent chats only, then step back in time in small increments.  
- Keep each PR **tiny and topical**, with traceability to chat timestamps.

---

# PMDS (Post‑Migration Droppings & Polish) — Clean Plan

**Goal.** After migration is closed, sweep CoCivium‑relevant chats in small batches, capture any still‑untracked ideas as **IdeaCards**, and polish the repo structure with tiny, safe PRs.  Chats are inputs.  The repo is ground truth.

**Run when.** Only **after** the migration is closed and `main` is green/protected.

**Outputs.**  
- `ideas/` IdeaCards with chat provenance.  
- `docs/refactor/RESTRUCTURE-MAP.md` (planned → applied moves, with commit hashes).  
- `reports/pmds/` batch logs.

---

## Workflow (7 steps)

1) **Gate.** Migration closed; `main` protected; labels ready (`ideas`, `docs`, `refactor`, `pmds`, `content`).  
2) **Collect (batched).** Start with the most recent chats, then move backward in batches.  Extract only CoCivium‑relevant ideas.  
3) **Normalize.** Canonicalize names, add IDs, and dedupe by title/keywords.  
4) **Match.** Compare each candidate to repo artifacts (files, Issues, PRs, Wiki).  Assign one of: **Present**, **Partial**, **Missing**, **N/A**.  
5) **Act.**  
   - **Missing →** add an **IdeaCard** PR.  
   - **Partial →** strengthen/merge into a named artifact or file.  
   - **N/A →** close with a one‑line rationale (tracked in the batch log).  
6) **Polish.** Apply small refactors per `RESTRUCTURE-MAP.md` (moves/renames with reasons).  One topic per PR.  
7) **Report.** Append a short log under `reports/pmds/` for the batch (counts, links, next picks).

---

## Status definitions

- **Present** — Clear, named artifact exists (IdeaCard/Issue/PR/doc).  
- **Partial** — Footprint exists but not complete or traceable.  
- **Missing** — Nothing concrete in repo.  Must create IdeaCard.  
- **N/A** — Intentionally out of scope for repos.

---

## Minimal IdeaCard schema (front‑matter)

```yaml
---
id: IC-YYYYMMDD-####        # stable ID
title: <canonical idea name>
area: [flows|policy|tools|insights|outreach|metrics|lexicon|other]
status: draft               # draft|active|parked|dropped
owner: rick
emerges_from:
  chats: [YYYYMMDDThhmm#N, ...]
links:
  files: []
  issues: []
rationale: >- One-paragraph why.
acceptance_criteria:
  - Observable criterion 1
next_actions:
  - [type:DOC] Draft /docs/...
---
## Summary
<one paragraph>
```

---

## Target repo layout (PMDS‑touched)

```
/ideas/                  # IdeaCards (source of truth for ideas)
/docs/flows/             # IdeaFlow, DecisionFlow, diagrams
/docs/policy/            # Open-core, locker pattern, governance
/insights/               # Essays (Hybridity Gate, CoGenetics, etc.)
/proposals/              # External partner proposals (Trust-Dashboard)
/tools/<module>/         # Specs + scripts (copush-ai, cocleanse, ...)
/metrics/evomap/         # Ingest spec + plan
/docs/refactor/          # RESTRUCTURE-MAP.md + notes
/reports/pmds/           # Batch audit logs
/lexicon/                # CoCleanse and domain terms
/outreach/               # Founders playbook, Pam LAN kit, Substack plan
```

---

## DO — One‑time scaffolding (run after migration close)

```powershell
# REPOINT → CoCivium
Set-StrictMode -Version Latest; ''|Out-Null
Set-Location "$HOME\Documents\GitHub\CoCivium"; ''|Out-Null
git status -sb; ''|Out-Null

git checkout -b sweeps/pmds-setup-c1; ''|Out-Null
$dirs = @(
  "ideas","docsefactor","docslows","docs\policy","insights","proposals",
  "tools\copush-ai","tools\cocleanse","metrics\evomap","reports\pmds","lexicon",
  "outreachickpublic","outreachounders","outreach\case-studies"
)
$dirs | ForEach-Object { New-Item -ItemType Directory -Force -Path $_ | Out-Null }; ''|Out-Null

@"
---
id: IC-YYYYMMDD-0001
title: <canonical idea name>
area: tools
status: draft
owner: rick
emerges_from: { chats: [] }
links: { files: [], issues: [] }
rationale: >- One-paragraph why.
acceptance_criteria: [ "Observable criterion" ]
next_actions: [ "[type:DOC] Draft /docs/..." ]
---
## Summary
"@ | Set-Content ideas\_TEMPLATE.ideacard.md -Encoding UTF8; ''|Out-Null

"# RESTRUCTURE-MAP (PMDS)`n## Plan`n- (planned moves)`n## Applied`n- (commit-hash — move — reason)" |
  Set-Content docsefactor\RESTRUCTURE-MAP.md -Encoding UTF8; ''|Out-Null

git add -A; ''|Out-Null
git commit -m "PMDS: scaffolding (ideas/, refactor map, templates)"; ''|Out-Null
git status -sb
```

---

## VERIFY

- `ideas/_TEMPLATE.ideacard.md` exists.  
- `docs/refactor/RESTRUCTURE-MAP.md` exists.  
- Branch is `sweeps/pmds-setup-c1` with one commit.

---

## First three conversions (recommended)

1) **CoPush‑AI** → `ideas/IC-<date>-copush-ai.md` + `/tools/copush-ai/SPEC.md`.  
2) **CoCleanse** → `ideas/IC-<date>-cocleanse.md` + `/lexicon/CoCleanse.md`.  
3) **Open‑Standards Map** → `ideas/IC-<date>-standards-map.md` + `/docs/policy/STANDARDS-MAP.md`.

---

## Guardrails

- Small, topical PRs.  Prefix **PMDS:**, squash, delete branch.  
- Every IdeaCard lists its chat provenance.  
- Use `RESTRUCTURE-MAP.md` to plan moves before doing them, then record the commit hash under **Applied**.
