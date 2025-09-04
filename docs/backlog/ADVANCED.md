# Advanced Contributor Backlog (curated)

_Last updated 2025-08-26._

**How to use this list:** pick the highest-urgency item you can finish. When you start, open/claim an Issue and link it here. When you submit a PR, link it under the task._

---

## Urgent (0–3 days)

- [ ] **README “New” strip: finalize & keep clean**
  - Ensure each item renders with a single > callout and shows a date for <7 days.
  - CI refresh workflow in place (PR #268).

- [ ] **PR unblock sweep (docs/backlog + CC links)**
  - Close superseded PRs (#261–#263), keep active follow-ups (#267, #268).
  - Rebase any content PRs on main and merge.

- [ ] **START-HERE & CC nav sanity pass**
  - Verify “Pick a path” links (README, WORKFLOWS, STYLE, ISSUEOPS, lexicon/, CC hub, Advanced backlog).
  - Confirm docs/cc/OVERVIEW.md links this page.

## Next (1–2 weeks)

- [ ] **Backlog source-of-truth** → move curated list to docs/backlog/ADVANCED.yaml + renderer.
  - Fields: priority (now/next/soon), rea, owner?, links,
otes.

- [ ] **Workbench polish & tests**
  - Finalize CoPong50/100/150/300/600, CoPongB50/150/300, consider CoCopy.
  - Add Pester tests; minimal usage doc under docs/tools/.

- [ ] **Issue templates + labels + CODEOWNERS**
  - Task, RFC/Design, Docs templates with rea:*,   ype:*, level:*, priority:*.

- [ ] **CI: SVG→PNG render**
  - Add Inkscape/rsvg-convert step so local Inkscape stays optional.

## Soon (this month)

- [ ] **MD lint:** mixed backslash/forward-slash in prose; normalize repo-wide.
- [ ] **CC hub polish:** ensure INDEX.md points clearly to Poetics/Scroll; stabilize scroll version tags.
- [ ] **CoAgent Kit (CoTips):** collect workflow micro-wins (A-and-A paste cue, etc.) under docs/cotips/.

---

## Live feed from Issues (auto-appended)
<!-- LIVE:BEGIN -->
_No labeled Issues matched   ype:task + level:advanced right now._
<!-- LIVE:END -->
