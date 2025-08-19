# Error Playbook

## Mojibake (Ã, Â, �) shows up
**Cause:** File saved in the wrong encoding or reinterpreted by the clipboard.
**Fix:**
1. Reopen in an editor that can set **UTF‑8 (no BOM)** explicitly.
2. Convert CRLF to **LF**.
3. Re-run:
   ```powershell
   pwsh ./scripts/smoke.ps1 -Path README.md
   ```

## CI fails: Missing asset
**Cause:** A referenced path like `assets/hero/hero.jpg` doesn’t exist in the repo.
**Fix:** Ensure the file exists at that path (case‑sensitive on Linux runners).

## Pre-commit hook not running
**Fix:**
```powershell
git config core.hooksPath .githooks
```

## README renders but images don’t show on GitHub
- Wait a minute and **hard refresh** (GitHub caches).
- Verify the path is **relative** and committed.
