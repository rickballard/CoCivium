param([Parameter(Mandatory)][string]$Repo)

# Ensure helpers even in -NoProfile shells
try { . "$PSScriptRoot\CoVibe.Blocks.ps1" } catch {}
if (-not (Get-Command CoStep -ErrorAction SilentlyContinue)) { function CoStep([string]$Label){ Write-Host ("-- $Label") } }
if (-not (Get-Command CoWait -ErrorAction SilentlyContinue)) { function CoWait([string]$Message){ Write-Host ("[WAIT] $Message") } }

. "$PSScriptRoot\CoVibe.Prefs.ps1"
$p = Get-CoVibePrefs
if(-not $p){ Write-Host "No prefs found; skipping."; exit 0 }

$body = @{
  required_status_checks        = @{ strict = $true; contexts = @() }
  enforce_admins                = $true
  required_pull_request_reviews = @{
    require_code_owner_reviews      = [bool]$p.require_codeowners
    required_approving_review_count = [int] ($p.min_reviews ?? 1)
  }
  restrictions            = $null
  required_linear_history = [bool]$p.linear_history
  allow_force_pushes      = [bool]$p.allow_force_pushes
  allow_deletions         = [bool]$p.allow_deletions
  block_creations         = $false
} | ConvertTo-Json -Depth 6

$tmp = Join-Path $env:TEMP 'covibe_protect.json'
$body | Set-Content $tmp -Encoding utf8
CoStep "Protecting $Repo"
CoWait "GitHub API call; let it finish unless it errors."
gh api -X PUT "repos/$Repo/branches/main/protection" `
  -H "Accept: application/vnd.github+json" `
  -H "Content-Type: application/json" `
  --input $tmp | Out-Null
Remove-Item $tmp -ErrorAction SilentlyContinue
