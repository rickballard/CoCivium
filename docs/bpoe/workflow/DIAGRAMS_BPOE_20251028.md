# Diagrams BPOE — CI Hardening Learnings

This file captures workflow/BPOE changes for diagrams on 
20251028
.

## Additional learnings
- No here-strings in repo scripts; build arrays/lines programmatically.
- Normalize `uses: actions/...` (forward slashes) in workflows.
- Keep only one pair of artifact uploads; de-dupe by scanning step blocks.
- Ensure top-level `permissions:` { contents: read, actions: write }.
- Guard exact one ```mermaid and one ```d2 in DIAGRAMS.md.
- Builder: escape node labels, tolerate missing link.rel, emit lint warnings.
- Insert artifacts immediately after the drift needle step.
- PS7 URL interpolation: use concatenation or $($var) to avoid `$Branch?x=y` traps.
- `gh` without `--json`: use browser fallback compare URL; optionally backfill PR link.
