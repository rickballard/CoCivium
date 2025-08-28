# Migration Phase 1 — Prep

**Scope (docs-only):** inventory, timelines, owners, and rollback notes.

## Milestones
- [ ] M1: Inventory + owners
- [ ] M2: Risk & rollback
- [ ] M3: Cutover plan

## Rollback
- Draft rollback steps here.

## Phase 1 — Definition of Done (2025-08-27 23:22)
- [ ] BP v0.4 PR merged to main (canonical).
- [ ] Housekeeping PR (EOL/editorconfig/README) merged.
- [ ] Protected-docs scaffolding PR merged (docs-only; optional).
- [ ] Owners listed for Phase 2 tasks.
- [ ] Rollback notes captured.

### Owners
- Migration Lead: @rickballard
- Reviewer(s): @rickballard
  
## Backlog & Priorities (2025-08-27 23:26)
**P0 (Now):**
- Merge BP v0.4 canonical PR.
- Merge repo housekeeping (.gitattributes/.editorconfig/README).
- Phase 1 “DoD” checklist complete.

**P1 (Next):**
- **Protected Docs (GA):** age + Bitwarden flow hardened; README polish; example end-to-end; optional CI guardrails.  
  _Refs:_ docs/security/README.md, tools/CoProtect.ps1, PR: ops/protect-docs-v0.1

**P2:**
- GitHub App + VS Code extension (policy sync, dashboards).

**P3:**
- ChatGPT Actions reference integration (CoAgent API).
