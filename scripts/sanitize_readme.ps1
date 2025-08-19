Set-StrictMode -Version Latest; $ErrorActionPreference="Stop"
$P = "$HOME\Documents\GitHub\CoCivium\README.md"
$t = Get-Content -LiteralPath $P -Raw

# 0) Strip stray prompts/chevrons
$t = [regex]::Replace($t,'(?m)^PS [^\r\n>]+>.*$','')
$t = [regex]::Replace($t,'(?m)^(?:>\s*)+.*$','')

# 1) Punctuation to ASCII (use string->string overloads)
$map = @{
  0x00A0=' '; 0x2018="'"; 0x2019="'"; 0x201C='"'; 0x201D='"'; 0x2013='-'; 0x2014='-'; 0x2026='...'
}
foreach($k in $map.Keys){ $t = $t.Replace([string][char]$k, $map[$k]) }

# 2) Ensure exactly one '---' after HOW and add 'Fix The World.' before acrostics if missing
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

# 3) Normalize newlines and save UTF-8 (no BOM)
$t = ($t -replace "`r`n","`n" -replace "`r","`n").TrimEnd("`n") + "`n"
[IO.File]::WriteAllText($P,$t,[Text.UTF8Encoding]::new($false))
Write-Host "[OK] README sanitized."
