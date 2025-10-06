Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"
$inkCmd = $null
try { $inkCmd = Get-Command inkscape -ErrorAction Stop } catch {}
if (-not $inkCmd) { try { $inkCmd = Get-Command inkscape.exe -ErrorAction Stop } catch {} }
$ink = $null
if ($inkCmd) {
  if ($inkCmd.PSObject.Properties['Path']) { $ink = $inkCmd.Path }
  elseif ($inkCmd.PSObject.Properties['Definition']) { $ink = $inkCmd.Definition }
}
if (-not $ink -or -not (Test-Path $ink)) { Write-Host "[CoRender] inkscape not found; skip."; exit 0 }
$svgs = git ls-files *.svg
foreach ($f in $svgs) {
  foreach ($size in 256,512,1200) {
    $png = [System.IO.Path]::ChangeExtension($f, $null) + "_$size.png"
    & $ink $f --export-type=png --export-filename=$png --export-width=$size --export-height=$size | Out-Null
    Write-Host "[CoRender] $f -> $png"
  }
}
