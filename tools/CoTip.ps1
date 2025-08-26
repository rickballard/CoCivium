function Add-CoTip {
  param([Parameter(Mandatory)][string]$Id,
        [Parameter(Mandatory)][string]$Title,
        [Parameter(Mandatory)][string]$Body)
  $root   = "$HOME\Documents\GitHub\CoCache"
  $cotips = Join-Path $root 'docs\CoTips'
  New-Item -ItemType Directory -Force -Path $cotips | Out-Null
  $ts = Get-Date -Format 'yyyy-MM-dd HH:mm:ssK'
  $slug = ($Id -replace '[^A-Za-z0-9_-]','_')
  $path = Join-Path $cotips ("{0}.md" -f $slug)
  $md = @"
# $Title
**ID:** $Id  
**When:** $ts  

$Body
"@
  Set-Content -Path $path -Value $md -Encoding UTF8
  $index = Join-Path $cotips 'index.md'
  if(-not (Test-Path $index)){
    "# CoTips Index`n" | Set-Content -Path $index -Encoding UTF8
  }
  "- [$Title]($slug.md) — $ts" | Add-Content -Path $index -Encoding UTF8
  Write-Host "CoTip saved: $path"
}
