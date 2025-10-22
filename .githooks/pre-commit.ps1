$ErrorActionPreference="Stop"
$root   = (git rev-parse --show-toplevel).Trim()
$optin  = (Test-Path (Join-Path $root ".cosync-allow")) -or (Test-Path (Join-Path $root ".cosync.ok"))
$staged = & git diff --cached --name-only --diff-filter=ACMR
if(-not $optin -and ($staged | Where-Object { $_ -like "status/*" -or $_ -eq "README.md" })){
  Write-Error "CoSync: repo is not opted-in but status/ or README changes are staged."
  exit 1
}
exit 0
