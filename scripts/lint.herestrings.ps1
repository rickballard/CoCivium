param()
$files = @(git ls-files *.ps1,*.psm1 2>$null)
$bad = @()
foreach($f in $files){
  $t = Get-Content -Raw $f
  $s1 = ([regex]::Matches($t,"@'")).Count; $e1 = ([regex]::Matches($t,"'@")).Count
  $s2 = ([regex]::Matches($t,'@"')).Count; $e2 = ([regex]::Matches($t,'"@')).Count
  if($s1 -ne $e1 -or $s2 -ne $e2){ $bad += $f }
}
if($bad.Count){ Write-Host ("WARN: Unbalanced here-strings in: " + ($bad -join ", ")) }
exit 0
