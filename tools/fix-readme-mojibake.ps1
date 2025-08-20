Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'
chcp 65001 | Out-Null
$OutputEncoding = [Console]::OutputEncoding = [Text.UTF8Encoding]::new($false)

$repo = Split-Path -Parent $PSScriptRoot
$P = Join-Path $repo 'README.md'
Copy-Item $P "$P.bak.$(Get-Date -Format 'yyyyMMdd-HHmmss')" -Force

$txt = (Get-Content -Raw $P).Replace([char]0xA0,' ') -replace "`r`n","`n" -replace "`r","`n"

$pairs = @(
  @('ΓÇ£', [string][char]0x201C), @('ΓÇ¥', [string][char]0x201D),
  @('ΓÇÖ', [string][char]0x2019), @('ΓÇª', [string][char]0x2026),
  @('ΓÇ–', [string][char]0x2013), @('ΓÇô', [string][char]0x2013),
  @('ΓÇ—', [string][char]0x2014), @('ΓÇö', [string][char]0x2014),
  @('ΓåÆ', [string][char]0x2192)
)
foreach($p in $pairs){ $txt = $txt.Replace($p[0], $p[1]) }
$txt = $txt.Replace('ΓÇ— ',([string][char]0x2014+' ')).Replace('ΓÇö ',([string][char]0x2014+' ')).Replace('ΓÇ– ',([string][char]0x2013+' ')).Replace('ΓÇô ',([string][char]0x2013+' '))

$txt = [regex]::Replace($txt,'(?m)^\s*>+\s*(?=Terms:)','')

[IO.File]::WriteAllText($P,$txt,[Text.UTF8Encoding]::new($false))

Write-Host 'Verify (no hits expected below):'
Select-String -Path $P -Pattern @('ΓÇ','ΓåÆ') -SimpleMatch
Select-String -Path $P -Pattern '^(Terms:)' | % Line