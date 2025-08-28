# CoPong v0.4.4 Notes (Transcript & Tests)

- Transcript path moves to `%LOCALAPPDATA%\CoCivium\.reports` (override via `COCIVIUM_TRANSCRIPT_DIR`).  
- Start‑Transcript with `-ErrorAction Stop`; remember if **we** started it.  
- Only Stop‑Transcript if we started it (avoid killing a user’s existing transcript).  
- After `???`, stop transcript *before* the demark so file locks are released.

**To add**
- Pester tests: import on PS5/PS7; clipboard flow; lock‑free behavior.  
- Confirm no repo‑local `.reports/ps7-transcript.log` usage remains.
