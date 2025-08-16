# RepoAccelerator — v0 (uninstall)
[CmdletBinding()]
param()
Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'

# Remove profile block
$psProfileFile = Join-Path $HOME "Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
if(Test-Path $psProfileFile){
  $raw = Get-Content -Raw $psProfileFile
  $raw = $raw -replace "(?s)# BEGIN CoCivium RepoAccelerator.*?# END CoCivium RepoAccelerator`r?`n?",""
  $raw | Out-File -Encoding utf8 -Force $psProfileFile
  Write-Host "Profile unlinked."
}

# Reset hooks path back to default
git config --unset core.hooksPath 2>$null
Write-Host "RepoAccelerator uninstalled."
