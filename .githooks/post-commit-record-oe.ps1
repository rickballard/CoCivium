# If admin/tools/* changed in this commit and no OE_Snapshot was added, print a hint.
$diff = git diff-tree --no-commit-id --name-only -r HEAD
if($diff | Select-String -SimpleMatch "admin/tools/"){
  $hasSnap = git show --name-only --pretty="" HEAD | Select-String -Pattern "admin/history/OE_Snapshot_"
  if(-not $hasSnap){ Write-Host "[hint] Tools changed. Consider:  pwsh admin/tools/bpoe/Record-Env.ps1" -ForegroundColor Yellow }
}
