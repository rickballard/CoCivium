param(
  [int]$Last = 15,
  [string]$Url
)
Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'
if (-not $Url) {
  $Desktop = [Environment]::GetFolderPath('Desktop')
  $Beacon  = Join-Path $Desktop 'CoCivBus_Beacon.json'
  if (-not (Test-Path $Beacon)) { throw "Provide -Url or place CoCivBus_Beacon.json on Desktop." }
  $Url = (Get-Content $Beacon -Raw | ConvertFrom-Json).bus_url
}
try {
  $raw = (Invoke-WebRequest -UseBasicParsing -Uri $Url -TimeoutSec 30).Content
} catch {
  throw "Failed to fetch $Url — $($_.Exception.Message)"
}
$raw -split "`r?`n" | Where-Object { $_.Trim() -ne '' } | Select-Object -Last $Last | Write-Output
