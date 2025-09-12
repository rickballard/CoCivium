param(
  [int]$PR,
  [string]$Subject = "Admin squash-merge",
  [string]$Tag,
  [string]$Repo,
  [switch]$AllowMissingPR,
  [switch]$SkipMerge
)
$ErrorActionPreference='Stop'; Set-StrictMode -Version Latest
. (Join-Path $PSScriptRoot 'heartbeat.ps1')
. (Join-Path $PSScriptRoot 'gh-safe.ps1')
if (-not $Repo) {
  $Repo = gh repo view --json nameWithOwner -q .nameWithOwner
  if (-not $Repo) { throw "gh repo context not found. Pass -Repo <owner/name>." }
}
$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
function Get-PrState([int]$Number) {
  try {
    $s = gh pr view $Number -R $Repo --json state -q .state
    if ($LASTEXITCODE -eq 0 -and $s) { return $s.Trim() } else { return $null }
  } catch { return $null }
}
if (-not $SkipMerge -and $PR) {
  $state = Get-PrState $PR
  if ($null -eq $state) {
    if (-not $AllowMissingPR) { throw "PR #$PR not found in $Repo. Use -AllowMissingPR to continue without merging." }
  } elseif ($state -ne 'MERGED') {
    Invoke-WithHeartbeat "merging PR #$PR" { gh pr merge $PR -R $Repo --squash --delete-branch=false --subject $Subject --admin | Out-Null }
    $state = Get-PrState $PR
    if ($state -ne 'MERGED') { throw "Merge failed/blocked for PR #$PR in $Repo." }
  }
}
Invoke-WithHeartbeat "syncing main" {
  git -C $RepoRoot fetch origin --prune | Out-Null
  git -C $RepoRoot reset --hard origin/main  | Out-Null
}
if ($Tag) {
  $msg = $Subject + ($(if ($PR) { " (PR #$PR)" } else { "" }))
  Invoke-WithHeartbeat "moving tag $Tag" {
    git -C $RepoRoot tag -fa $Tag -m $msg | Out-Null
    git -C $RepoRoot push -f origin "refs/tags/$Tag" | Out-Null
  }
  Write-Host "✓ Tag '$Tag' -> $(git -C $RepoRoot rev-parse --short HEAD)"
} else {
  Write-Host "✓ Main synced$(if ($PR) { '; PR handled/skipped' })"
}