# CoStack BP — HumanGate & Safe Paste Blocks

**Always**:
1) **Heartbeat + Timeout** for long ops (visible progress; cancel if exceeds limit).
2) **Explicit HumanGate** where user needs to continue: `Read-Host "Press Enter to continue"  # [Press Enter]`.
3) **No single-line blocks**. Start with a no-op line to avoid double-submit & trigger “Paste anyway”.
4) **Absolute paths or `Set-Location`** at the top of blocks.
5) **UTF-8 no BOM + LF** when writing files.

### Helper functions
- `Invoke-CoSafe -Script { <your long work> } -TimeoutSec 120 -HeartbeatSec 5 -Task "describe work"`
- `CoBP-WaitGate "Press Enter to confirm merge"  # [Press Enter]`
- `CoBP-NoOp`

_Implementation: `scripts/CoVibe.BP.ps1`_