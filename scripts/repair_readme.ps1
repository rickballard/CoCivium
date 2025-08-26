Set-StrictMode -Version Latest; $ErrorActionPreference="Stop"
$P = "$HOME\Documents\GitHub\CoCivium\README.md"

# 0) Backup
$stamp = (Get-Date).ToString('yyyyMMdd-HHmmss')
$bak = "$P.bak.$stamp"
Copy-Item -LiteralPath $P -Destination $bak -Force
Write-Host "[backup] $bak"

# 1) Read bytes and repair mojibake via cp1252?utf8 round-trip
$bytes = [IO.File]::ReadAllBytes($P)
$utf8s = [Text.UTF8Encoding]::new($false,$true)   # strict, no BOM
$broken = $utf8s.GetString($bytes)                # shows the ?/? mess
$bytes1252 = [Text.Encoding]::GetEncoding(1252).GetBytes($broken)
$t = $utf8s.GetString($bytes1252)                 # repaired text

# 2) Strip stray PS prompts only (keep real blockquotes)
$t = [regex]::Replace($t,'(?m)^PS [^\r\n>]*>.*$','')

# 3) Normalize common punctuation to ASCII (safer for diffs)
$map = @{
  0x00A0=' '; 0x2018="'"; 0x2019="'"; 0x201C='"'; 0x201D='"'; 0x2013='-'; 0x2014='-'; 0x2026='...'
}
foreach($k in $map.Keys){ $t = $t.Replace([string][char]$k, $map[$k]) }

# 4) Ensure exactly one '---' after HOW line, and ensure '## Fix The World.' header
$lines = $t -split "`r?`n",0
$how=-1; $firstAcro=-1
for($i=0;$i -lt $lines.Length;$i++){
  if($how -lt 0 -and $lines[$i] -match '^\s*<img\s+[^>]*how-line\.svg'){ $how=$i }
  if($firstAcro -lt 0 -and $lines[$i] -match '^\s*<img\s+[^>]*\./assets/icons/(life|feels|broken|until|governments|coevolve|solutions|for-you)-line\.svg'){ $firstAcro=$i }
}
if ($how -ge 0){
  $k=$how
  while ($k+1 -lt $lines.Length -and $lines[$k+1] -match '^\s*(?:<!--\s*WWH:END\s*-->)?\s*$'){ $k++ }
  if     ($k+1 -lt $lines.Length -and $lines[$k+1] -match '^\s*---\s*$'){ $lines[$k+1]='---' }
  elseif ($k+1 -lt $lines.Length) { $lines = @($lines[0..$k]) + @('---') + @($lines[($k+1)..($lines.Length-1)]) }
  else { $lines = @($lines[0..$k]) + @('---') }
}
if ($firstAcro -ge 0){
  $hasFix = $lines -match '^\s*##\s+Fix The World\.\s*$'
  if (-not $hasFix){
    $ins=[Math]::Max(0,$firstAcro-1)
    $lines = @($lines[0..$ins]) + @('','## Fix The World.','') + @($lines[($ins+1)..($lines.Length-1)])
  }
}
$t = ($lines -join "`n")

# 5) Specific punctuation fix: "insanity tsunami"**, ? "insanity tsunami",
$t = [regex]::Replace($t,'("insanity tsunami")\*\*,','$1,')

# 6) Final newline normalization & save UTF-8 (no BOM)
$t = ($t -replace "`r`n","`n" -replace "`r","`n").TrimEnd("`n") + "`n"
[IO.File]::WriteAllText($P,$t,[Text.UTF8Encoding]::new($false))

# 7) Health checks
function C($s){ ([regex]::Matches($t,$s)).Count }
$counts = [pscustomobject]@{
  A = C('?'); B = C('?'); ReplacementChar = C([string][char]0xFFFD)
}
Write-Host "[counts after repair] ?=$($counts.A)  ?=$($counts.B)  U+FFFD=$($counts.ReplacementChar)"

# Show a short preview and a tiny hex slice
$preview = $t.Substring(0,[Math]::Min(200,$t.Length))
Write-Host "`n[preview]"
Write-Output $preview

Write-Host "`n[hex first 96 bytes]"
$nb = [Text.UTF8Encoding]::new($false).GetBytes($t)
$take=[Math]::Min(96,$nb.Length)
$slice = New-Object byte[] $take
[Array]::Copy($nb,0,$slice,0,$take)
Format-Hex -InputObject $slice
