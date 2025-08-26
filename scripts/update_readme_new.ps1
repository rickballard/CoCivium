param(
  [string]$Manifest = "docs/meta/new.json",
  [string]$Readme   = "README.md",
  [int]$MaxItems    = 3,
  [int]$ShowDateDays = 7
)

if(!(Test-Path $Manifest)){ throw "Missing manifest: $Manifest" }
$items = Get-Content -Raw $Manifest | ConvertFrom-Json
$items = $items | Sort-Object { Get-Date $_.added } -Descending | Select-Object -First $MaxItems

function Render-Line($it){
  $added   = Get-Date $it.added
  $age     = (New-TimeSpan -Start $added -End (Get-Date)).Days
  $dateBits = if($age -le $ShowDateDays){ " ($($added.ToString('yyyy-MM-dd')))" } else { "" }
  $links = @()
  foreach($l in $it.links){ $links += "[{0}]({1})" -f $l.label, $l.href }
  $linksStr = $links -join " • "
  return ("> :sparkles: **New**{0}: {1} → {2}" -f ${dateBits}, $it.title, $linksStr)
}

$lines = @()
foreach($it in $items){ $lines += (Render-Line $it) }

$block = @()
$block += "<!-- NEWLIST:BEGIN -->"
$block += ($lines -join "`n")
$block += "<!-- NEWLIST:END -->"
$blockText = ($block -join "`n")

$readme = Get-Content -Raw -LiteralPath $Readme

if($readme -match '<!-- NEWLIST:BEGIN -->.*?<!-- NEWLIST:END -->'){
  $readme = [regex]::Replace(
    $readme,
    '<!-- NEWLIST:BEGIN -->.*?<!-- NEWLIST:END -->',
    { param($m) $blockText },
    [System.Text.RegularExpressions.RegexOptions]::Singleline
  )
}else{
  if($readme -match '^\# .*$'){
    $readme = [regex]::Replace(
      $readme,
      '(^\# .*$\r?\n?)',
      { param($m) $m.Value + "`n" + $blockText + "`n`n" },
      [System.Text.RegularExpressions.RegexOptions]::Multiline
    )
  }else{
    $readme = $blockText + "`n`n" + $readme
  }
}

$readme = $readme -replace "`r`n","`n"
Set-Content -LiteralPath $Readme -Value $readme -Encoding UTF8 -NoNewline