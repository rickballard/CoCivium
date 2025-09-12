<!-- status: stub; target: 150+ words -->
# Sentinels & Policy Nudges

- Keep warnings by default; use hard‑fails sparingly (with rollback noted).
- Required links in README (Idea Issue, Issues/choose, Edit‑this‑file).
- Smoke check script: LF line endings, required links present, no BOM; friendly messages with “fix in <60s.”
- “Two‑Eyes” review norm (prefer suggest diffs; keep convo on PR).
- RickPad/Supplemental referenced from `SENTINELS.md` for deeper notes.

**PR checklist snippet**
- [ ] Names clear to a newcomer
- [ ] Reversible (rollback steps)
- [ ] Sentinel nudge touched
- [ ] Breadcrumb (WHY/WHAT/NEXT)
- [ ] Falsifiable test stated
- [ ] Session‑only / no hidden global state


