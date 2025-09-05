[CmdletBinding()] param([switch]$DryRun)
Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'

$repo = Join-Path $HOME "Documents\GitHub\CoCivium"
if(!(Test-Path $repo)){ throw "Repo not found: $repo" }

# Build the child command line-by-line (no premature variable expansion)
$innerLines = @(
  "try {"
  "  Set-Location -LiteralPath '$repo'"
  "  if (Get-Command Write-OEStatus -ErrorAction Ignore) {"
  "    Write-OEStatus -Event 'workbench-launched'"
  "  } else {"
  "    $v = $PSVersionTable.PSVersion"
  '    Write-Host ("OE Status — event: workbench-launched • pwsh: {0} • dir: {1}" -f $v,$PWD)'
  "  }"
  "} catch {"
  '  Write-Host ("Workbench launch note: " + $_.Exception.Message)'
  "}"
)
$inner = [string]::Join("`n",$innerLines)
$enc   = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($inner))

$wt = (Get-Command wt.exe -ErrorAction SilentlyContinue)?.Source
if($wt){
  $args = @('new-tab','--title','CoCivium Repo','--startingDirectory',"$repo",
            'pwsh','-NoLogo','-NoExit','-EncodedCommand', $enc)
  if($DryRun){ 'wt.exe ' + ($args -join ' ') } else { Start-Process -FilePath $wt -ArgumentList $args | Out-Null }
} else {
  $pwsh = (Get-Command pwsh).Source
  $args = @('-NoLogo','-NoExit','-WorkingDirectory',"$repo",'-EncodedCommand', $enc)
  if($DryRun){ 'pwsh ' + ($args -join ' ') } else { Start-Process -FilePath $pwsh -ArgumentList $args | Out-Null }
}
