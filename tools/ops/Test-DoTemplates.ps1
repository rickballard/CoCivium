# tools/ops/Test-DoTemplates.ps1
# Fails if known DO templates do not start with Use-CoStatus import/tick.
$ErrorActionPreference='Stop'
$root = (Resolve-Path "$PSScriptRoot\..\..").Path
$targets = @(
  Join-Path $root 'docs\advice\do\DO_Template.ps1'
)
$missing = @()
foreach($t in $targets){
  if (-not (Test-Path $t)) { $missing += "MISSING: $t"; continue }
  $head = Get-Content -LiteralPath $t -TotalCount 25 -ErrorAction Stop
  $joined = ($head -join "`n")
  if ($joined -notmatch '(?s)Use-CoStatus') {
    $missing += "NO HEARTBEAT: $t"
  }
}
if ($missing.Count > 0) {
  Write-Host "[CoStatus Guard] Failures:" -ForegroundColor Red
  $missing | ForEach-Object { Write-Host " - $_" -ForegroundColor Red }
  exit 2
} else {
  Write-Host "[CoStatus Guard] OK — DO templates have heartbeat."
}
