param(
  [string]$ManifestPath = "docs/meta/new.json",
  [string]$ReadmePath   = "README.md",
  [int]$MaxItems        = 3,
  [int]$ShowDateDays    = 7
)
if(!(Test-Path $ManifestPath)){ throw "Missing manifest: $ManifestPath" }
$items = Get-Content -Raw $ManifestPath | ConvertFrom-Json |
         Sort-Object { Get-Date $_.added } -Descending |
         Select-Object -First $MaxItems
function Render-Line($it){
  $added = Get-Date $it.added
  $age   = (New-TimeSpan -Start $added -End (Get-Date)).Days
  ${dateBits} = if($age -le $ShowDateDays){ " ($($added.ToString('yyyy-MM-dd')))" } else { "" }
  $links = $it.links | ForEach-Object { "[{0}]({1})" -f $_.label, $_.href }
  "> :sparkles: **New**{0}: {1} → {2}" -f ${dateBits}, $it.title, ($links -join " • ")
}
$lines = $items | ForEach-Object { Render-Line $_ }
$block = "<!-- NEWLIST:BEGIN -->`n$([string]::Join("`n",$lines))`n<!-- NEWLIST:END -->"

$content = Get-Content -Raw -LiteralPath $ReadmePath
# strip conflict markers
$content = [regex]::Replace($content, '^(<<<<<<<.*|=======|>>>>>>>.*)\r?\n?', '',
  [System.Text.RegularExpressions.RegexOptions]::Multiline)

# replace/insert block
if($content -match '<!-- NEWLIST:BEGIN -->.*?<!-- NEWLIST:END -->'){
  $content = [regex]::Replace($content,'<!-- NEWLIST:BEGIN -->.*?<!-- NEWLIST:END -->',
    { param($m) $block }, [System.Text.RegularExpressions.RegexOptions]::Singleline)
}else{
  if($content -match '^\# .*$'){
    $content = [regex]::Replace($content,'(^\# .*$\r?\n?)',
      { param($m) $m.Value + "`n" + $block + "`n`n" },
      [System.Text.RegularExpressions.RegexOptions]::Multiline)
  }else{ $content = $block + "`n`n" + $content }
}

# collapse accidental nested blockquotes in the whole doc, but only where :sparkles: starts the text
$content = [regex]::Replace($content, '^(>+)\s*(:sparkles:)', '> $2',
  [System.Text.RegularExpressions.RegexOptions]::Multiline)

# also remove legacy hand-written “> **New:** …” outside our block
$parts = [regex]::Split($content, '(<!-- NEWLIST:BEGIN -->.*?<!-- NEWLIST:END -->)',
  [System.Text.RegularExpressions.RegexOptions]::Singleline)
if($parts.Count -eq 3){
  $before,$blockKept,$after = $parts
  $clean = {
    param($txt)
    ($txt -split "`n" | Where-Object { $_ -notmatch '^\s*>\s*\*\*New:\*\*' }) -join "`n"
  }
  $content = (& $clean $before) + $blockKept + (& $clean $after)
}

# write
$content = $content -replace "`r`n","`n"
[System.IO.File]::WriteAllText((Resolve-Path $ReadmePath), $content, [System.Text.UTF8Encoding]::new($false))