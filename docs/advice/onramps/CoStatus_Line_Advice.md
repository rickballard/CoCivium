# CoStatus Line — Advice (non-invasive)

**Intent**: Print a consistent one-line CoStatus in PS7 during each cycle/set/MegaWave without stepping on Co1’s heartbeat evolution.

**Reuse existing assets**
- `tools/heartbeat/Emit-CoBloat.ps1` — emits CU/PU/HU/WT object
- `tools/heartbeat/Write-CoBloatFooter.ps1` — pretty one-line footer

**Drop-in snippet (call where you want a status line)**
```powershell
$root = Get-Location
$hb   = Join-Path $root 'tools/heartbeat'
$emit = Join-Path $hb 'Emit-CoBloat.ps1'
$foot = Join-Path $hb 'Write-CoBloatFooter.ps1'

$stamp  = (Get-Date).ToUniversalTime().ToString('yyyyMMddTHHmmssZ')
$branch = (git rev-parse --abbrev-ref HEAD) 2>$null
$dirty  = -not [string]::IsNullOrWhiteSpace((git status --porcelain) 2>$null)

if (Test-Path $foot) {
  $emitArgs = @{ Stamp=$stamp; Branch=$branch; Dirty=$dirty; NoPrint=$false }
  & $foot @emitArgs
}
elseif (Test-Path $emit) {
  $obj = & $emit 2>$null
  $tiers = if ($obj) { "$($obj.CU)/$($obj.PU)/$($obj.HU)/$($obj.WT)" } else { "?, ?, ?, ?" }
  Write-Host ("[CoStatus] {0}  branch={1}  dirty={2}  tiers={3}" -f $stamp,$branch,$dirty,$tiers)
}
else {
  Write-Host ("[CoStatus] {0}  branch={1}  dirty={2}" -f $stamp,$branch,$dirty)
}
```
Placement: call at start, after meaningful steps (PR open/merge), and end of a wave.
Do **not** modify heartbeat scripts in this wave; Co1 remains evolution owner.
