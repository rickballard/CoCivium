param(
  [string]$RepoRoot = (Resolve-Path "$PSScriptRoot\..").Path
)
$ErrorActionPreference='Stop'
function Rel([string]$abs,[string]$root){ ($abs.Substring($root.Length+1) -replace '\\','/') }

$renderDir = Join-Path $RepoRoot 'docs\diagrams\render'
$failed = @()
Get-ChildItem $renderDir -Recurse -Filter *.mmd | ForEach-Object {
  $in = $_.FullName
  $outSvg = [IO.Path]::ChangeExtension($in, '.svg')
  Write-Host "mmdc → SVG: $($in.Substring($RepoRoot.Length+1))"
  $p = Start-Process -FilePath "npx" -ArgumentList @("mmdc","-i",$in,"-o",$outSvg,"--backgroundColor","transparent") -NoNewWindow -PassThru -Wait
  if($p.ExitCode -ne 0){ $failed += $in }
}
if($failed){ throw ("Mermaid export failed for {0} file(s)." -f $failed.Count) }