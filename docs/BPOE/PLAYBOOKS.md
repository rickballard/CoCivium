# BPOE — Doc-only PRs (README, *.md)

1) Branch hygiene: \gh pr checkout <PR>\ → \git rebase origin/main\ or new clean branch; resolve README & stubs deterministically.
2) Canonicalize links; write LF-only (UTF-8 no BOM) and \git add --renormalize\.
3) Merge path (choose one):
   - Get a **second reviewer** to approve; then squash-merge.
   - Or temporarily lower “Required approving reviews”/**disable last-push approval** in Branch Protection (UI), squash-merge, **restore** the rule.
4) Keep redirect stubs for moved docs to avoid link rot.

---

## 🔐 Rule: Ban Raw `.odt` Dumps in Commit History

Avoid committing session output (`*.odt`, `*.log`, `*.bak`) unless:
- Contents are fully reviewed, scrubbed, and markdown-extracted
- They are part of a curated insights archive with clear rationale

Add `*.odt` to `.gitignore` globally.
Use `PS7TranscriptCleaner.ps1` before exporting logs.
