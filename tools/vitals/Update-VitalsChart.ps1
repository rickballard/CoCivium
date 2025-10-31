param()

$ErrorActionPreference='Stop'
$root   = (git rev-parse --show-toplevel)
$norm   = Join-Path $root 'data/vitals/normalized'
$chart  = Join-Path $root 'docs/diagrams/render/academy/vital-signs.vl.json'

# Read the three normalized CSVs we just wrote
function Read-Series($name){
  $p = Join-Path $norm "$name.csv"
  if(!(Test-Path $p)){ return @() }
  Import-Csv $p | ForEach-Object {
    [pscustomobject]@{ t = [int]$_.t; k = $name; v = [double]$_.v }
  }
}

$all = @()
$all += Read-Series 'LifeExpectancy'
$all += Read-Series 'Literacy'
$all += Read-Series 'ExtremePovertyInv'

# Build a composite by mean across keys per year
$byYear = $all | Group-Object t
$comp = @()
foreach($g in $byYear){
  $avg = ($g.Group | Measure-Object v -Average).Average
  $comp += [pscustomobject]@{ t = [int]$g.Name; Vitality = [math]::Round($avg,2) }
}

# Assemble a minimal VL spec
$values = @()
$values += $all | ForEach-Object { @{t=$_.t; k=$_.k; v=$_.v} }
# Note: composite is drawn as a separate layer from aggregated data

$spec = [ordered]@{
  '$schema' = 'https://vega.github.io/schema/vega-lite/v5.json'
  width = 900; height = 420
  data = @{ values = $values }
  layer = @(
    @{
      mark = @{ type='line' }
      encoding = @{
        x = @{ field='t'; type='quantitative'; title='Year'; scale=@{nice=false} }
        y = @{ field='v'; type='quantitative'; title='Normalized index (0–100)'; scale=@{domain=@(0,100)} }
        color = @{ field='k'; type='nominal'; title='Series' }
        opacity = @{ value = 0.6 }
      }
    },
    @{
      mark = @{ type='line'; strokeWidth=4 }
      transform = @(@{ aggregate=@(@{op='mean'; field='v'; as='Vitality'}); groupby=@('t') })
      encoding = @{
        x = @{ field='t'; type='quantitative' }
        y = @{ field='Vitality'; type='quantitative' }
        color = @{ value='black' }
      }
    }
  )
}

$spec | ConvertTo-Json -Depth 9 | Set-Content -Encoding UTF8 $chart
Write-Host "Wrote spec: $chart"

