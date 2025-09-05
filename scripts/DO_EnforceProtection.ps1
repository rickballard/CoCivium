param(
  [string]$Branch = "main",
  [string[]]$RequiredChecks = @("safety-gate/gate","readme-smoke/check"),
  [bool]$Strict = $true,
  [bool]$AdminBypass = $true, # true => enforce_admins=false
  [int]$ActionsAppId = 15368
)
Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$orig = gh api repos/:owner/:repo/branches/$Branch/protection -H "Accept: application/vnd.github+json" | ConvertFrom-Json

$body = [ordered]@{
  required_status_checks = @{
    strict = $Strict
    checks = @()
  }
  enforce_admins = -not $AdminBypass
  required_pull_request_reviews = @{
    dismiss_stale_reviews           = $orig.required_pull_request_reviews.dismiss_stale_reviews
    require_code_owner_reviews      = $orig.required_pull_request_reviews.require_code_owner_reviews
    require_last_push_approval      = $orig.required_pull_request_reviews.require_last_push_approval
    required_approving_review_count = $orig.required_pull_request_reviews.required_approving_review_count
  }
  restrictions                     = $null
  required_linear_history          = $orig.required_linear_history.enabled
  allow_force_pushes               = $orig.allow_force_pushes.enabled
  allow_deletions                  = $orig.allow_deletions.enabled
  block_creations                  = $orig.block_creations.enabled
  required_conversation_resolution = $orig.required_conversation_resolution.enabled
  lock_branch                      = $orig.lock_branch.enabled
  allow_fork_syncing               = $orig.allow_fork_syncing.enabled
}
foreach($c in ($RequiredChecks | Sort-Object -Unique)) {
  $body.required_status_checks.checks += @{ context = $c; app_id = $ActionsAppId }
}

$tmp = Join-Path $env:TEMP "prot.enforce.json"
($body | ConvertTo-Json -Depth 20) | Set-Content -Path $tmp -Encoding UTF8
gh api -X PUT repos/:owner/:repo/branches/$Branch/protection -H "Accept: application/vnd.github+json" -H "Content-Type: application/json" --input $tmp | Out-Null

Write-Host ("✓ Enforced: branch={0} strict={1} admin_bypass={2} checks=[{3}]" -f $Branch, $Strict, $AdminBypass, ($RequiredChecks -join ", "))
