[**IssueOps Cheat Sheet**](ISSUEOPS_CHEATSHEET.md)

[**IssueOps Cheat Sheet**](ISSUEOPS_CHEATSHEET.md)

# CoAgent Kit (Workbench + BP)

**Principles:** repo‑scoped, respectful‑by‑default, reversible.

## Switchboard (env toggles)
| Variable          | Default | Effect                                                        |
|-------------------|:------:|----------------------------------------------------------------|
| `CO_BP_AUTOBRAND` |  `1`   | Auto brand inside repos; restore stock PS7 outside.           |
| `CO_BP_PROBE_SEC` |  `4`   | Cache git branch (fewer `git` calls).                         |
| `CO_BP_TOKENS`    |  `0`   | Tint PSReadLine tokens (syntax) to brand accent when `1`.     |
| `CO_BRAND`        |   —    | Brand text override.                                          |
| `CO_BRAND_ACCENT` |   —    | ConsoleColor override (Cyan/Green/…; PS7 names).              |

### Relaunch Fix (crash / reopen)
If PS7 relaunches and the prompt looks plain:
```powershell
. scripts/CoVibe.BP.ps1; co-rescue
```

### Quick commands
```powershell
Enable-CoBrandAuto              # brand in repos; restore outside
Disable-CoBrandAuto             # back to stock prompt everywhere
Start-CoBrand -Tokens           # manual enable + syntax tint
Stop-CoBrand                    # manual disable
CoBP-Health                     # show kit health (jobs, vars, probe)
CoBP-Deflate [-KillRunning] [-Hard]  # clean up session; -Hard clears PSReadLine history
CoBP-Stamp -Title "DO ..."      # banner with timestamp
CoBP-Time  -Title "TASK" -Script { <commands> }  # time a block
```

### Performance
- Fast branch detection uses `.git/HEAD` when available.
- **Slow‑probe guard:** if a probe takes >150ms, the next **3 prompts** skip heavy checks.
- Default cache window is **4s** (`CO_BP_PROBE_SEC`). Increase for very large repos.

### Footgun guardrails
- Repo‑scoped by design; no global PS profile edits required.
- StrictMode‑safe path anchor using `Get-Variable` guard.

_Last updated: 2025-08-26 01:54:58Z UTC_
