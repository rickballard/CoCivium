param([Parameter(Mandatory=$true)][string]$RepoPath,[Parameter(Mandatory=$true)][string]$OutPath)
$ErrorActionPreference='Stop'; Set-StrictMode -Version Latest
function Read-Trailer($p){
  if($p -match '\.ya?ml$'){
    if(Get-Command ConvertFrom-Yaml -ErrorAction SilentlyContinue){
      return (Get-Content -Raw -Path $p | ConvertFrom-Yaml | ConvertTo-Json -Depth 20 | ConvertFrom-Json)
    } else { return $null }
  } else { return (Get-Content -Raw -Path $p | ConvertFrom-Json) }
}
$files = Get-ChildItem -Path $RepoPath -Recurse -File -Include *.cotrail.json,*.cotrail.yaml,*.cotrail.yml
$nodes = @(); $edges = @()
foreach($f in $files){
  $o = Read-Trailer $f.FullName; if($null -eq $o){ continue }
  $id = if($o.id){ $o.id } else { $f.BaseName }; $title = if($o.title){ $o.title } else { $f.BaseName }
  $safe = ($id -replace '[^A-Za-z0-9_]','_'); $tier = $o.fitness.readiness_tier
  $nodes += "  $safe[\"$title`n($tier) \"]"
  if($o.synergy_with){ foreach($s in $o.synergy_with){ $sid = ($s -replace '[^A-Za-z0-9_]','_'); $edges += "  $safe --> $sid" } }
}
$md = @"
# CoCloud Map

```mermaid
graph LR
{NODES}
{EDGES}
"@
$md = $md.Replace('{NODES}', ($nodes | Sort-Object -Unique | Out-String))
$md = $md.Replace('{EDGES}', ($edges | Sort-Object -Unique | Out-String))
New-Item -ItemType Directory -Force -Path (Split-Path -Parent $OutPath) *> $null
Set-Content -Path $OutPath -Value $md -Encoding UTF8
Write-Host "Wrote map to $OutPath"
