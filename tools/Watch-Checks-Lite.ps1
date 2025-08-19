Param([string]$Branch)
$ErrorActionPreference='Stop'
if(-not $Branch -or $Branch.Trim() -eq ""){ $Branch = (git branch --show-current).Trim() }

# only pop if something is active or just started
$json = gh run list --branch $Branch --limit 10 --json databaseId,workflowName,status,conclusion,createdAt,updatedAt,url 2>$null
$runs = @(); if($json){ $o=$json|ConvertFrom-Json; if($o -is [array]){$runs=$o}elseif($o){$runs=@($o)} }
$active = $runs | Where-Object { $_.status -in @('queued','in_progress') }
$recent = $runs | Where-Object { [datetime]$_.createdAt -ge (Get-Date).AddMinutes(-2) }
if(-not $active -and -not $recent){ Write-Host "No active runs. Exiting..."; exit 0 }

while($true){
  Clear-Host
  $stamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
  Write-Host ("GitHub Checks — branch: {0}  (refresh: 10s)  {1}" -f $Branch,$stamp)

  $json = gh run list --branch $Branch --limit 20 --json databaseId,workflowName,status,conclusion,createdAt,url 2>$null
  $rows=@(); if($json){ $o=$json|ConvertFrom-Json; if($o -is [array]){$rows=$o}elseif($o){$rows=@($o)} }
  if($rows.Count -eq 0){ Write-Host "No recent runs found."; break }

  $rows | Sort-Object createdAt -Descending | Select-Object `
    @{n='WORKFLOW';e={$_.workflowName}},
    @{n='STATUS';e={$_.status}},
    @{n='CONCL';e={$_.conclusion}},
    @{n='AGE(m)';e={[int][math]::Abs((New-TimeSpan -Start ([datetime]$_.createdAt) -End (Get-Date)).TotalMinutes)}},
    @{n='ID';e={$_.databaseId}} | Format-Table -AutoSize

  if(-not ($rows | Where-Object { $_.status -in @('queued','in_progress') })){ break }
  Start-Sleep -Seconds 10
}
