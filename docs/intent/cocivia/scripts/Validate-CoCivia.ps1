# Validate-CoCivia.ps1
param([Parameter(Mandatory=$true)][string]$Path)
Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'
Get-ChildItem -Path $Path -Recurse -Include *.json | ForEach-Object {
  try { $_.FullName | Get-Content -Raw | ConvertFrom-Json | Out-Null; Write-Host "OK: $($_.FullName)" }
  catch { Write-Error "Invalid JSON: $($_.FullName)" }
}
