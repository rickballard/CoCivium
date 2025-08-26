Set-StrictMode -Version Latest; $ErrorActionPreference="Stop"
$P = "$HOME\Documents\GitHub\CoCivium\README.md"

# --- backup ---
$stamp = (Get-Date).ToString('yyyyMMdd-HHmmss'); $bak = "$P.bak.$stamp"
Copy-Item -LiteralPath $P -Destination $bak -Force; Write-Host "[backup] $bak"

# --- helpers ---
function CountTok($s){ @{
  A = ([regex]::Matches($s,'?')).Count
  B = ([regex]::Matches($s,'?')).Count
  R = ([regex]::Matches($s,[string][char]0xFFFD)).Count
} }
function Score($c){ $c.A + $c.B + ($c.R*10) }  # penalize U+FFFD heavily

$bytes = [IO.File]::ReadAllBytes($P)
$u8_strict = [Text.UTF8Encoding]::new($false,$true)
$u8_loose  = [Text.UTF8Encoding]::new($false,$false)

# the mojibake-as-unicode string
$broken = $u8_strict.GetString($bytes)

# Try round-trips; pick best by minimal (?+?) and U+FFFD
$cands = @()
foreach($encName in  @('windows-1252','iso-8859-1')){
  try{
    $enc = [Text.Encoding]::GetEncoding($encName)
    $rt  = $u8_loose.GetString($enc.GetBytes($broken))   # loose to avoid hard fail
    $cnt = CountTok $rt
    $cands += [pscustomobject]@{ Enc=$encName; Text=$rt; C=$cnt; Score=(Score $cnt) }
  } catch {}
}

if(-not $cands){ throw "No round-trip candidates produced text." }
$cands = $cands | Sort-Object Score, { $_.C.R }, { $_.C.A + $_.C.B }
$best  = $cands[0]
Write-Host "[round-trip] picked: $($best.Enc)  score=$($best.Score)  A=$($best.C.A) B=$($best.C.B) R=$($best.C.R)"
$t = $best.Text

# --- strip stray PS prompts (keep real blockquotes) ---
$t = [regex]::Replace($t,'(?m)^PS [^\r\n>]*>.*$','')

# --- normalize punctuation / spaces ---
$map = @{
  0x00A0=' '; 0x2018="'"; 0x2019="'"; 0x201C='"'; 0x201D='"'; 0x2013='-'; 0x2014='-'; 0x2026='...'
}
foreach($k in $map.Keys){ $t = $t.Replace([string][char]$k, $map[$k]) }

# --- ensure separator and header present ---
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

# --- specific punctuation fix ---
$t = [regex]::Replace($t,'("insanity tsunami")\*\*,','$1,')

# --- newline normalization & save (UTF-8, no BOM) ---
$t = ($t -replace "`r`n","`n" -replace "`r","`n").TrimEnd("`n") + "`n"
[IO.File]::WriteAllText($P,$t,[Text.UTF8Encoding]::new($false))

# --- health checks ---
$cnt2 = CountTok $t
Write-Host "[post-save counts] ?=$($cnt2.A)  ?=$($cnt2.B)  U+FFFD=$($cnt2.R)"

$preview = $t.Substring(0,[Math]::Min(220,$t.Length))
Write-Host "`n[preview]"; Write-Output $preview

Write-Host "`n[hex first 96 bytes]"
$nb = [Text.UTF8Encoding]::new($false).GetBytes($t)
$take=[Math]::Min(96,$nb.Length)
$slice = New-Object byte[] $take
[Array]::Copy($nb,0,$slice,0,$take)
Format-Hex -InputObject $slice
