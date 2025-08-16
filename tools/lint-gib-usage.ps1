$ErrorActionPreference='Stop'
$hits = (git grep -n "data-gib=" -- "site/**") 2>$null
$allowed = @("site/_layouts/scroll.html","site/scroll/index.md")

$viol = @()
foreach($h in $hits){
  $path,$rest = $h.Split(':',2)
  if($allowed -notcontains $path){ $viol += "outside-allowed: $h"; continue }

  $line = $rest.Substring($rest.IndexOf(':')+1)
  if($line -notmatch 'data-fallback="[^"]+"'){ $viol += "missing-fallback: $h" }
  if($line -match '<h[1-6][^>]*>.*data-gib='){ $viol += "in-heading: $h" }
}

if($viol.Count){
  Write-Error ("GIB rules violated:`n" + ($viol -join "`n"))
  exit 1
}
Write-Host "GIB usage OK (fallback present; not in headings; scope limited)."
