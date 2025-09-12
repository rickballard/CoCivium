$ErrorActionPreference='Stop'; Set-StrictMode -Version Latest
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $here
# Delegate to DO-2 block steps (kept inline in README). This script remains as a convenience wrapper.
Write-Host "Use README DO-2 to register the scheduled task (LehaneWatcher)."
