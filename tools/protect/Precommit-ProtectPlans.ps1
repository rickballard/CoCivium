param([string]$RepoRoot = (Get-Location).Path)
Set-StrictMode -Version Latest; $ErrorActionPreference = "Stop"
$staged = git diff --cached --name-only
$viol = $staged | Where-Object { $_ -like "plans/private/*" -and $_ -notmatch "\.enc\." }
if ($viol) {
  Write-Host "❌ Blocked: plaintext in plans/private — use encrypted *.enc.* files or wait until SOPS is wired." -ForegroundColor Red
  $viol | ForEach-Object { Write-Host " - $_" -ForegroundColor Yellow }
  exit 1
}
exit 0
