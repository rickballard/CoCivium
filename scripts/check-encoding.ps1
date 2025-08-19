param([string]$Path = "README.md")
$fffd = [string][char]0xFFFD
$txt = Get-Content -Raw $Path
if($txt -match 'Ã|Â' -or $txt.Contains($fffd)){
  Write-Host "✗ Encoding check failed: found mojibake tokens in $Path." -ForegroundColor Red
  exit 1
}
Write-Host "✓ Encoding looks good in $Path." -ForegroundColor Green
