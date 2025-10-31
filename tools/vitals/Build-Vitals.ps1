param([switch]$VerboseLog)

$ErrorActionPreference='Stop'
$root = (git rev-parse --show-toplevel)
$norm = Join-Path $root 'data/vitals/normalized'
$raw  = Join-Path $root 'data/vitals/raw'
$null = New-Item -ItemType Directory -Force $norm,$raw | Out-Null

# Toy seed values (replace with real collectors later)
$toy = @{
  'LifeExpectancy' = @(
    @{t=1800; v=25}, @{t=1900; v=31}, @{t=2000; v=67}, @{t=2020; v=72}
  )
  'Literacy' = @(
    @{t=1800; v=12}, @{t=1900; v=21}, @{t=2000; v=82}, @{t=2020; v=86}
  )
  'ExtremePovertyInv' = @(
    @{t=1800; v=5}, @{t=1900; v=8}, @{t=2000; v=85}, @{t=2020; v=92}
  )
}

foreach($k in $toy.Keys){
  $path = Join-Path $norm "$k.csv"
  "t,v" | Set-Content -Encoding UTF8 $path
  $toy[$k] | ForEach-Object { "{0},{1}" -f $_.t,$_.v } | Add-Content -Encoding UTF8 $path
  if($VerboseLog){ Write-Host "Wrote $path" }
}

Write-Host "Normalized series written."
