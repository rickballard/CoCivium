Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'
$repo = Join-Path $HOME "Documents\GitHub\CoCivium"
Set-Location -LiteralPath $repo
try {
  if (Get-Command Write-OEStatus -ErrorAction Ignore) {
    Write-OEStatus -Event 'workbench-launched'
  } else {
    $v = $PSVersionTable.PSVersion
    Write-Host ("OE Status — event: workbench-launched • pwsh: {0} • dir: {1}" -f $v,$PWD)
  }
} catch {
  Write-Host ("Workbench launch note: " + $_.Exception.Message)
}
