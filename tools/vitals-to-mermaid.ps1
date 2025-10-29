param(
  [string]$Csv = "docs\diagrams\vitals\data\vitals.csv",
  [string]$Out = "docs\diagrams\vitals\humanity-vitals.mmd"
)
$ErrorActionPreference='Stop'
if(!(Test-Path $Csv)){ throw "CSV not found: $Csv" }
$rows = Import-Csv $Csv
function KV($name){ $rows | ForEach-Object { "{0}: {1}" -f $_.Year, $_.$name } -join ", " }
$le  = KV 'LifeExpectancyIdx'
$pr  = KV 'PovertyReductionIdx'
$co2 = KV 'CO2IntensityInverseIdx'
$mmd = @"
%% Auto-generated from $Csv
xychart-beta
    title: Humanity’s Vitals (normalized)
    x-axis: Year
    y-axis: Normalized Index (0–100)
    series:
      - title: LifeExpectancyIdx
        data: { $le }
      - title: PovertyReductionIdx
        data: { $pr }
      - title: CO2IntensityInverseIdx
        data: { $co2 }
"@
$mmd | Set-Content -Encoding UTF8 $Out
Write-Host "[OK] Wrote $Out" -ForegroundColor Magenta
