Set-StrictMode -Version Latest; $ErrorActionPreference="Stop"
$rdme = "$HOME\Documents\GitHub\CoCivium\README.md"

Write-Host "=== PowerShell / Console ==="
Write-Host ("PSEdition: {0}" -f $PSVersionTable.PSEdition)
Write-Host ("PSVersion: {0}" -f $PSVersionTable.PSVersion)
try { Write-Host ("OutputEncoding: {0}" -f [Console]::OutputEncoding) } catch {}
try { $cp = chcp | Out-String; $cp = ($cp -replace '\s+',' ').Trim(); Write-Host ("CHCP: {0}" -f $cp) } catch {}

Write-Host "`n=== Git / Branch ==="
$branch = (git rev-parse --abbrev-ref HEAD) 2>$null
Write-Host ("HEAD branch: {0}" -f $branch)
git status --porcelain
git log -n 1 --pretty=fuller -- README.md

Write-Host "`n=== README: BOM & first bytes (working tree) ==="
$bytes = [IO.File]::ReadAllBytes($rdme)
if ($bytes.Length -ge 3) {
  $bom = ($bytes[0..2] | ForEach-Object { $_.ToString('X2') }) -join ' '
} else { $bom = '(short file)' }
Write-Host ("BOM(first 3): {0}" -f $bom)
Format-Hex -Path $rdme -Count 160

Write-Host "`n=== README decoded as UTF-8 (first 200 chars) ==="
try {
  $utf8 = [Text.UTF8Encoding]::new($false,$true) # no BOM, strict
  $txt  = $utf8.GetString($bytes)
  $first = $txt.Substring(0,[Math]::Min(200,$txt.Length))
  Write-Output $first
  $cAtilde = ([regex]::Matches($txt,'[??]')).Count
  $cFFFD   = ([regex]::Matches($txt,[char]0xFFFD)).Count
  Write-Host ("Counts in UTF-8 decode: ?/?={0}, U+FFFD={1}" -f $cAtilde, $cFFFD)
} catch {
  Write-Warning ("Strict UTF-8 decode failed: {0}" -f $_.Exception.Message)
}

Write-Host "`n=== Compare bytes: HEAD vs origin ==="
git fetch --quiet origin
$remoteHead = (git symbolic-ref --short refs/remotes/origin/HEAD) 2>$null
if (-not $remoteHead) { $remoteHead = 'origin/main' }
Write-Host ("origin HEAD ref: {0}" -f $remoteHead)

# Dump exact bytes from HEAD and origin to temp files (no transcoding)
cmd /c "git show --no-textconv HEAD:README.md > __head_readme.tmp"
cmd /c "git show --no-textconv %REMOTE_HEAD%:README.md > __origin_readme.tmp" ^
  2>nul
if (-not (Test-Path '__origin_readme.tmp')) {
  # Fallback to origin/main
  cmd /c "git show --no-textconv origin/main:README.md > __origin_readme.tmp"
}

Write-Host "`n--- HEAD:README.md (first 160 bytes) ---"
Format-Hex -Path __head_readme.tmp -Count 160
Write-Host "`n--- origin:README.md (first 160 bytes) ---"
Format-Hex -Path __origin_readme.tmp -Count 160

# Quick mojibake signal from HEAD decoded as UTF-8 strictly
$headBytes = [IO.File]::ReadAllBytes('__head_readme.tmp')
try {
  $headTxt = [Text.UTF8Encoding]::new($false,$true).GetString($headBytes)
  $hcA = ([regex]::Matches($headTxt,'[??]')).Count
  $hcF = ([regex]::Matches($headTxt,[char]0xFFFD)).Count
  Write-Host ("HEAD UTF-8 check: ?/?={0}, U+FFFD={1}" -f $hcA, $hcF)
} catch { Write-Warning "HEAD strict UTF-8 decode failed." }

# Same for origin
$orgBytes = [IO.File]::ReadAllBytes('__origin_readme.tmp')
try {
  $orgTxt = [Text.UTF8Encoding]::new($false,$true).GetString($orgBytes)
  $ocA = ([regex]::Matches($orgTxt,'[??]')).Count
  $ocF = ([regex]::Matches($orgTxt,[char]0xFFFD)).Count
  Write-Host ("origin UTF-8 check: ?/?={0}, U+FFFD={1}" -f $ocA, $ocF)
} catch { Write-Warning "origin strict UTF-8 decode failed." }

Write-Host "`n=== Done. Paste everything above. ==="
