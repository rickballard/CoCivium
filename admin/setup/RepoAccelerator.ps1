# RepoAccelerator — v0 (install)
[CmdletBinding(SupportsShouldProcess)]
param()
Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'

$repo  = (Get-Location).Path
$hooks = Join-Path $repo ".githooks"
if(!(Test-Path $hooks)){ New-Item -ItemType Directory -Force -Path $hooks | Out-Null }

# Ensure core.hooksPath points at .githooks (idempotent)
git config core.hooksPath .githooks

# Offer to link a profile snippet (dot-source only; reversible)
$psProfileDir  = Join-Path $HOME "Documents\PowerShell"
$psProfileFile = Join-Path $psProfileDir "Microsoft.PowerShell_profile.ps1"
New-Item -ItemType Directory -Force -Path $psProfileDir | Out-Null
$marker  = "# BEGIN CoCivium RepoAccelerator"
$snippet = ". `"$repo\admin\setup\Profile.Snippet.ps1`""
$body    = if(Test-Path $psProfileFile){ Get-Content -Raw $psProfileFile } else { "" }

if($body -notmatch [regex]::Escape($marker)){
  $append = @"
$marker
$snippet
# END CoCivium RepoAccelerator
"@
  Add-Content -Encoding utf8 $psProfileFile $append
  Write-Host "Profile updated: $psProfileFile"
}else{
  Write-Host "Profile already linked."
}

Write-Host "RepoAccelerator installed (hooksPath + profile link)."
