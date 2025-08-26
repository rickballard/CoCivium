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
  $added = Get-Date $it.added
  $age   = (New-TimeSpan -Start $added -End (Get-Date)).Days
  ${dateBits} = if($age -le $ShowDateDays){ " ($($added.ToString('yyyy-MM-dd')))" } else { "" }
  $links = $it.links | ForEach-Object { "[{0}]({1})" -f $_.label, $_.href }
  $linksStr = [string]::Join(" • ", $links)
  "> :sparkles: **New**{0}: {1} → {2}" -f ${dateBits}, $it.title, $linksStr
}

$lines = $items | ForEach-Object { Render-Line $_ }
$blockText = "<!-- NEWLIST:BEGIN -->`n$([string]::Join("`n", $lines))`n<!-- NEWLIST:END -->"

# load README, strip any Git conflict markers anywhere
$readme = Get-Content -Raw -LiteralPath $Readme
$readme = [regex]::Replace($readme, '^(<<<<<<<.*|=======|>>>>>>>.*)\r?\n?', '',
  [System.Text.RegularExpressions.RegexOptions]::Multiline)

# insert/replace New block
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

# normalize to LF and write as UTF-8 (no BOM)
$readme = $readme -replace "`r`n","`n"
[System.IO.File]::WriteAllText((Resolve-Path $Readme), $readme, [System.Text.UTF8Encoding]::new($false))