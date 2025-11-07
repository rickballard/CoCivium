param(
  [Parameter(Mandatory=$true)][string]$InputPath,
  [Parameter(Mandatory=$true)][string]$OutputPath
)
$ErrorActionPreference='Stop'
if(-not (Test-Path $InputPath)){ throw "Missing $InputPath" }
$raw = Get-Content $InputPath -Raw | ConvertFrom-Json

# Normalize to array of one or many
if($raw -isnot [System.Collections.IEnumerable]){ $items = @($raw) } else { $items = @($raw) }

$cols = @('pr','commenters','neg_hits','pos_hits','divergence')
$header = ($cols -join ' | ')
$sep    = (($cols | ForEach-Object { '---' }) -join ' | ')

$rows = foreach($it in $items){
  $vals = foreach($c in $cols){
    $v = $it.$c
    if($null -eq $v){ '' } else { $v.ToString() }
  }
  ($vals -join ' | ')
}

$md = @()
$md += "### PR Tension Summary"
$md += ""
$md += "$header"
$md += "$sep"
$md += $rows
$md += ""
$md -join "`n" | Set-Content -Encoding utf8NoBOM $OutputPath
Write-Host "Wrote $OutputPath"
