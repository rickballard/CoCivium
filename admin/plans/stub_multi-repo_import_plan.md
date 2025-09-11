<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
# stub_multi-repo_import_plan

> **This is a stub.** Plan to import assets from **CoCivium** into **CoCivium** safely.

## Goals
- Preserve history where it matters (link back to CoCivium).
- Avoid duplication; prefer consolidation or redirects.
- Keep root uncluttered; stage imports under \legacy/imports/\ or the closest fit in \docs/**\.

## Approach
1. Triage the scan report in \dmin/history/inventory/CIVIUM_SCAN_*.md\.
2. Bucket items:
   - **Adopt** (move into \docs/**\, \dmin/**\, etc.)
   - **Archive** (place under \legacy/imports/CoCivium/**\)
   - **Skip** (superseded)
3. Generate a move-map JSON and commit in one atomic PR, updating any internal links.

## Notes
- When we import, add a header noting origin + original path.
- Gather any workflow lessons into \docs/ERROR_PLAYBOOK.md\ and \WORKFLOW.md\.

---
*Status: stub. Open an Idea Issue to nominate must-import files.*








