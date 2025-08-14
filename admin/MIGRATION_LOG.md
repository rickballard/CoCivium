# MIGRATION_LOG
Definition: Each entry logs a *move or copy* between Civium and CoCivium trees, or within CoCivium during grooming.

## Columns
YYYY-MM-DD, actor, src, dst, items, bytes, sha256_manifest, notes

## Examples
2025-08-11, rick, admin/inbox/GmailDump_20250811, deprecated/holding/GmailDump_20250811, 52, 196_734_112, 3f3a2ef4..., moved originals; inventory report in reports/inventory_20250811_0657.md
2025-08-11, rick, deprecated/holding/GmailDump_20250811, admin/hold/GmailDump_20250811_sanitized, 52, 191_204_221, 9a7c3bf1..., removed PII; see sanitize log

## Notes
- Use *moves* for relocation; never delete without an earlier move to `admin/hold` or `deprecated/holding`.
- sha256_manifest is the sha256 of the CSV produced by `tools/inventory_audit.py` for the affected paths.
- Keep one entry per operation.  If multiple source folders moved, prefer one line per source.
