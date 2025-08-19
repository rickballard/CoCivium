Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'
$repo = "$HOME\Documents\GitHub\CoCivium"
$P    = Join-Path $repo 'README.md'
$t    = Get-Content -LiteralPath $P -Raw
$ver  = Get-Date -Format "yyyyMMddHHmmss"

# 0) Scrub any accidental console/prompt lines (from bad pastes)
$t = [regex]::Replace($t,'(?m)^(?:>\s*)+.*$','')
$t = [regex]::Replace($t,'(?m)^PS [^\r\n>]+>.*$','')

# 1) Icon hygiene: force -line.svg, single ?v=, decorative alt, spacing
$t = [regex]::Replace($t,'(src="\./assets/icons/(life|feels|broken|until|governments|coevolve|solutions|for-you))(?:-line)?(\.svg)(?:\?v=\d+)?','$1-line$3')
$t = [regex]::Replace($t,'(?<pre>src="\./assets/icons/[^"?]+\.svg)(?:\?v=\d+)?',{ param($m) $m.Groups["pre"].Value + "?v=$ver" })
$t = [regex]::Replace($t,'(<img\s+[^>]*src="\./assets/icons/[^"]+")([^>]*?)\s+alt="[^"]*"','$1$2')
$t = [regex]::Replace($t,'(<img\s+[^>]*src="\./assets/icons/[^"]+")(?![^>]*\salt=)([^>]*>)','$1 alt=""$2')
$t = $t -replace '\s*/>\s*&nbsp;\s+\*\*',' />&nbsp;&nbsp; **'

# 2) Remove any later "## Why / Who / How" section entirely
$t = [regex]::Replace($t,'(?ms)^\s*##\s*Why\s*/\s*Who\s*/\s*How\s*[\r\n]+.*?(?=^\s*##\s+|\z)','')

# 3) Construct canonical WWH block (left-aligned) + visible separator
$wwh = @"
<!-- WWH:BEGIN -->
<img src="./assets/icons/why-line.svg?v=$ver" alt="" width="20" height="20" />&nbsp;&nbsp; **Why:** Democracy needs to be rescued. Digital life is faster than law. Guardrails<<link>> must scale with agency.
<img src="./assets/icons/who-line.svg?v=$ver" alt="" width="20" height="20" />&nbsp;&nbsp; **Who:** Humans and AIs who accept consent-first rules. Temporary stewards/founders, federated ASAP.
<img src="./assets/icons/how-line.svg?v=$ver" alt="" width="20" height="20" />&nbsp;&nbsp; **How:** CoConstitution, process specs, and adapters that embed dignity into civic tools.
<!-- WWH:END -->
---
"@

# 4) Place exactly once under "## We The People, Empowered." and separate from acrostics
$lines = $t -split "`n",0
$h = -1; for($i=0;$i -lt $lines.Length;$i++){ if($lines[$i] -match '^\s*##\s+We The People, Empowered\.\s*$'){ $h=$i; break } }
if ($h -ge 0) {
  # strip any existing WWH markers/lines and any immediate HR that might follow
  $lines = $lines | Where-Object { $_ -notmatch '^\s*<!--\s*WWH:(BEGIN|END)\s*-->\s*$' -and $_ -notmatch '^\s*<img\s+[^>]*\./assets/icons/(why|who|how)-line\.svg' -and $_ -notmatch '^\s*\*\*(Why|Who|How):\*\*' -and $_ -notmatch '^\s*---\s*$' }
  $prefix = $lines[0..$h]
  $suffix = if ($h+1 -lt $lines.Length) { $lines[($h+1)..($lines.Length-1)] } else { @() }
  $t = ($prefix + '' + $wwh.TrimEnd() + '' + $suffix) -join "`n"
}

# 5) Labels: uppercase COEVOLVE, remove stray "**" after label colons, dedupe acrostics
$t = [regex]::Replace($t,'\*\*CoEvolve:\*\*','**COEVOLVE:**','IgnoreCase')
$t = [regex]::Replace($t,'(?m)(?<=\*\*[A-Za-z][A-Za-z \-]+:\*\*)\s*\*\*\s+',' ')
$seen = @{}; $out = New-Object System.Collections.Generic.List[string]
foreach($ln in ($t -split "`n",0)){
  $m = [regex]::Match($ln,'^\s*<img[^>]*>\s*&nbsp;&nbsp;\s+\*\*([A-Za-z][A-Za-z \-]+):\*\*')
  if($m.Success){ $L=$m.Groups[1].Value.ToUpperInvariant(); if($seen[$L]){continue}else{$seen[$L]=$true} }
  $null = $out.Add($ln)
}
$t = ($out -join "`n")

# 6) Normalize & save
$t = ($t -replace "`r`n","`n" -replace "`r","`n").TrimEnd("`n") + "`n"
[IO.File]::WriteAllText($P,$t,[Text.UTF8Encoding]::new($false))
Write-Host "README normalized, single WWH + separator, icons tidy." -ForegroundColor Green
