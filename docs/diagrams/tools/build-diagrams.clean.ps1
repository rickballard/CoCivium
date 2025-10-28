param([string]$RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..\..')).Path)
$ErrorActionPreference='Stop'; Set-StrictMode -Version Latest
$root      = (Resolve-Path $RepoRoot).Path
$jsonDir   = Join-Path $root 'docs\diagrams\examples'
$renderDir = Join-Path $root 'docs\diagrams\render'
$diagMd    = Join-Path $root 'docs\DIAGRAMS.md'
$mmdOut    = Join-Path $renderDir 'asset-graph.mmd'
New-Item -ItemType Directory -Force -Path $renderDir | Out-Null

$files = Get-ChildItem -Path $jsonDir -Filter *.json -File -ErrorAction SilentlyContinue | Sort-Object Name
$nodes = @(); $links = @()
foreach($f in $files){
  $j = Get-Content $f -Raw -Encoding UTF8 | ConvertFrom-Json -Depth 64
  if($j.nodes){ $nodes += $j.nodes }
  if($j.links){ $links += $j.links }
}
$nodes = $nodes | Sort-Object @{Expression='type'},@{Expression='id'}
$links = $links | Sort-Object @{Expression='source'},@{Expression='target'},@{Expression='rel'}
$warn = @()
foreach($n in $nodes){ if([string]::IsNullOrWhiteSpace($n.id)){ $warn += ("node missing id: " + ($n | ConvertTo-Json -Compress)) } }
foreach($e in $links){ if([string]::IsNullOrWhiteSpace($e.source) -or [string]::IsNullOrWhiteSpace($e.target)){ $warn += ("link missing source/target: " + ($e | ConvertTo-Json -Compress)) } }
if($warn){ "`n[diagram-lint] warnings:" | Write-Host; $warn | ForEach-Object { " - $_" } | Write-Host }
function Escape-Label([string]$s){ if($null -eq $s){ return '' }; return ($s -replace '"','\"') }
$ts = (Get-Date).ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ssZ')
$lines = @()
$lines += ('%% generated:' + $ts)
if(-not $nodes){ $lines += 'flowchart LR' } else { $lines += 'flowchart LR' }
$groups = $nodes | Group-Object type
foreach($g in $groups){
  $t = if([string]::IsNullOrWhiteSpace($g.Name)) { 'Ungrouped' } else { $g.Name }
  $lines += ('subgraph ' + $t)
  foreach($n in $g.Group){
    $id = $n.id; $label = if([string]::IsNullOrWhiteSpace($n.label)) { $n.id } else { $n.label }
    $label = Escape-Label $label
    $lines += ('  ' + $id + '["' + $label + '"]')
  }
  $lines += 'end'
}
foreach($e in $links){
  $src = $e.source; $dst = $e.target
  $rel = $null
  if($e -is [hashtable]){ if($e.ContainsKey('rel')){ $rel = $e['rel'] } }
  elseif($e.PSObject -and $e.PSObject.Properties.Name -contains 'rel'){ $rel = $e.rel }
  $relText = if([string]::IsNullOrWhiteSpace([string]$rel)){ '' } else { ' |"' + [string]$rel + '"|' }
  $lines += ($src + ' -->' + $relText + ' ' + $dst)
}
Set-Content -Path $mmdOut -Value $lines -Encoding UTF8
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
$md += '// placeholder kept to satisfy fence invariants.'
$md += '```'
Set-Content -Path $diagMd -Value $md -Encoding UTF8
if(!(Test-Path $diagMd) -or !(Test-Path $mmdOut)){ throw 'Missing outputs' }
(Get-Content $diagMd -Raw -Encoding UTF8) -match '```mermaid' | Out-Null
(Get-Content $diagMd -Raw -Encoding UTF8) -match '```d2' | Out-Null