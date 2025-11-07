param([Parameter(Mandatory=$true)][string]$InputPath,[Parameter(Mandatory=$true)][string]$OutputPath)
$ErrorActionPreference="Stop"
if(-not (Test-Path $InputPath)){ throw "Missing $InputPath" }
$raw = Get-Content $InputPath -Raw | ConvertFrom-Json
if($raw -isnot [System.Collections.IEnumerable]){ $items=@($raw) } else { $items=@($raw) }
 = @('pr','commenters','neg_hits','pos_hits','divergence')
$header = ($cols -join " | ")
$sep    = (($cols | ForEach-Object { "---" }) -join " | ")
$rows = foreach($it in $items){ ($cols | ForEach-Object { $v = $it.$_; if($null -eq $v){""} else { $v.ToString() } }) -join " | " }
$md = @()
$md += "### PR Tension Summary"
$md += ""
$md += $header
$md += $sep
$md += $rows
$md += ""
($md -join "`n") | Set-Content -Encoding utf8NoBOM $OutputPath
Write-Host ("Wrote {0}" -f $OutputPath)
