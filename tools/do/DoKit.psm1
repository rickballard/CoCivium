Set-StrictMode -Version Latest; $ErrorActionPreference="Stop"

function Get-DownloadsPath {
  if ($env:USERPROFILE) { return Join-Path $env:USERPROFILE "Downloads" }
  throw "USERPROFILE not set"
}

function Write-TextFile([string]$Path,[string]$Content){
  New-Item -Force -ItemType Directory (Split-Path $Path -ErrorAction SilentlyContinue) | Out-Null
  $Content | Set-Content -Encoding UTF8 -NoNewline $Path
}

function New-DoZip {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory)][string]$Name,
    [Parameter(Mandatory)][string]$Version,
    [Parameter(Mandatory)][hashtable]$Files,  # relativePath -> content
    [string]$EntryPoint = "",
    [switch]$ReplaceExisting
  )
  $dl = Get-DownloadsPath
  $zipBase = "CoCivium-$Name-v$Version"
  $zipPath = Join-Path $dl "$zipBase.zip"

  if ((Test-Path $zipPath) -and -not $ReplaceExisting) { return $zipPath }

  $tmp = Join-Path $env:TEMP ("dok-" + [guid]::NewGuid().ToString("N"))
  New-Item -Force -ItemType Directory $tmp | Out-Null

  foreach($k in $Files.Keys){
    $dst = Join-Path $tmp $k
    Write-TextFile -Path $dst -Content $Files[$k]
  }

  $manifest = [ordered]@{ name=$Name; version=$Version; created=(Get-Date).ToString("s"); entry=$EntryPoint } | ConvertTo-Json -Depth 5
  Write-TextFile -Path (Join-Path $tmp "manifest.json") -Content $manifest

  if (Test-Path $zipPath) { Remove-Item $zipPath -Force }
  Compress-Archive -Path (Join-Path $tmp '*') -DestinationPath $zipPath -Force
  Remove-Item -Recurse -Force $tmp
  return $zipPath
}

function New-DoLauncher {
  [CmdletBinding()]
  param(
    [Parameter(Mandatory)][string]$Name,
    [Parameter(Mandatory)][string]$Version,
    [Parameter(Mandatory)][string]$EntryPoint,
    [switch]$CleanupOlderZips,
    [string]$PreferredRepoPath
  )
  $dl = Get-DownloadsPath
  $exe = Join-Path $dl ("Run-" + $Name + "-v" + $Version + ".ps1")
@"
# Auto-generated DO launcher — $Name v$Version
Set-StrictMode -Version Latest; `$ErrorActionPreference='Stop'

function Downloads { if(`$env:USERPROFILE){ Join-Path `$env:USERPROFILE 'Downloads' } else { throw 'No USERPROFILE' } }

`$name    = '$Name'
`$version = '$Version'
`$zip     = Join-Path (Downloads) ("CoCivium-`$name-v`$version.zip")
if(-not (Test-Path `$zip)){ throw "Missing package: `$zip" }

function Remove-OlderZips {
  `$pat = "CoCivium-`$name-v*.zip"
  `$all = Get-ChildItem -Path (Downloads) -Filter `$pat -File | Where-Object { `$_.Name -ne ("CoCivium-`$name-v`$version.zip") }
  foreach(`$z in `$all){ try{ Remove-Item -Force `$z.FullName }catch{} }
}
$(@($CleanupOlderZips) ? 'Remove-OlderZips' : '')

`$dest = Join-Path `$env:LOCALAPPDATA ("CoCivium\do\`$name\v`$version")
if(-not (Test-Path `$dest)){
  New-Item -Force -ItemType Directory `$dest | Out-Null
  Expand-Archive -LiteralPath `$zip -DestinationPath `$dest -Force
}

`$repo = '$PreferredRepoPath'
if(-not `$repo -or -not (Test-Path `$repo)){
  `$guess = Join-Path `$env:USERPROFILE 'Documents\GitHub\CoCivium'
  if(Test-Path `$guess){ `$repo = `$guess } else { `$repo = (Get-Location) }
}

try {
  Push-Location `$repo
  `$ep = Join-Path `$dest '$EntryPoint'
  if(-not (Test-Path `$ep)){ throw "EntryPoint not found inside package: `$ep" }
  Write-Host "Running `$name v`$version from `$repo …"
  pwsh -NoLogo -File `$ep
} finally { Pop-Location 2>`$null }
"@ | Set-Content -Encoding UTF8 -NoNewline $exe
  return $exe
}