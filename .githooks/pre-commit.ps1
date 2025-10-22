# PowerShell pre-commit: repo-wide BPOE for staged Markdown
$ErrorActionPreference='Stop'; Set-StrictMode -Version Latest
$root = Split-Path -Parent $PSScriptRoot
Push-Location $root
try {
  pwsh -NoProfile -File "tools/Apply-BPOERepo.ps1" | Write-Host
  $md = git diff --name-only --diff-filter=ACM
  if ($md) { git add -- $md | Out-Null }
} finally { Pop-Location }

# BPOE: emdash ban (staged-only, scan index blobs)
$files = (& git diff --cached --name-only).Trim().Split([Environment]::NewLine) | Where-Object { $_ }
$bad = @()
foreach($f in $files){
  if($f -notmatch '\.(md|mdx|txt|ps1|psm1|psd1|json|ya?ml|ts|js|css|html)$'){ continue }
  $blob = & git show (":" + $f) 2>$null
  if([string]::IsNullOrEmpty($blob)){ continue }
  if($blob -match [char]0x2014){ $bad += $f }
}
if($bad.Count){
  Write-Error ("BPOE: emdashes are not allowed in staged files:" + [Environment]::NewLine + " - " + ($bad -join ([Environment]::NewLine + " - ")))
  exit 1
}

