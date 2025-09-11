<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
# Troubleshooting

**Symptom:** Ctrl+C feels “different” or prompt looks stuck.
**Fix:** The kit wraps the prompt when inside a repo. Run:
```powershell
Disable-CoBrandAuto; Stop-CoBrand
CoBP-Deflate -KillRunning
```
If relaunch occurred:
```powershell
. scripts/CoVibe.BP.ps1; co-rescue
```

**Symptom:** Laggy prompt in huge repos.
**Fix:** Increase cache window:
```powershell
$env:CO_BP_PROBE_SEC = '8'
```
Slow‑probe guard will also skip heavy checks for a few prompts if a probe >150ms.

**Symptom:** PS complains about StrictMode / `$PSCommandPath`.
**Fix:** Kit uses a guard for the path anchor. Re‑source:
```powershell
. scripts/CoVibe.BP.ps1
```









