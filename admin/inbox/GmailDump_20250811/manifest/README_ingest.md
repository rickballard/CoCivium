# GmailDump_20250811 Ingest

**Purpose.** Freeze a set of legacy attachments for audit and later curation.  Originals are preserved bit-for-bit under `originals/`.  A manifest with sizes and SHA-256 hashes is included for integrity checks.  

**What this is.**
- `originals/` — raw files as extracted from the user's Gmail drafts dump.
- `manifest/Civium_GmailDump_Manifest_20250811.csv` — per-file metadata (path, size, sha256, text flag, first 400 chars for text files).
- `manifest/Dedupe_Summary_20250811.csv` — list of duplicates detected _within this dump_ by identical SHA-256.
- `tools/dedupe_against_repo.py` — optional script to compare this dump against the repo tree and annotate duplicates across the repo.

**Recommended commit path.**
Place this whole folder at `admin/inbox/GmailDump_20250811/` in the Civium repo, commit, and push.  Do not rename internal files before commit, to keep the manifest valid.  

**Integrity check.**
To verify on your machine:

```bash
python tools/dedupe_against_repo.py --verify-only admin/inbox/GmailDump_20250811
```

**Curation next steps (suggested).**
1) Run `tools/dedupe_against_repo.py` to find files already present elsewhere in the repo.  
2) Triage text-bearing files for incorporation into `insights/`, `scrolls/`, or `admin/` as appropriate.  
3) For binaries (images, PDFs), link from relevant docs or move into `assets/` with provenance notes.  
4) Leave this inbox snapshot immutable.  Derivatives should reference the source path and SHA-256.
