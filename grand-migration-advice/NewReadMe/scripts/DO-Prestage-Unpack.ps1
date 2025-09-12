# Unpack v3.2 bundle to CoTemp
$ErrorActionPreference='Stop'; Set-StrictMode -Version Latest
$Downloads = Join-Path $HOME 'Downloads'
$Zip = Join-Path $Downloads 'NewReadMe_proposal_bundle_v3_2.zip'
if (-not (Test-Path $Zip)) { throw "Zip not found: $Zip" }
$Dest = Join-Path $HOME 'Downloads\CoTemp\NewReadMe\proposal'

if (Test-Path $Dest) { Remove-Item $Dest -Recurse -Force }
New-Item -ItemType Directory -Force -Path $Dest | Out-Null

Expand-Archive -Path $Zip -DestinationPath (Split-Path $Dest -Parent) -Force
Write-Host "Prestage complete at $Dest" -ForegroundColor Green
