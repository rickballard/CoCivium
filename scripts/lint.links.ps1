# scripts/lint.links.ps1  (warn-only)
$md = git ls-files *.md
$bad = @()
foreach($f in $md){
  $i=0
  foreach($line in Get-Content $f){
    $i++
    if($line -match '\]\(\.\./{2,}'){  # ../.. or deeper
      $bad += [pscustomobject]@{file=$f; line=$i; text=$line.Trim()}
    }
  }
}
if($bad.Count){
  Write-Host 'WARN: deep ../ chains found (consider permalink or restructure):'
  $bad | Format-Table -AutoSize
  exit 0
}
