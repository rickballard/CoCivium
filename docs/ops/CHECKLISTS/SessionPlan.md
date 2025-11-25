# Session Plan  -  BPOE Checklist

_Operational guardrails for all sessions._

- Prefer **CoBlocks**: PS7 arrays + `WriteAllLines`; **no here-strings**.
- When touching diagrams: keep edits in `.mmd`; README only embeds.
- Ensure CI **guard** exists for README fence + `.mmd` reference + index links.
- If advisory jobs block on legacy files, **quarantine narrowly** via `.markdownlintignore` / `.codespellrc`; open a revert note.
- Use `gh pr view --json statusCheckRollup` for merge readiness; treat only FAIL/TIMED_OUT as blocking.
- Merge docs PRs in declared order; prefer **squash** with branch delete.
- Always drop a **CoSync** note (PRs, paths, next steps).


