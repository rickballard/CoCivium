# Content Relocation Policy — Purpose-Lock + Canonical/Derived (v0.1)

**Background-first.** Authors don’t do anything special. CI analyzes PR diffs for: (a) large near-duplicate sections, (b) “Purpose” coverage loss, (c) drift in docs marked as derived/track.

## Author guidance (minimal)
- Put a short **Purpose** near the top (`## Purpose` or `**Purpose.**`).
- If you intentionally copy between docs, optionally add front-matter `canonical_id` or `derived_from`.

## CI rules
- **Fail:** large near-verbatim duplication without relationship; or Purpose coverage < 0.60.
- **Warn→Fail:** derived docs marked `track` that diverge (warn ≥0.20, fail ≥0.35).
- **Freeze labels:** `migration-safe` / `do-not-merge` downgrade fails to warnings during migration.
