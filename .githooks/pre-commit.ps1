# PowerShell pre-commit: repo-wide BPOE for staged Markdown
$ErrorActionPreference='Stop'; Set-StrictMode -Version Latest
$root = Split-Path -Parent $PSScriptRoot
Push-Location $root
try {
  pwsh -NoProfile -File "tools/Apply-BPOERepo.ps1" | Write-Host
  $md = git diff --name-only --diff-filter=ACM
  if ($md) { git add -- $md | Out-Null }
} finally { Pop-Location }
