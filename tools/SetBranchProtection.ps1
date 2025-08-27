[CmdletBinding()]
param(
  [string]$Owner    = "rickballard",
  [string]$Repo     = "CoCivium",
  [string]$Branch   = "main",
  [switch]$Apply,              # default: DRY RUN
  [switch]$Relax,              # temporarily relax for migration ops
  [switch]$Reenable            # re-enable after migration
)

function Write-Step($Msg){ Write-Host "== $Msg" }

# Minimal policy (aligns with stub doc)
$requiredChecks = @(
  "safety-gate/gate",
  "readme-smoke/check"
)

# Compose PATCH body
$body = [ordered]@{
  required_status_checks = @{
    strict   = $true
    contexts = $requiredChecks
  }
  enforce_admins = $true
  required_pull_request_reviews = @{
    required_approving_review_count = 1
    dismiss_stale_reviews = $true
  }
  restrictions = $null
  allow_deletions = $false
  allow_force_pushes = $false
  allow_squash_merge = $true
  allow_merge_commit = $false
  allow_rebase_merge = $false
}

if ($Relax) {
  # Relax gates: allow bypass during migration (advisory checks only)
  $body.required_status_checks.contexts = @()   # advisory only
  $body.required_pull_request_reviews.required_approving_review_count = 0
}

if ($Reenable) {
  # Re-enable strict gates post-migration (same as $requiredChecks, 1 review)
  $body.required_status_checks.contexts = $requiredChecks
  $body.required_pull_request_reviews.required_approving_review_count = 1
}

$uri = "repos/$Owner/$Repo/branches/$Branch/protection"
Write-Step "Branch protection plan for $Owner/$Repo@$Branch"
$preview = ($body | ConvertTo-Json -Depth 5)
$preview

if (-not $Apply) {
  Write-Step "DRY RUN — add -Apply to make changes"
  exit 0
}

# Apply via GitHub CLI (auth required)
gh api `
  --method PUT `
  -H "Accept: application/vnd.github.luke-cage-preview+json" `
  $uri -f body="$preview"

Write-Step "Done."
