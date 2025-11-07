# BPOE Workflow Log

_Append-only; latest at bottom._

## 2025-11-07 15:56:50Z — CoAgent diagram wire-up + CI advisory hygiene

- PS7 CoBlocks: **avoid here-strings**; prefer arrays + `WriteAllLines` to stop dialogue leakage.
- Diagram docs: README mermaid embed generated from `.mmd`; index + inventory wired.
- CI guards: added `diagram-readme-guard` (README must close ``` and reference `.mmd`).
- Advisory noise: **quarantined** `docs/index/TODO-INDEX.md` in `.markdownlintignore` and `.codespellrc` (temporary; remove after refactor).
- Green check: use `gh pr view --json statusCheckRollup` to evaluate; ignore NEUTRAL/CANCELLED; fail on FAIL/TIMED_OUT.
- Merge order for this slice: **#512 → #511 → #513** (squash).
- CoSync: notes dropped under `docs/intent/advice/notes/YYYYMMDD/` with PR pointers and next steps.
