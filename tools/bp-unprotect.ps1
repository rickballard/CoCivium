param([string]$Branch='main', [string]$Repo)
$ErrorActionPreference='Stop'; Set-StrictMode -Version Latest
. (Join-Path $PSScriptRoot 'heartbeat.ps1')
. (Join-Path $PSScriptRoot 'gh-safe.ps1')
if (-not $Repo) { $Repo = gh repo view --json nameWithOwner -q .nameWithOwner }
Invoke-WithHeartbeat "removing protection on $Branch" {
  [void](Invoke-GhApiSafe -Path "repos/$Repo/branches/$Branch/protection" -Method DELETE -Quiet)
}
$code = Invoke-GhApiSafe -Path "repos/$Repo/branches/$Branch/protection" -Method GET -Quiet
if ($code -eq 0) { Write-Host "⚠️ $Branch still protected" } else { Write-Host "✅ $Branch unprotected" }