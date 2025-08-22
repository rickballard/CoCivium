# CoCivium IssueOps Cheat Sheet (v0)

> **Above the fold — quick triggers (type these in chat)**
>
> - **CoPIN** — “Record a decision (title/DO/ADVISORY) in monthly log.”
> - **CoPreview** — “Open rendered README for current preview branch.”
> - **CoPR** — “Draft a PR from current branch to main with title/body.”
> - **CoEOD** — “Tag & push end-of-day checkpoint.”
> - **CoSweep** — “Run repo sweep (EOL/links/headers) and stage report.”
> - **CoStatus** — “Post a short ‘Working on…’ ping during long analysis.” *(assistant behavior)*
> - **CoOneTask** — “Keep only one scheduled ChatGPT task; prefer GitHub Actions.”

---

## What each trigger means

### CoPIN — record a decision
- Writes an entry to dmin/history/decisions/DECISIONS_YYYYMM.md using 	ools/Pin-Decision.ps1.
- Structure: **DO** (imperatives you can paste), then **ADVISORY** (tips/explanations).

### CoPreview — preview README safely
- Keep main protected; preview branches use eadme/preview_*.
- Renders at: **gh browse README.md --branch <preview>**

### CoPR — create a PR (small, reversible)
- Squash-merge pattern, tiny diffs, human review.

### CoEOD — checkpoint & tag
- Writes dmin/history/progress/LOG_* and pushes od-* tag.

### CoSweep — repo hygiene
- EOL normalization (LF), broken-link report, markdown H1 checks.

### CoStatus — status pings
- Assistant posts a short “Working on: <topic> …” note during longer tasks.

### CoOneTask — automation hygiene
- Keep **one** scheduled task (daily) that reads a **repo bucket** (YAML/MD).
- Prefer GitHub Actions for cadence work.

---

## Handy commands (paste in PowerShell inside the repo)

### Preview current README for your branch
gh browse README.md --branch import/civium_20250822_002829.Trim()

### Create a PR to main
gh pr create -B main -t "TITLE" -b "Short description"

### Tag EOD checkpoint (today)
$ts=Get-Date -Format 'yyyyMMdd_HHmmss'; git tag "eod-"; git push origin "eod-"

### Run link/EOL sweep (writes reports)
pwsh -NoProfile -ExecutionPolicy Bypass -File tools/repo-sweep.ps1

---

*This file is a living reference. Propose edits via a small PR.*
