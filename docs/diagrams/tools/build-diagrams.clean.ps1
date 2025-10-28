param([string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..\..')).Path)
$ErrorActionPreference='Stop'; Set-StrictMode -Version Latest
$root      = (Resolve-Path $RepoRoot).Path
$jsonDir   = Join-Path $root 'docs\diagrams\examples'
$renderDir = Join-Path $root 'docs\diagrams\render'
$diagMd    = Join-Path $root 'docs\DIAGRAMS.md'
$mmdOut    = Join-Path $renderDir 'asset-graph.mmd'
New-Item -ItemType Directory -Force -Path $renderDir | Out-Null

# Load + unify
$files = Get-ChildItem -Path $jsonDir -Filter *.json -File | Sort-Object Name
$nodes = @(); $links = @()
foreach($f in $files){
  $j = Get-Content $f -Raw -Encoding UTF8 | ConvertFrom-Json -Depth 32
  if($j.nodes){ $nodes += $j.nodes }
  if($j.links){ $links += $j.links }
}
$nodes = $nodes | Sort-Object @{Expression='type'},@{Expression='id'}
$links = $links | Sort-Object @{Expression='source'},@{Expression='target'},@{Expression='rel'}

# Mermaid emit -> lines array
$ts = (Get-Date).ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ssZ')
$lines = @()
$lines += ('%% generated:' + $ts)
$lines += 'flowchart LR'
$groups = $nodes | Group-Object type
foreach($g in $groups){
  $t = if([string]::IsNullOrWhiteSpace($g.Name)) { 'Ungrouped' } else { $g.Name }
  $lines += ('subgraph ' + $t)
  foreach($n in $g.Group){
    $id = $n.id; $label = if([string]::IsNullOrWhiteSpace($n.label)) { $n.id } else { $n.label }
    $lines += ('  ' + $id + '["' + $label + '"]')
  }
  $lines += 'end'
}
foreach($e in $links){
  $src=$e.source; $dst=$e.target; $relLabel = if([string]::IsNullOrWhiteSpace($e.rel)){''}{' |"' + $e.rel + '"|"'}
  $lines += ($src + ' -->' + $relLabel + ' ' + $dst)
}
Set-Content -Path $mmdOut -Value $lines -Encoding UTF8

# Write DIAGRAMS.md with exactly two closed fences
$md = @()
$md += '# CoCivium Diagrams'
$md += ''
$md += 'This page is generated from JSON files under `docs/diagrams/examples/`.'
$md += '**Do not hand-edit the fenced blocks below.** Update JSON and re-run the builder.'
$md += ''
$md += '## Asset Graph (Mermaid, generated)'
$md += '```mermaid'
$md += $lines
$md += '```'
$md += ''
$md += '## D2 (placeholder, reserved)'
$md += '```d2'
$md += '// d2 placeholder; kept to satisfy fence invariants.'
$md += '```'
Set-Content -Path $diagMd -Value $md -Encoding UTF8

# Sanity
if(!(Test-Path $diagMd) -or !(Test-Path $mmdOut)){ throw 'Missing outputs' }
(Get-Content $diagMd -Raw -Encoding UTF8) -match '```mermaid' | Out-Null
(Get-Content $diagMd -Raw -Encoding UTF8) -match '```d2' | Out-Null
