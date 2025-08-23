**Title:** Intersessional Advisory — Grand Migration (continue) & Pivot Prep (hold)
**Audience:** “Continue CoCivium Migration” workflow/tab
**Effective:** 2025-08-23
**Status:** Active.  Replace when the pivot PR is opened.

### 1) TL;DR
1) Keep migrating.  Finish the repo consolidation and hygiene.  No new ideas, no scope creep.
2) Pause polish.  Skip root README and visual/hero polishing.  We’ll replace the posture post-pivot.
3) Stay public-tidy.  The repo must remain clean and credible while we talk to contributors.  Treat “maintenance” as the public message.
4) Do not publish pivot docs.  Pivot materials live under docs/pivot/_internal/ and are not linked anywhere public.

### 2) What continues (required migration tasks)
1) Normalize branches, labels, CI, and directory layout per migration plan.
2) Archive current root README as docs/archive/README_pre-pivot.md (unlinked).
3) Sweep temp files and normalize line endings and UTF-8.
4) Ensure admin/ is current: dmin/README.md and dmin/TODO.md reflect only migration blockers.
5) Close or merge stale PRs tied to old structure.  Squash + delete branches.
6) Verify Actions/Pages build green.  No broken shields or badges.

### 3) What pauses (until pivot is live)
1) Root README polish and hero assets (rotating globe, crest).  Park all artwork items.
2) Cognocarta Consenti (CC) full text.  Reduce to a draft ≤500-word Principles page under docs/pivot/_internal/ only.
3) New Idea Cards, outreach experiments, and parallel initiatives not strictly required to land the migration.
4) Elections/EML, accessibility/WCAG, records ISO work.  These return after first pilot.

### 4) Public sales/messaging during migration (use verbatim)
- One-liner: “We’re doing maintenance and housekeeping while preparing small, testable transparency and guardrail modules.  Standards-anchored.  Evidence-first.”
- If asked ‘What’s changing?’ “Less manifesto, more conformance and proof.  We’ll publish modules that map to open standards and ship with validators.  You’ll be able to see pass/fail in public.”
- If asked ‘When?’ “After housekeeping.  No hype—just a concise public update when the first module is ready.”
- If asked ‘Where’s the constitution?’ “Principles stay.  Detailed clauses will track the working modules so practice leads text, not the other way around.”

### 5) Tidy-repo rules (non-negotiable)
1) No broken links in README, docs/, or Actions.
2) No orphaned demo assets.  Park them under docs/archive/ with a short index.
3) Preserve provenance.  If moving files, keep a short pointer note in the old path for one release.
4) Use two-space sentences in prose (not in code).  Enforce LF for .sh .py .yml .md .svg.
5) Commit messages: imperative, include rationale when moving/archiving public-facing files.

### 6) Pivot prep (what you may see but must not publish)
1) Internal staging lives here: docs/pivot/_internal/
   - Post-Migration_Pivot_Prep_Plan_v0.1.md
   - CBPP_Overview.md
   - Crosswalk_*_stub.yml, Conformance_*_template.yml, Evidence_Table_Template.md
   - CC_Core_Principles_DRAFT.md (≤500 words)
2) Do not link or reference these files from any public page or README until the pivot PR.

### 7) Definition of “Migration Done” (exit criteria)
1) All structural moves merged; Actions green; Pages green (if enabled).
2) docs/archive/README_pre-pivot.md present; root README left as a minimal, stable placeholder, not polished.
3) admin/ reflects the new structure and has no stale blockers.
4) No open “cleanup” PRs older than 7 days.
5) docs/pivot/_internal/ exists and is complete but unlinked.

### 8) Risk triggers & escalation
- Trigger: New idea work creeps into migration PRs.  Action: Split into a draft note under docs/pivot/_internal/ideas.md.  Remove from PR.
- Trigger: Public pages start reflecting the pivot prematurely.  Action: Revert.  The pivot must land in one coordinated PR with rationale.
- Trigger: Build breaks.  Action: Stop changes.  Fix CI/Pages before proceeding.

### 9) PR/issue boilerplate (to keep messaging on point)
- PR title (migration): chore(migration): normalize structure; archive pre-pivot README
- PR body (migration): “Housekeeping only.  No posture change.  Prepares for future standards-anchored modules by archiving old assets.  Public messaging remains: maintenance and housekeeping.”
- Issue label set: migration, housekeeping, 
o-polish, pre-pivot.

**End of advisory.**
