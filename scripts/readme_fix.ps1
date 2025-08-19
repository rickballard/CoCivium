# scripts/readme_fix.ps1
Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'

function RepoRoot { try { git rev-parse --show-toplevel } catch { "$HOME\Documents\GitHub\CoCivium" } }

$root   = RepoRoot
$readme = Join-Path $root 'README.md'
if (!(Test-Path $readme)) { Write-Error "README.md not found: $readme"; exit 1 }
$orig = Get-Content -LiteralPath $readme -Raw
$ver  = Get-Date -Format 'yyyyMMddHHmmss'

# Normalize EOL first so regexes can use \n reliably
$canon = ($orig -replace "`r`n","`n" -replace "`r","`n")

# 0) Canonicalize ALL acrostic icon src
$canon = [regex]::Replace(
  $canon,
  'src="\./assets/icons/(?<name>life|feels|broken|until|governments|coevolve|solutions|for-you)(?:-line)?[^"]*"',
  { param($m) ('src="./assets/icons/{0}-line.svg?v={1}"' -f $m.Groups['name'].Value, $ver) }
)

# 1) Decorative alt, spacing before bold label
$canon = [regex]::Replace($canon,'(<img\s+[^>]*src="\./assets/icons/[^"]+")([^>]*?)\s+alt="[^"]*"','$1$2')
$canon = [regex]::Replace($canon,'(<img\s+[^>]*src="\./assets/icons/[^"]+")(?![^>]*\salt=)([^>]*>)','$1 alt=""$2')
$canon = $canon -replace '\s*/>\s*&nbsp;\s+\*\*',' />&nbsp;&nbsp; **'

# 2) Remove stray '**' after labels
$canon = [regex]::Replace($canon,'(?m)(?<=\*\*[A-Za-z][A-Za-z \-]+:\*\*)\s*\*\*\s+',' ')

# 3) Remove any later "## Why / Who / How" section (header + body)
$canon = [regex]::Replace($canon,'(?ms)^\s*##\s*Why\s*/\s*Who\s*/\s*How\s*\n.*?(?=^\s*##\s+|\Z)','')

# 4) Rebuild ONE left-aligned W/W/H block directly under the H2
$lines = $canon -split "`n", 0
$h = -1; for($i=0;$i -lt $lines.Length;$i++){ if($lines[$i] -match '^\s*##\s+We The People, Empowered\.\s*$'){ $h=$i; break } }
if ($h -ge 0) {
  # drop any W/W/H lines anywhere
  $lines = $lines | Where-Object { $_ -notmatch '^\s*<img\s+[^>]*\./assets/icons/(why|who|how)-line\.svg' -and $_ -notmatch '^\s*\*\*(Why|Who|How):\*\*' }
  # first acrostic line after header
  $first = (1..($lines.Length-1) | ForEach-Object {
    if ($lines[$_] -match '^\s*<img\s+[^>]*\./assets/icons/(life|feels|broken|until|governments|coevolve|solutions|for-you)-line\.svg') { $_ }
  } | Select-Object -First 1)

  if ($first) {
    $wwh = @(
      ''
      "<img src=""./assets/icons/why-line.svg?v=$ver"" alt="""" width=""20"" height=""20"" />&nbsp;&nbsp; **Why:** Democracy needs to be rescued. Digital life is faster than law. Guardrails<<link>> must scale with agency."
      "<img src=""./assets/icons/who-line.svg?v=$ver"" alt="""" width=""20"" height=""20"" />&nbsp;&nbsp; **Who:** Humans and AIs who accept consent-first rules. Temporary stewards/founders, federated ASAP."
      "<img src=""./assets/icons/how-line.svg?v=$ver"" alt="""" width=""20"" height=""20"" />&nbsp;&nbsp; **How:** CoConstitution, process specs, and adapters that embed dignity into civic tools."
      ''
    )
    $prefix = $lines[0..$h]
    $suffix = $lines[$first..($lines.Length-1)]
    $lines  = @($prefix + $wwh + $suffix)
  }
}

# 5) Uppercase **COEVOLVE:** (label text only)
$lines = $lines | ForEach-Object { $_ -replace '\*\*CoEvolve:\*\*','**COEVOLVE:**' }

# 6) De-dup acrostic lines (keep first of each label)
$seen = @{}; $out = New-Object System.Collections.Generic.List[string]
foreach ($ln in $lines) {
  $m = [regex]::Match($ln,'^\s*<img[^>]*>\s*&nbsp;&nbsp;\s+\*\*([A-Za-z][A-Za-z \-]+):\*\*')
  if ($m.Success) {
    $label = $m.Groups[1].Value.ToUpperInvariant()
    if ($seen[$label]) { continue } else { $seen[$label] = $true }
  }
  $null = $out.Add($ln)
}

# 7) Save (LF; UTF-8 no BOM)
$new = (($out -join "`n") -replace "`r`n","`n" -replace "`r","`n").TrimEnd("`n") + "`n"
if ($new -ne $orig) {
  [IO.File]::WriteAllText($readme, $new, [Text.UTF8Encoding]::new($false))
  Write-Host "README normalized & fixed." -ForegroundColor Green
} else {
  Write-Host "README already clean; no changes." -ForegroundColor DarkGreen
}
