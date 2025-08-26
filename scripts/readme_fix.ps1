Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'
$repo = "$HOME\Documents\GitHub\CoCivium"
$P    = Join-Path $repo 'README.md'
$t    = Get-Content -LiteralPath $P -Raw
$ver  = Get-Date -Format "yyyyMMddHHmmss"

# Scrub stray console/prompt lines
$t = [regex]::Replace($t,'(?m)^(?:>\s*)+.*$','')
$t = [regex]::Replace($t,'(?m)^PS [^\r\n>]+>.*$','')

# Icons: -line.svg, single ?v=, decorative alt, spacing
$t = [regex]::Replace($t,'(src="\./assets/icons/(life|feels|broken|until|governments|coevolve|solutions|for-you))(?:-line)?(\.svg)(?:\?v=\d+)?','$1-line$3')
$t = [regex]::Replace($t,'(?<pre>src="\./assets/icons/[^"?]+\.svg)(?:\?v=\d+)?',{ param($m) $m.Groups["pre"].Value + "?v=$ver" })
$t = [regex]::Replace($t,'(<img\s+[^>]*src="\./assets/icons/[^"]+")([^>]*?)\s+alt="[^"]*"','$1$2')
$t = [regex]::Replace($t,'(<img\s+[^>]*src="\./assets/icons/[^"]+")(?![^>]*\salt=)([^>]*>)','$1 alt=""$2')
$t = $t -replace '\s*/>\s*&nbsp;\s+\*\*',' />&nbsp;&nbsp; **'

# Remove any later "## Why / Who / How" section entirely
$t = [regex]::Replace($t,'(?ms)^\s*##\s*Why\s*/\s*Who\s*/\s*How\s*[\r\n]+.*?(?=^\s*##\s+|\z)','')

# Canonical WWH (left-aligned) with visible separator immediately after HOW
$wwh = "`n<!-- WWH:BEGIN -->`n" +
       "<img src=""./assets/icons/why-line.svg?v=$ver"" alt="""" width=""20"" height=""20"" />&nbsp;&nbsp; **Why:** Democracy needs to be rescued. Digital life is faster than law. Guardrails<<link>> must scale with agency.`n" +
       "<img src=""./assets/icons/who-line.svg?v=$ver"" alt="""" width=""20"" height=""20"" />&nbsp;&nbsp; **Who:** Humans and AIs who accept consent-first rules. Temporary stewards/founders, federated ASAP.`n" +
       "<img src=""./assets/icons/how-line.svg?v=$ver"" alt="""" width=""20"" height=""20"" />&nbsp;&nbsp; **How:** CoConstitution, process specs, and adapters that embed dignity into civic tools.`n" +
       "<!-- WWH:END -->`n---"

# Place directly under the H2
$lines = $t -split "`n",0
$h = -1; for($i=0;$i -lt $lines.Length;$i++){ if($lines[$i] -match '^\s*##\s+We The People, Empowered\.\s*$'){ $h=$i; break } }
if ($h -ge 0) {
  # strip any existing WWH markers/lines (do NOT strip global '---')
  $lines = $lines | Where-Object {
    $_ -notmatch '^\s*<!--\s*WWH:(BEGIN|END)\s*-->\s*$' -and
    $_ -notmatch '^\s*<img\s+[^>]*\./assets/icons/(why|who|how)-line\.svg' -and
    $_ -notmatch '^\s*\*\*(Why|Who|How):\*\*'
  }
  $prefix = $lines[0..$h]
  $suffix = if ($h+1 -lt $lines.Length) { $lines[($h+1)..($lines.Length-1)] } else { @() }
  $t = ($prefix + $wwh + $suffix) -join "`n"
}

# Labels: force **COEVOLVE:** (be robust to odd spaces/nonbreaking)
$t = [regex]::Replace($t,'\*\*c[^\S\r\n]*o[^\S\r\n]*evolve\s*:\s*\*\*','**COEVOLVE:**','IgnoreCase')

# Remove stray "**" after label colons; de-dupe acrostics (keep first)
$t = [regex]::Replace($t,'(?m)(?<=\*\*[A-Za-z][A-Za-z \-]+:\*\*)\s*\*\*\s+',' ')
$seen=@{}; $out=New-Object System.Collections.Generic.List[string]
foreach($ln in ($t -split "`n",0)){
  $m=[regex]::Match($ln,'^\s*<img[^>]*>\s*&nbsp;&nbsp;\s+\*\*([A-Za-z][A-Za-z \-]+):\*\*')
  if($m.Success){ $L=$m.Groups[1].Value.ToUpperInvariant(); if($seen[$L]){continue}else{$seen[$L]=$true} }
  $null=$out.Add($ln)
}
$t = ($out -join "`n")

# Normalize & save
$t = ($t -replace "`r`n","`n" -replace "`r","`n").TrimEnd("`n") + "`n"
[IO.File]::WriteAllText($P,$t,[Text.UTF8Encoding]::new($false))
Write-Host "README normalized ✅ (single WWH + separator; icons/labels tidy)" -ForegroundColor Green
