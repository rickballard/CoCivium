# Emits a CI snapshot file under admin/history from GitHub Actions runs.
[CmdletBinding()]
param([int]$Limit=30)
$histDir = "admin/history"
$stamp = Get-Date -Format "yyyyMMdd_HHmm"
$out = Join-Path $histDir "CI_Snapshot_$stamp.md"
$runs = gh run list --limit $Limit --json databaseId,workflowName,status,conclusion,createdAt,updatedAt,url
$items = $runs | ConvertFrom-Json
$lines = @("# CI Snapshot — $(Get-Date -Format 'yyyy-MM-dd HH:mm')","","| Workflow | Status | Conclusion | Age (d) | URL |","|---|---|---|---:|---|")
foreach($r in $items){
  $age = [int]((New-TimeSpan -Start ([datetime]$r.createdAt) -End (Get-Date)).TotalDays)
  $lines += "| $($r.workflowName) | $($r.status) | $($r.conclusion) | $age | $($r.url) |"
}
$lines -join "`r`n" | Out-File -Encoding utf8 -Force $out
Write-Host "Wrote $out"
