param()
$ErrorActionPreference='Stop'
$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$root = Split-Path -Parent (Split-Path -Parent (Split-Path -Parent $here))
$ex   = Join-Path $root 'docs/diagrams/examples'
$ren  = Join-Path $root 'docs/diagrams/render'
$md   = Join-Path $root 'docs/DIAGRAMS.md'
if(-not (Test-Path $ren)){ New-Item -ItemType Directory -Path $ren | Out-Null }

function Sid([string]$s){ ($s -replace '[^A-Za-z0-9_]','_') }

# Build union graph from JSONs
$nodeMap=@{}; $linkSet=New-Object System.Collections.Generic.HashSet[string]
$files = Get-ChildItem -File -LiteralPath $ex -Filter *.json | Sort-Object Name
foreach($f in $files){
  $g = Get-Content $f.FullName -Raw | ConvertFrom-Json -Depth 100
  foreach($n in @($g.nodes)){ if($n){
    $id = ""+$n.id; if(-not $id){ continue }
    if(-not $nodeMap.ContainsKey($id)){
      $nodeMap[$id] = @{ label = ($n.PSObject.Properties['label'] ? "$($n.label)" : $id)
                         type  = ($n.PSObject.Properties['type']  ? "$($n.type)"  : 'Misc') }
    }
  }}
  foreach($e in @($g.links)){ if($e){
    $s = ""+$e.source; $t = ""+$e.target; if(-not $s -or -not $t){ continue }
    $rel = ($e.PSObject.Properties['rel'] ? "$($e.rel)" : '')
    [void]$linkSet.Add(("{0}||{1}||{2}" -f $s,$t,$rel))
  }}
}

# Emit Mermaid
$typeGroups=@{}
foreach($id in $nodeMap.Keys){ $t=$nodeMap[$id].type; if(-not $typeGroups.ContainsKey($t)){ $typeGroups[$t]=@() }; $typeGroups[$t]+=$id }
$sb = New-Object System.Text.StringBuilder
[void]$sb.AppendLine('flowchart LR')
foreach($t in $typeGroups.Keys){
  $gid = Sid $t
  [void]$sb.AppendLine("  subgraph $gid")
  foreach($id in $typeGroups[$t]){ $label = $nodeMap[$id].label -replace '"','\"'; [void]$sb.AppendLine(("    {0}[""{1}""]" -f (Sid $id), $label)) }
  [void]$sb.AppendLine('  end')
}
foreach($triple in $linkSet){
  $parts = $triple -split '\|\|',3
  $s = Sid $parts[0]; $t = Sid $parts[1]; $rel = $parts[2]
  if($rel){ $rel = $rel -replace '"','\"'; [void]$sb.AppendLine("  $s -->|$rel| $t") } else { [void]$sb.AppendLine("  $s --> $t") }
}
$mermaid = $sb.ToString()

# Write proof
$proof = Join-Path $ren 'asset-graph.mmd'
Set-Content -Encoding UTF8 -Path $proof -Value $mermaid

# Rebuild DIAGRAMS.md (two closed fences)
$body = @"
# DIAGRAMS

_JSON is canonical; blocks below are generated from `docs/diagrams/examples/*.json`._

## Mermaid
```mermaid
$mermaid
// CI will generate D2 from the same JSON sources in a later step.
"@
Set-Content -Encoding UTF8 -Path $md -Value $body
