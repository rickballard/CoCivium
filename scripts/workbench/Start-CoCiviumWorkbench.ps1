[CmdletBinding()] param([switch]$DryRun)
Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'
$repo  = Join-Path $HOME "Documents\GitHub\CoCivium"
$inner = Join-Path $repo "scripts\workbench\Workbench-Inner.ps1"
if(!(Test-Path $inner)){ throw "Inner script missing: $inner" }
$wt = (Get-Command wt.exe -ErrorAction SilentlyContinue)?.Source
if($wt){
  $args = @('new-tab','--title','CoCivium Repo','--startingDirectory',$repo,'pwsh','-NoLogo','-NoExit','-File',$inner)
  if($DryRun){ "wt.exe " + ($args -join ' ') } else { Start-Process -FilePath $wt -ArgumentList $args | Out-Null }
} else {
  $pwsh = (Get-Command pwsh).Source
  $args = @('-NoLogo','-NoExit','-File',$inner)
  if($DryRun){ "pwsh " + ($args -join ' ') } else { Start-Process -FilePath $pwsh -ArgumentList $args | Out-Null }
}
