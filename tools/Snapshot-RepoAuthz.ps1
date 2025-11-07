param(
  [Parameter(Mandatory=$true)][string]$Repo,
  [Parameter(Mandatory=$true)][string]$OutDir
)
$ErrorActionPreference='Stop'
New-Item $OutDir -ItemType Directory -Force | Out-Null

$perm = gh api "repos/$Repo/actions/permissions"                 | Out-String
$prot = gh api "repos/$Repo/branches/main/protection" 2>$null    | Out-String
$wfs  = gh api "repos/$Repo/actions/workflows"                   | ConvertFrom-Json
$wf   = $wfs.workflows | Where-Object { $_.name -eq 'CoHarmony Quality' } | Select-Object -First 1
$runs = if($wf){ gh api ("repos/$Repo/actions/workflows/{0}/runs?branch=main&per_page=10" -f $wf.id) | Out-String } else { '{}' }

Set-Content -Encoding utf8 (Join-Path $OutDir 'actions.permissions.json')          $perm
Set-Content -Encoding utf8 (Join-Path $OutDir 'branch.main.protection.json')      ($prot -ne '' ? $prot : '{"note":"no branch protection or 404"}')
Set-Content -Encoding utf8 (Join-Path $OutDir 'runs.coharmony-quality.main.json') $runs
Write-Host "Snapshots written to $OutDir"
