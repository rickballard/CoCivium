param(
  [string]$Owner  = 'rickballard',
  [string]$Repo   = 'CoCivium',
  [string]$Branch = 'main'
)

$requiredContexts = @('safety-gate/gate','readme-smoke/check')

$payload = @{
  required_status_checks = @{
    strict = $false
    checks = $requiredContexts | ForEach-Object { @{ context = $_ } }
  }
  enforce_admins = $true
  required_pull_request_reviews = $null
  restrictions = $null
  required_linear_history = $true
  allow_force_pushes = $false
  allow_deletions    = $false
  block_creations = $false
  required_conversation_resolution = $true
} | ConvertTo-Json -Depth 6

$tmp = New-TemporaryFile
[IO.File]::WriteAllText($tmp,$payload,[Text.UTF8Encoding]::new($false))
gh api -X PUT "repos/$Owner/$Repo/branches/$Branch/protection" --input $tmp | Out-Null
Remove-Item $tmp -Force

# Echo the important bits
gh api "repos/$Owner/$Repo/branches/$Branch/protection" `
  --jq '{checks:(.required_status_checks.checks // [] | map(.context)),
         admins:(.enforce_admins.enabled),
         linear:(.required_linear_history.enabled),
         conv_resolve:(.required_conversation_resolution.enabled)}'
