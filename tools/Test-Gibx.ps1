param([string]$Path = "docs/ai/FRONT_DOOR.gibx")
$ErrorActionPreference='Stop'
$repo = Split-Path -Parent $PSScriptRoot
$full = Join-Path $repo $Path
if(!(Test-Path $full)){ throw "Missing: $Path" }
$txt = Get-Content $full -Raw

# required directives
$need = @('frontdoor','map','bpoe')
foreach($k in $need){
  if($txt -notmatch "^\s*@$k\s*:" ){ throw "Missing directive: @$k" }
}

# relative link existence
$root = Split-Path $full
$rx = '^\s*@(?:frontdoor|map|bpoe|theory|practice)\s*:\s*(.+)$'
foreach($m in [regex]::Matches($txt,$rx,'Multiline')){
  $v=$m.Groups[1].Value.Trim()
  if($v -notmatch '^(https?:)?//'){
    $t = Join-Path $root $v
    if(!(Test-Path $t)){ throw "Broken path in $Path → $v" }
  }
}

Write-Host "GIBX OK: $Path"

