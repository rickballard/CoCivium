# PR Checklist (Migration/Grooming)

- [ ] Branch name uses prefix: `chore/*` (moves), `docs/*` (readme), `feat/*` (new content).
- [ ] `main` untouched; PR targets `main` with review required.
- [ ] If moving content: entry added to `MIGRATION_LOG.md`.
- [ ] Inventory run: `python tools/inventory_audit.py <affected-paths>`; link CSV sha256 in PR description.
- [ ] No destructive deletes.  If deletion necessary, confirm prior move to `admin/hold` or `deprecated/holding`.
- [ ] Commit message includes purpose, counts, and rollback note.
- [ ] Above-the-fold README untouched unless PR is `docs/*` with explicit plan.
