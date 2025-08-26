# Advanced Contributor Backlog (curated)

_This page lists repo-building work, prioritized. Last updated 2025-08-26._

**How to use this list:** Pick the highest-urgency item you can finish. When you start, open/claim an Issue and link it here. When you submit a PR, link it under the task.

---

## Urgent (0–3 days)

- [ ] **README “New” strip: finalize + land**
  - Ensure date shows for <7 days and hides afterwards; keep top 3 items.
  - Merge the chain: **#261 (manifest)** → **#262 (renderer)** → **#263 (README block)** → **#264 (nightly refresh CI)**.
  - _Next steps:_ Rebase branches onto main, resolve conflicts, run the script locally, then gh pr merge --squash --delete-branch (use --admin when appropriate).

- [ ] **PR unblock sweep (docs/backlog + CC links)**
  - Target: **#260, #261, #262, #263, #264**.
  - _Next steps:_ git fetch --all && git rebase origin/main, fix conflicts (prefer main for README conflicts), push, merge.

- [ ] **START-HERE & CC nav sanity pass**
  - Verify all bullets under “Pick a path” work (README, WORKFLOWS, STYLE, ISSUEOPS, lexicon/, CC hub, Advanced backlog).
  - Verify docs/cc/OVERVIEW.md links Advanced backlog.

## Next (1–2 weeks)

- [ ] **Backlog source-of-truth** → move curated list to docs/backlog/ADVANCED.yaml and add a renderer to produce this .md.
  - Fields: priority (now/next/soon), rea, owner?, links, 
otes.

- [ ] **Workbench polish & tests**
  - Finalize CoPong50/100/150/300/600, CoPongB50/150/300, alias CoCopy.
  - Add Pester tests; minimal usage doc under docs/tools/.

- [ ] **Issue templates + labels + CODEOWNERS**
  - Task, RFC/Design, Docs templates with rea:*, 	ype:*, level:*, priority:*.
  - CODEOWNERS for docs, scripts, actions.

- [ ] **CI: SVG→PNG render**
  - Add Inkscape (or rsvg-convert) step in CI so local Inkscape is optional.

## Soon (this month)

- [ ] **MD lint: mixed backslash & forward slash in one sentence**
  - Repo-wide scan across .md; flag/normalize code vs prose.

- [ ] **CC hub polish**
  - Ensure INDEX.md exists and points to Poetics/Scroll clearly; stabilize scroll version tags.

- [ ] **CoAgent Kit (CoTips)**
  - Collect “A-and-A” paste cue and other workflow micro-wins; publish under docs/cotips/.

- [ ] **Automation**
  - Keep README “New” fresh (CI in #264); optional nightly rebuild of this page from YAML + Issues.

---

## Live feed from Issues (auto-appended)
Below we’ll append any open Issues labeled 	ype:task + level:advanced to catch fresh opportunities.

<!-- LIVE:BEGIN -->
_No live items appended yet._
<!-- LIVE:END -->