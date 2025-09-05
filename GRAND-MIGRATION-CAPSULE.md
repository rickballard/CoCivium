<<<<<<< HEAD
# Grand Migration Capsule

Purpose: running “inbox” and decisions during the migration. Keep entries tiny.
=======
# CONTEXT CAPSULE — CoAgent Kit (Workbench + BP) — v1
_Last updated: 2025-08-26 01:54:58Z UTC_

## What we shipped (repo‑scoped, reversible)
- **Branding:** Auto‑Brand turns on inside repos; restores stock PS7 outside.
- **Palette:** CoCivium=Cyan; GroupBuild=Green; CoModules=Magenta; CoStack=Yellow; Cognocarta=Blue; CoVibe=DarkCyan.
- **Prompt perf:** branch-name cache + `.git/HEAD` fast path.
- **Slow‑probe guard:** if a probe takes >150ms, skip heavy checks for next 3 prompts.
- **Health/Cleanup:** `CoBP-Health`, `CoBP-Deflate [-KillRunning] [-Hard]`.
- **Timing banners:** `CoBP-Stamp` and `CoBP-Time "DO … / DONE … +Xs"`.
- **Rescue alias:** `co-rescue` → re‑arm kit after PS7 relaunch.
- **Defaults (env toggles):** `CO_BP_AUTOBRAND=1`, `CO_BP_PROBE_SEC=4`, `CO_BP_TOKENS=0` (opt‑in).

## Relaunch Fix
If PS7 relaunches and the prompt looks plain:
```powershell
# from the repo root
. scripts/CoVibe.BP.ps1; co-rescue
```

## Known footguns avoided
- No global PS7 changes; everything is repo‑scoped.
- StrictMode‑safe path anchor for `$script:__CoBP_Path` (guarded with `Get-Variable`).
- `Start-CoBrand` uses a `-Tokens` switch (avoid paste typos like `-TokensStart-CoBrand`).

## Next actions
1. Commit **kit** + **ISSUEOPS.md**; open PR (use helper below if desired).
2. Roll kit to other Co* repos; keep per‑repo accent.
3. Add PR labels if your repo uses them (see `labels.yml`).

## If chat/UI stalls
Copy your last message, refresh the page, then paste a single line:
```
PONG <HH:MM:SS>
```
…and continue.

---

## Copy‑paste‑safe blocks

### A) PS7 profile loader (optional convenience)
```powershell
# Add to your PowerShell profile if you want auto-load in new shells:
$kit = Join-Path $HOME 'Documents\GitHub\CoCivium\scripts\CoVibe.BP.ps1'
if (Test-Path $kit) {
  . $kit
  Set-Alias co-rescue CoBP-Rescue -Scope Global
}
```

### B) ENV Switchboard (session‑local)
```powershell
$env:CO_BP_AUTOBRAND = '1'   # 1=on (default), 0=off
$env:CO_BP_PROBE_SEC = '4'   # branch cache window in seconds
$env:CO_BP_TOKENS    = '0'   # 1=tint PSReadLine tokens
```

### C) Commit + PR (plain git)
```powershell
git add scripts/CoVibe.BP.ps1 docs/ISSUEOPS.md
git commit -m "CoAgent Kit: autobrand, perf guard, health/deflate, timing banners, ISSUEOPS switchboard"
git push --set-upstream origin $(git branch --show-current)
```

### D) PR via helper (if `gh` installed)
```powershell
CoPR-CreateIfMissing -Title "CoAgent Kit: autobrand + perf + ISSUEOPS" -BodyText @'
This PR introduces:
- Repo-scoped Auto-Brand (reversible), perf caching, slow-probe guard
- CoBP-Health / CoBP-Deflate, CoBP-Stamp / CoBP-Time
- ISSUEOPS.md Switchboard + Relaunch Fix
'@
```
>>>>>>> origin/main




