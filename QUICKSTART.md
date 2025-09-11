<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
# CoAgent Kit QuickStart

1) **Source the kit** from your repo root:
```powershell
. scripts/CoVibe.BP.ps1
```
Auto‑Brand activates in repos and restores stock PS7 outside.

2) **(Optional) Turn on syntax tinting** for this session:
```powershell
Start-CoBrand -Tokens
```

3) **Rescue after relaunch** (if prompt looks plain):
```powershell
. scripts/CoVibe.BP.ps1; co-rescue
```

4) **Tune performance** (session‑local):
```powershell
$env:CO_BP_PROBE_SEC = '6'  # fewer git probes; default is 4
```

5) **Troubleshoot**:
```powershell
CoBP-Health
CoBP-Deflate    # add -KillRunning and/or -Hard if needed
```










