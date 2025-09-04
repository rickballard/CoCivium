# Migration Invariants — No-Loss Policy
- No destructive deletes during migration/polish.
- Out-of-place content is **rehomed** (moved) or **archived with a stub**.
- Superseded PRs are closed, not squashed away; discussion/branches preserved.
- Large dumps (CoStage) are deduped to a **canonical** set; non-canonical kept via PR history or `admin/archive/`.
