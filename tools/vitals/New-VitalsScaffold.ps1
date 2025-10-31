param()

$ErrorActionPreference = "Stop"
$root = (git rev-parse --show-toplevel)

$docsDir = Join-Path $root "docs/diagrams/vitals"
$methods = Join-Path $docsDir "methods"
$dataRaw = Join-Path $root "data/vitals/raw"
$dataNorm= Join-Path $root "data/vitals/normalized"

$null = New-Item -ItemType Directory -Force $docsDir,$methods,$dataRaw,$dataNorm | Out-Null

$catalog = @"
metrics:
  - key: LifeExpectancy
    title: Life Expectancy
    unit: years
    direction: higher-is-better
    normalize: minmax
    min: 20
    max: 85
  - key: Literacy
    title: Literacy Rate
    unit: percent
    direction: higher-is-better
    normalize: minmax
    min: 0
    max: 100
  - key: ExtremePovertyInv
    title: Extreme Poverty (1 - share)
    unit: percent
    direction: higher-is-better
    normalize: minmax
    min: 0
    max: 100
weights:
  LifeExpectancy: 1
  Literacy: 1
  ExtremePovertyInv: 1
"@
$catalog | Set-Content -Encoding UTF8 (Join-Path $docsDir "VITALS_CATALOG.yml")

# method stubs
$stubs = @(
  @{k='LifeExpectancy';     name='life-expectancy.md';     desc='UN WPP / OWID life expectancy. Normalize min-max (20–85).'},
  @{k='Literacy';           name='literacy.md';            desc='UNESCO literacy; harmonize definitional changes.'},
  @{k='ExtremePovertyInv';  name='extreme-poverty-inv.md'; desc='World Bank Povcal / OWID; use 1 - share under $2.15.'}
)
foreach($s in $stubs){
  $p = Join-Path $methods $s.name
  if(!(Test-Path $p)){
@"
# $($s.k) – Method

**Concept:** $($s.desc)

**Primary sources:** (to fill)  
**Backup sources:** (to fill)

**Pipeline:**
1) Collect → `data/vitals/raw/$($s.k).csv`
2) Transform & normalize (min-max to 0–100) → `data/vitals/normalized/$($s.k).csv`

**Biases / caveats:** (to fill)  
**Changelog:** (to fill)
"@ | Set-Content -Encoding UTF8 $p
  }
}

# Ensure diagrams inventory contains vitals entries
$inv = Join-Path $root "docs/diagrams/INVENTORY.md"
$rows = @"
| Path | Kind | Preview (expected) | Notes |
|------|------|---------------------|-------|
| docs/diagrams/render/academy/vital-signs.mmd     | Mermaid (method) | docs/diagrams/_previews/render/academy/vital-signs-map.svg   | Methodology map |
| docs/diagrams/render/academy/vital-signs.vl.json | Vega-Lite (chart)| docs/diagrams/_previews/render/academy/vital-signs-chart.svg | Time-series + composite "Vitality" |
"@
if(!(Test-Path $inv)){
  "# Graphics Inventory`n`n$rows" | Set-Content -Encoding UTF8 $inv
}else{
  Add-Content -Encoding UTF8 $inv "`n$rows"
}

Write-Host "Scaffold complete."
