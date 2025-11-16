param([string]$Schema = "$PSScriptRoot/receipts.schema.json",
      [string]$Glob   = "$PSScriptRoot/receipt_*.json")

$ErrorActionPreference='Stop'
$files = Get-ChildItem -Path $Glob -File -ErrorAction SilentlyContinue
if (-not $files) { Write-Host "No receipts found ($Glob)"; exit 0 }
$schema = Get-Content -Raw -Path $Schema
foreach ($f in $files) {
  $json = Get-Content -Raw -Path $f.FullName
  if (Test-Json -Json $json -Schema $schema) {
    Write-Host "OK  $($f.Name)" -ForegroundColor Green
  } else {
    Write-Error "FAIL $($f.Name)"
  }
}
