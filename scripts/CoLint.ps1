param([string]$Glob = '\.(md|mdx|txt|ps1|psm1|psd1|json|ya?ml|ts|js|css|html)$')
$ErrorActionPreference="Stop"
$files = (& git ls-files).Trim().Split([Environment]::NewLine) | Where-Object { $_ }
$re = [regex]::new("\u2014")
$bad = @()
foreach($f in $files){
  if($f -notmatch $Glob){ continue }
  try{ $t = Get-Content -LiteralPath $f -Raw -Encoding UTF8 }catch{ continue }
  if($re.IsMatch($t)){ $bad += $f }
}
if($bad.Count){
  Write-Error ("Emdashes found:" + [Environment]::NewLine + " - " + ($bad -join ([Environment]::NewLine + " - ")))
  exit 1
} else { "No emdashes found." }
