# Temporarily relax branch protection on main (backup to file)
$ErrorActionPreference='Stop'; Set-StrictMode -Version Latest
if (-not (Get-Command gh -ErrorAction SilentlyContinue)) { throw "gh not found" }

$repo = (gh repo view --json nameWithOwner | ConvertFrom-Json).nameWithOwner
if (-not $repo) { throw "Unable to resolve repo via gh" }

$backup = Join-Path $PSScriptRoot 'branch-protection.backup.json'
gh api repos/$repo/branches/main/protection > $backup
Write-Host "Backed up current protection to $backup" -ForegroundColor Yellow

Write-Host "Disabling protection on main…" -ForegroundColor Yellow
gh api -X DELETE repos/$repo/branches/main/protection
Write-Host "Protection disabled." -ForegroundColor Green
