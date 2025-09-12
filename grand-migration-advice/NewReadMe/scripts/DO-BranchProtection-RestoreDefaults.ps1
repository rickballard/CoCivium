# Apply sane default protections
$ErrorActionPreference='Stop'; Set-StrictMode -Version Latest
if (-not (Get-Command gh -ErrorAction SilentlyContinue)) { throw "gh not found" }

$repo = (gh repo view --json nameWithOwner | ConvertFrom-Json).nameWithOwner
if (-not $repo) { throw "Unable to resolve repo via gh" }

# Minimal default JSON; adjust as needed
$json = @{
  required_status_checks = @{ strict = $true; contexts = @() }
  enforce_admins = $true
  required_pull_request_reviews = @{
    required_approving_review_count = 1
    dismiss_stale_reviews = $true
    require_code_owner_reviews = $true
  }
  restrictions = $null
  required_linear_history = $true
  allow_force_pushes = $false
  allow_deletions = $false
} | ConvertTo-Json -Depth 5

$tmp = New-TemporaryFile
$json | Set-Content -Path $tmp -Encoding UTF8
gh api -X PUT repos/$repo/branches/main/protection --input $tmp --header "Content-Type: application/json"
Remove-Item $tmp -Force

Write-Host "Default branch protections applied." -ForegroundColor Green
