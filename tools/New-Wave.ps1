param([string]$Type="contentwave",[string]$Id,[string]$Out="waves")
$ErrorActionPreference="Stop"
if(-not $Id){ $Id = ("mw-" + (Get-Random -Maximum 999999)) }
$root = Resolve-Path "$PSScriptRoot\.." | % Path
$dir  = Join-Path $root "$Out\$Id"
New-Item -ItemType Directory -Force $dir, (Join-Path $dir "_spanky"), (Join-Path $dir "payload"), (Join-Path $dir "notes"), (Join-Path $dir "receipts"), (Join-Path $dir "manifest") | Out-Null
$man = @{
  id=$Id; type=$Type; version="0.1.0"; created_utc=(Get-Date).ToUniversalTime().ToString("o");
  source_repo="rickballard/CoCivium"; payload=@(); receipts=@("receipts/VIOLET_PLACEHOLDER.md"); notes=@(); links=@(); promotion="draft"
} | ConvertTo-Json -Depth 5
$mf = Join-Path $dir "manifest\wave.manifest.json"
[IO.File]::WriteAllText($mf, $man, [Text.UTF8Encoding]::new($false))
"Created $dir"