[CmdletBinding()] param([switch]$DryRun)
Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'

$repo = Join-Path $HOME "Documents\GitHub\CoCivium"
if(!(Test-Path $repo)){ throw "Repo not found: $repo" }

if(-not (Get-Command Write-OEStatus -ErrorAction SilentlyContinue)){
  function Write-OEStatus { param([string]$Event='status')
    $v = $PSVersionTable.PSVersion
    Write-Host ("OE Status — event: {0} • pwsh: {1} • dir: {2}" -f $Event,$v,$repo)
  }
}

$pwshCmd = "Set-Location -LiteralPath '$repo'; Write-OEStatus -Event 'workbench-launched'"

$wt = (Get-Command wt.exe -ErrorAction SilentlyContinue)?.Source
if($wt){
  $args = @('new-tab','--title','CoCivium Repo','--startingDirectory',"$repo",
            'pwsh','-NoLogo','-NoExit','-Command', $pwshCmd)
  if($DryRun){ Write-Host ('wt.exe ' + ($args -join ' ')) }
  else { Start-Process -FilePath $wt -ArgumentList $args | Out-Null }
}
else{
  $args = @('-NoLogo','-NoExit','-WorkingDirectory',"$repo",'-Command',$pwshCmd)
  if($DryRun){ Write-Host ('pwsh ' + ($args -join ' ')) }
  else { Start-Process -FilePath (Get-Command pwsh).Source -ArgumentList $args | Out-Null }
}
