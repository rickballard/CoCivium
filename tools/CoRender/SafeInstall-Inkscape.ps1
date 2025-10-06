param([switch]$Uninstall)
Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'
if ($Uninstall) {
  winget uninstall --id Inkscape.Inkscape -e --source winget
  return
}
winget install --id Inkscape.Inkscape -e --source winget --accept-package-agreements --accept-source-agreements
