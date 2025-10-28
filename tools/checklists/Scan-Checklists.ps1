$ErrorActionPreference="Stop"
$R=(Resolve-Path "$PSScriptRoot\..\..").Path
$dir=Join-Path $R "docs\checklists"
$outJson=Join-Path $dir "INDEX.json"
$outMd=Join-Path $dir "MEGASCROLL.md"
$files=Get-ChildItem -Path $dir -Filter *.md -File
$items=@()
foreach($f in $files){
  $t=Get-Content $f.FullName -Raw
  $p=[regex]::Match($t,"^Priority:\s*(?<p>P[123])",([System.Text.RegularExpressions.RegexOptions]::Multiline))
  $owner=[regex]::Match($t,"Owner:\s*(?<o>.+?)\s",([System.Text.RegularExpressions.RegexOptions]::Multiline))
  $title=($t -split "`n")[0].TrimStart("# ").Trim()
  $open=([regex]::Matches($t,"- \[ \]")).Count
  $done=([regex]::Matches($t,"- \[x\]")).Count
  $items+=[pscustomobject]@{
    file=$f.Name; path=$f.FullName; title=$title; priority=$p.Groups["p"].Value; owner=$owner.Groups["o"].Value; open=$open; done=$done
  }
}
$items | ConvertTo-Json -Depth 5 | Set-Content -Encoding utf8 $outJson
$md=@("# Intent Checklists — Megascroll","","_Auto-generated from docs/checklists/*.md_","")
foreach($it in ($items | Sort-Object priority,title)){
  $rel=$it.path.Replace($R+[IO.Path]::DirectorySeparatorChar,"")
  $md+=("### {0}  ({1})" -f $it.title,$it.priority)
  $md+=("*File:* {0}  —  *Owner:* {1}  —  *Progress:* {2}/{3} done" -f $rel,$it.owner,$it.done,($it.open+$it.done))
  $md+=("")
}
$md | Set-Content -Encoding utf8 $outMd
Write-Host "Wrote:" -ForegroundColor Cyan; Write-Host "  $outJson" -ForegroundColor Yellow; Write-Host "  $outMd" -ForegroundColor Yellow
