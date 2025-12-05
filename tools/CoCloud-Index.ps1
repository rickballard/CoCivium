param([Parameter(Mandatory=$true)][string]$RepoPath,[Parameter(Mandatory=$true)][string]$OutPath)
$ErrorActionPreference='Stop'; Set-StrictMode -Version Latest

# Best-effort local YAML (CI installs module separately)
try{
  if(-not (Get-Command ConvertFrom-Yaml -ErrorAction SilentlyContinue)){
    Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted -ErrorAction SilentlyContinue
    Install-Module powershell-yaml -Scope CurrentUser -Force -ErrorAction SilentlyContinue
  }
}catch{}

function Read-Trailer($p){
  if($p -match '\.ya?ml$'){
    if(Get-Command ConvertFrom-Yaml -ErrorAction SilentlyContinue){
      return (Get-Content -Raw -Path $p | ConvertFrom-Yaml | ConvertTo-Json -Depth 20 | ConvertFrom-Json)
    } else { return $null }
  } else {
    return (Get-Content -Raw -Path $p | ConvertFrom-Json)
  }
}

# Use wildcard on Path for -Include reliability
$files = Get-ChildItem -Path (Join-Path $RepoPath '*') -Recurse -File -Include '*.cotrail.json','*.cotrail.yaml','*.cotrail.yml'

$nodes=@(); $edges=@()
foreach($f in $files){
  $o = Read-Trailer $f.FullName; if($null -eq $o){ continue }
  $id    = if($o.id){ $o.id } else { $f.BaseName }
  $title = if($o.title){ $o.title } else { $f.BaseName }
  $tier  = if($o.fitness.readiness_tier){ $o.fitness.readiness_tier } else { 'n/a' }
  $safe  = ($id -replace '[^A-Za-z0-9_]','_')
  $label = ('{0}`n({1})' -f ($title -replace '"','\"'), $tier)
  $nodes += ('  {0}["{1}"]' -f $safe, $label)

  if($o.synergy_with){
    foreach($s in $o.synergy_with){
      if([string]::IsNullOrWhiteSpace($s)){ continue }
      $sid = ($s -replace '[^A-Za-z0-9_]','_')
      $edges += ('  {0} --> {1}' -f $safe, $sid)
    }
  }
}

$tmpl=@"
# CoCloud Map

```mermaid
graph LR
{NODES}
{EDGES}
"@

$nodesText = ($nodes | Sort-Object -Unique) -join "n" $edgesText = ($edges | Sort-Object -Unique) -join "n"
$body = $tmpl.Replace('{NODES}', $nodesText)
$body = $body.Replace('{EDGES}', $edgesText)

New-Item -ItemType Directory -Force -Path (Split-Path -Parent $OutPath) *> $null
Set-Content -Path $OutPath -Value $body -Encoding UTF8
Write-Host ("Wrote map to {0} with {1} nodes and {2} edges" -f $OutPath, $nodes.Count, $edges.Count)
