Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'
$repo = "$HOME\Documents\GitHub\CoCivium"
$P    = Join-Path $repo 'README.md'
$t    = Get-Content -LiteralPath $P -Raw

# --- 0) Remove any pasted console prompts or chevrons ---
$t = [regex]::Replace($t,'(?m)^PS [^\r\n>]+>.*$','')
$t = [regex]::Replace($t,'(?m)^(?:>\s*)+.*$','')

# --- 1) Mojibake repair (choose best of original/cp1252/latin1) ---
# build suspicious bytes without literal non-ASCII
$tok = @([char]0x00C3,[char]0x00C2,[char]0x00E2) | ForEach-Object { [string]$_ }
function Score([string]$s){ $n=0; foreach($ch in $tok){ $n += ([regex]::Matches($s,[regex]::Escape($ch))).Count }; return $n }
$origScore = Score $t
$cand = @(
  @{name='original'; text=$t},
  @{name='cp1252' ; text=[Text.Encoding]::UTF8.GetString([Text.Encoding]::GetEncoding(1252).GetBytes($t))},
  @{name='latin1' ; text=[Text.Encoding]::UTF8.GetString([Text.Encoding]::GetEncoding(28591).GetBytes($t))}
) | ForEach-Object { $_.score = (Score $_.text); $_ } | Sort-Object score, name
$best = $cand[0]
if ($best.name -ne 'original' -and $best.score -lt $origScore) { $t = $best.text }

# --- 2) Ensure a single '---' separator after W/W/H and add "Fix The World." header before acrostics ---
# collapse doubled '---'
$t = [regex]::Replace($t,'(?m)^\s*---\s*(\r?\n\s*)+---\s*',"`n---`n")

$lines = $t -split "`r?`n",0

# find first WHY/WHO/HOW lines and first acrostic line via a single pass
$whyIdx=-1; $whoIdx=-1; $howIdx=-1; $acroIdx=-1
for($i=0; $i -lt $lines.Length; $i++){
  if($whyIdx -lt 0 -and $lines[$i] -match '^\s*<img\s+[^>]*why-line\.svg'){ $whyIdx=$i }
  if($whoIdx -lt 0 -and $lines[$i] -match '^\s*<img\s+[^>]*who-line\.svg'){ $whoIdx=$i }
  if($howIdx -lt 0 -and $lines[$i] -match '^\s*<img\s+[^>]*how-line\.svg'){ $howIdx=$i }
  if($acroIdx -lt 0 -and $lines[$i] -match '^\s*<img\s+[^>]*\./assets/icons/(life|feels|broken|until|governments|coevolve|solutions|for-you)-line\.svg'){ $acroIdx=$i }
}

# after HOW, ensure exactly one '---'
if ($howIdx -ge 0) {
  $k = $howIdx
  while ($k+1 -lt $lines.Length -and $lines[$k+1] -match '^\s*(?:<!--\s*WWH:END\s*-->)?\s*$') { $k++ }
  if ($k+1 -lt $lines.Length) {
    if ($lines[$k+1] -match '^\s*---\s*$') {
      $lines[$k+1] = '---'
    } else {
      $lines = @($lines[0..$k]) + @('---') + @($lines[($k+1)..($lines.Length-1)])
    }
  } else {
    $lines = @($lines[0..$k]) + @('---')
  }
}

# insert "## Fix The World." just before first acrostic, if not already present
if ($acroIdx -ge 0) {
  $hasFix = $false
  foreach($ln in $lines){ if($ln -match '^\s*##\s+Fix The World\.\s*$'){ $hasFix = $true; break } }
  if (-not $hasFix) {
    $ins = [Math]::Max(0, $acroIdx - 1)
    $lines = @($lines[0..$ins]) + @('','## Fix The World.','') + @($lines[($ins+1)..($lines.Length-1)])
  }
}

$t = ($lines -join "`n")

# --- 3) Normalize and save as UTF-8 (no BOM), LF EOL ---
$t = ($t -replace "`r`n","`n" -replace "`r","`n").TrimEnd("`n") + "`n"
[IO.File]::WriteAllText($P,$t,[Text.UTF8Encoding]::new($false))

Write-Host "README repaired and normalized."
