param([string]$RepoRoot = (Split-Path -Parent $PSScriptRoot))
$ErrorActionPreference = "Stop"
if(-not (Test-Path "$RepoRoot/.cosync-allow") -and -not (Test-Path "$RepoRoot/.cosync.ok")){
  Write-Host "CoSync: repo not opted-in (.cosync-allow/.cosync.ok missing) — skipping."
  exit 0
}
param([string]$RepoRoot = (Split-Path -Parent $PSScriptRoot))
$ErrorActionPreference="Stop"; Set-Location $RepoRoot
if(Test-Path "scripts/Measure-CoDrift.ps1"){ pwsh -NoProfile -ExecutionPolicy Bypass -File "scripts/Measure-CoDrift.ps1" | Out-Host }
if(Test-Path "scripts/Update-StatusBlock.ps1"){ pwsh -NoProfile -ExecutionPolicy Bypass -File "scripts/Update-StatusBlock.ps1" | Out-Host }
$hadChanges=$false; git add status/ README.md 2>$null | Out-Null
if(git diff --cached --name-only){
  $hadChanges=$true; $msg="status: CoSync"
  if(Test-Path "status/codrift.json"){ try{ $j=Get-Content "status/codrift.json" -Raw | ConvertFrom-Json; $msg=("status: CoSync (CDI {0}% {1})" -f [int]$j.score,[string]$j.status) }catch{} }
  git commit -m $msg | Out-Null
}
$pushed=$false; try{ if($hadChanges){ git push | Out-Null; $pushed=$true } }catch{}
$cdi="n/a"; $stat="n/a"; if(Test-Path "status/codrift.json"){ try{ $j=Get-Content "status/codrift.json" -Raw | ConvertFrom-Json; $cdi=[int]$j.score; $stat=[string]$j.status }catch{} }
Write-Host ("CoSync: CDI {0}% ({1}); committed: {2}; pushed: {3}" -f $cdi,$stat,([bool]$hadChanges),([bool]$pushed))

