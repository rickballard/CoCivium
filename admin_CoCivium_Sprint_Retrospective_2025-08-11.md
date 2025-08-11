# CoCivium / Civium — Short Retrospective
**Date:** 2025-08-11  
**Window covered:** Aug 1–11, 2025

## 1) Outcomes (Wins)
- CoCivium repo stood up and linked mentally to Civium source.  "HumanGate" norm reinforced.  DEC footers adopted.  
- Admin taxonomy converging: `admin/hold`, `deprecated/holding`, and named drops like `GmailDump_20250811`.  
- Safer Git habits practiced: stash-before-merge, commit messages with rationale, and non-destructive moves.  
- Readme refactor attempted with above‑the‑fold focus.  Decision trails captured in chat + commits.  

## 2) Friction (Lowlights)
- Repeated file delivery failures (404s, oversized pastes, formatting corruption).  ONEBLOCK packages not reliably downloadable.  
- Readme diff perceived as “no visible change.”  Above‑the‑fold goals not met.  
- Uncertainty about where inbox dumps landed and whether counts match source.  
- Memory/UI noise: “Saved memory full,” stray upload widget, unclear “Shared links” item.  
- Occasional looped asks and partial artefacts due to assistant constraints and switching contexts.  

## 3) Root Causes
- Overreliance on external hosts for scripts and zips.  No guaranteed artifact channel.  
- Mixing migration + grooming in live branches.  Weak separation between *move* and *refactor*.  
- Insufficient inventory tooling for inbox dumps and sanity checks.  
- Too many parallel objectives per session without a single “Definition of Done.”  

## 4) Decisions & Conventions Reaffirmed
- Two spaces after sentences in prose.  Numbered replies.  DEC footer on substantive notes.  
- Use `admin/hold/` for quarantine, `deprecated/holding/` for legacy parking, and keep a `MIGRATION_LOG.md`.  
- Prefer ONEBLOCK deliverables produced **in-session** as downloadable files, with checksums, plus a plain‑text fallback.  
- Default to human review before merges.  Avoid destructive ops on `main`.  

## 5) What Worked
- Stepwise Git guidance with guardrails.  
- Clear “don’t delete, move to hold” practice.  
- Keeping rationale in commit messages and naming with dates.  

## 6) What Didn’t
- Pushing multi-file updates through chat paste.  
- External file links that later 404.  
- Attempting UX/README polish *during* content migration.  

## 7) Risks
- Silent content loss during inbox moves.  
- Drift between local trees and origin due to branch hopping.  
- Confusion between Civium → CoCivium provenance if logs aren’t explicit.  

## 8) Concrete Fixes (Actionable)
1. **Artifact channel:** Generate deliverables here as files, provide sandbox links and SHA256.  Keep a `releases/` folder in CoCivium for canonical drops.  
2. **Inventory tooling:** Add a tiny Python script: count files by extension, hash them, detect dups, and emit a CSV + markdown report.  Run on `admin/inbox/*` and `admin/hold/*`.  
3. **MIGRATION_LOG.md:** One line per move: date, src → dst, count, hash summary, operator.  
4. **Branch policy:** `main` is protected.  Use `feat/*` (content add), `chore/*` (moves), `docs/*` (readme polish).  Merge via PR with checklists.  
5. **README above‑the‑fold:** 6–8 punchy lines + 3‑link “Start Here | Quickstart | Map.”  Everything else moves below the fold.  
6. **ONEBLOCK++:** For any multi‑step change, ship one .zip: scripts, sidecar commit text, and a rollback note.  

## 9) Minimal DO‑TODAY (90 minutes)
- Create `MIGRATION_LOG.md` with a header and examples.  
- Drop `tools/inventory_audit.py` and run it against current inbox/hold folders.  
- Produce a short diff‑oriented `README.plan.md` (top‑of‑page copy only).  

---

### Appendix A — Sample MIGRATION_LOG.md header
```
# MIGRATION_LOG
## Columns: YYYY-MM-DD, actor, src, dst, items, bytes, sha256_manifest
2025-08-11, rick, admin/inbox/GmailDump_20250811, deprecated/holding/GmailDump_20250811, 52, 187MB, 3f3a...
```

### Appendix B — Branch map
- `main` — protected.  
- `chore/move-inbox-20250811` — moves only.  
- `docs/readme-fold-20250811` — above-the-fold rewrite.  
- `feat/evomap-seed` — landing visual seed (later).  

### Appendix C — Commit message pattern
```
chore: move Gmail dump → deprecated/holding (52 files) (20250811)

- preserves originals; see MIGRATION_LOG.md
- inventory report: reports/inventory_20250811.md (sha256: ...)
- rollback: git mv deprecated/holding/GmailDump_20250811 admin/inbox/GmailDump_20250811
```
