# 04  -  Handshake Pipeline

- Writer: `CoCache/scripts/Handshake-Refresh.ps1` → calls CoAgent’s `scripts/Consume-CoCacheRepos.ps1` if present.
- Output: `CoAgent/docs/HANDOFFS/HANDSHAKE.md`.
- “skipped” is normal if the helper isn’t on `main` yet (awaiting PR merge).
- After merge: logs show `VERBOSE: Wrote ...\HANDSHAKE.md`.

