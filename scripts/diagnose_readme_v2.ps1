Set-StrictMode -Version Latest; $ErrorActionPreference="Stop"
$rdme = "$HOME\Documents\GitHub\CoCivium\README.md"

Write-Host "=== Hex (first 160 bytes; PS5-friendly) ==="
$bytes = [IO.File]::ReadAllBytes($rdme)
$take = [Math]::Min(160,$bytes.Length)
$slice = New-Object byte[] $take
[Array]::Copy($bytes,0,$slice,0,$take)
Format-Hex -InputObject $slice

Write-Host "`n=== Strict UTF-8 decode check ==="
try {
  $utf8 = [Text.UTF8Encoding]::new($false,$true)
  $txt = $utf8.GetString($bytes)
  $first = $txt.Substring(0,[Math]::Min(200,$txt.Length))
  $cA = ([regex]::Matches($txt,'[??]')).Count
  $cF = ([regex]::Matches($txt,[char]0xFFFD)).Count
  Write-Host ("First 200 chars:`n{0}" -f $first)
  Write-Host ("Counts: ?/?={0}, U+FFFD={1}" -f $cA, $cF)
} catch { Write-Warning ("Strict UTF-8 decode failed: {0}" -f $_.Exception.Message) }

Write-Host "`n=== HEAD vs origin (first 160 bytes each) ==="
git fetch --quiet origin
cmd /c "git show --no-textconv HEAD:README.md > __head.tmp"
cmd /c "git show --no-textconv origin/main:README.md > __orig.tmp"
$hb=[IO.File]::ReadAllBytes('__head.tmp'); $ob=[IO.File]::ReadAllBytes('__orig.tmp')
$ht=[Math]::Min(160,$hb.Length); $ot=[Math]::Min(160,$ob.Length)
Write-Host "`n-- HEAD bytes --"; Format-Hex -InputObject $hb[0..($ht-1)]
Write-Host "`n-- origin bytes --"; Format-Hex -InputObject $ob[0..($ot-1)]

# Mojibake signal
try {
  $hTxt=[Text.UTF8Encoding]::new($false,$true).GetString($hb)
  $oTxt=[Text.UTF8Encoding]::new($false,$true).GetString($ob)
  $hcA=([regex]::Matches($hTxt,'[??]')).Count; $hcF=([regex]::Matches($hTxt,[char]0xFFFD)).Count
  $ocA=([regex]::Matches($oTxt,'[??]')).Count; $ocF=([regex]::Matches($oTxt,[char]0xFFFD)).Count
  Write-Host ("HEAD UTF-8 check: ?/?={0}, U+FFFD={1}" -f $hcA,$hcF)
  Write-Host ("origin UTF-8 check: ?/?={0}, U+FFFD={1}" -f $ocA,$ocF)
} catch {}
