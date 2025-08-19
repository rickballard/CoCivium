[CmdletBinding()]
param(
  [string]$Branch = $(git branch --show-current),
  [int]$IntervalSec = 10,
  [switch]$Once
)
function Get-Checks([string]$b){
  $json = gh run list --branch $b --limit 50 --json databaseId,name,displayTitle,status,conclusion,createdAt,htmlUrl 2>$null
  if(-not $json){ return @() }
  $runs = $json | ConvertFrom-Json
  # keep only the newest per workflow name
  $latest = @{}
  foreach($r in $runs){
    if(-not $latest.ContainsKey($r.name) -or ([datetime]$r.createdAt) -gt ([datetime]$latest[$r.name].createdAt)){
      $latest[$r.name] = $r
    }
  }
  $latest.Values | Sort-Object name | Select-Object `
    @{n='WORKFLOW';e={$_.name}},
    @{n='STATUS';e={$_.status}},
    @{n='RESULT';e={$_.conclusion}},
    @{n='AGEm';e={[int]((New-TimeSpan -Start ([datetime]$_.createdAt) -End (Get-Date)).TotalMinutes)}},
    @{n='URL';e={$_.htmlUrl}}
}
do{
  Clear-Host
  Write-Host "GitHub Checks — branch: $Branch  (refresh: $IntervalSec s)  $(Get-Date)" -ForegroundColor Cyan
  $rows = Get-Checks $Branch
  if($rows.Count -eq 0){ "No recent runs found." } else { $rows | Format-Table -AutoSize }
  if($Once){ break }
  Start-Sleep -Seconds $IntervalSec
} while ($true)
