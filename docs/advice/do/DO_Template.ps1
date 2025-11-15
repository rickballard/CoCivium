# DO — Example CoStatus-first DO Block
# Paste into PS7 terminal to run; idempotent where possible.

# 1) Session heartbeat line must be first
if (-not (Get-Command Use-CoStatus -ErrorAction SilentlyContinue)) {
  $Mod = Join-Path $PSScriptRoot '..\..\tools\heartbeat\CoStatus.Adapter.psm1'
  if (Test-Path $Mod) { Import-Module $Mod -Force -ErrorAction SilentlyContinue }
}
Use-CoStatus -Pulse 'CU:OK · PU:SOFT · HU:SOFT · WT:OK' -Note 'DO template' -CountdownSec 4 -Drift 0.2

# 2) Your DO steps here (sample)
$ErrorActionPreference='Stop'
$curr = (git rev-parse --abbrev-ref HEAD 2>$null)
"{0} — ready" -f $curr
