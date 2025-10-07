Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
$ink = (Get-Command inkscape.exe -ErrorAction SilentlyContinue).Source
if (-not $ink) { Write-Host "[CoRender] inkscape not found; skip."; exit 0 }
$svgs = git ls-files *.svg
foreach ($f in $svgs) {
  foreach ($size in 256,512,1200) {
    $png = [System.IO.Path]::ChangeExtension($f, $null) + "_$size.png"
    & $ink $f --export-type=png --export-filename=$png --export-width=$size --export-height=$size | Out-Null
    Write-Host "[CoRender] $f -> $png"
  }
}
