param(
  [string]$RepoRoot      = "$(Join-Path $HOME 'Documents\GitHub\CoCivium')",
  [Parameter(Mandatory)][string]$BrandId,
  [Parameter(Mandatory)][string]$BrandName,
  [Parameter(Mandatory)][string]$Sector,
  [Parameter(Mandatory)][string]$RegionCode,
  [Parameter(Mandatory)][string]$LensId,
  [string]$LensVersion   = "v1"
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

function UTS {
  (Get-Date).ToUniversalTime().ToString('yyyyMMddTHHmmssZ')
}

Write-Host ">> New-CoEthicsLogEntry: start" -ForegroundColor Cyan

$logRoot    = Join-Path $RepoRoot 'docs\CoEthicsGauge\CoEthicsLog'
$template   = Join-Path $logRoot 'ENTRY_TEMPLATE_v0.json'
$schema     = Join-Path $logRoot 'ENTRY_SCHEMA_v0.json'
$entriesDir = Join-Path $logRoot ("entries\{0}" -f $RegionCode)

if (-not (Test-Path $template)) { throw "Template not found: $template" }
if (-not (Test-Path $schema))   { throw "Schema not found: $schema" }

if (-not (Test-Path $entriesDir)) {
  New-Item -ItemType Directory -Path $entriesDir -Force *> $null
}

$today = Get-Date -Format 'yyyyMMdd'
$fileName = "{0}__{1}__{2}.json" -f $BrandId, $LensId, $today
$outPath  = Join-Path $entriesDir $fileName

Write-Host ("   - Template : {0}" -f $template) -ForegroundColor Gray
Write-Host ("   - Schema   : {0}" -f $schema)   -ForegroundColor Gray
Write-Host ("   - Output   : {0}" -f $outPath)  -ForegroundColor Gray

# Load template JSON
$templateJson = Get-Content $template -Raw | ConvertFrom-Json

# Update key fields
$templateJson.brand.id           = $BrandId
$templateJson.brand.display_name = $BrandName
$templateJson.brand.sector       = $Sector

$templateJson.region.code        = $RegionCode
$templateJson.lens.id            = $LensId
$templateJson.lens.version       = $LensVersion

$nowUtc = (Get-Date).ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ssZ')
$templateJson.timestamps.created_at_utc = $nowUtc
$templateJson.timestamps.updated_at_utc = $nowUtc

# Initial placeholder overall score (author should refine)
$templateJson.overall_score.numeric      = 50
$templateJson.overall_score.band         = "MixedSignals"
$templateJson.overall_score.nods_count   = 0
$templateJson.overall_score.spanks_count = 0

# Write output
$templateJson | ConvertTo-Json -Depth 10 | Set-Content -Path $outPath -Encoding UTF8

Write-Host "   - Wrote entry file (pre-validation)" -ForegroundColor Green

# Validate against schema
$valid = Get-Content $outPath -Raw | Test-Json -SchemaFile $schema
if (-not $valid) {
  throw "Schema validation failed for $outPath"
}

Write-Host ">> New-CoEthicsLogEntry: schema validation OK" -ForegroundColor Green
Write-Host "   Next: open the file, adjust metrics, evidence, and overall_score before committing." -ForegroundColor Gray
