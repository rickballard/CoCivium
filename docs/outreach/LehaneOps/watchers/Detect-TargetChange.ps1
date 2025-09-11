param([string]$ConfigPath = ".\watch.config.json", [string]$StatePath = "..\reports\state\target.json")
$ErrorActionPreference='Stop'; Set-StrictMode -Version Latest
$here = Split-Path -Parent $MyInvocation.MyCommand.Path; Set-Location $here

function Load-Json([string]$p){ if(!(Test-Path $p)){ throw "Missing $p" }; Get-Content -Raw -LiteralPath $p | ConvertFrom-Json }
function Get-Prop($obj,[string]$name){
  if ($null -eq $obj) { return $null }
  $p = $obj.PSObject.Properties[$name]
  if ($p) { return $p.Value } else { return $null }
}

$cfg = Load-Json $ConfigPath
$targets = Get-Prop $cfg 'targets'
if (-not $targets) { throw "Config missing 'targets' array." }
$target = $targets[0]
$expectedName = Get-Prop $target 'name'
$expectedRole = Get-Prop $target 'role_expectation'

# Safe feed retrieval
$feeds = Get-Prop $cfg 'role_check_feeds'
if (-not $feeds -or $feeds.Count -eq 0) {
  $q = if ($expectedName) { $expectedName -replace '\s+','+' } else { 'OpenAI+policy' }
  $feeds = @(
    "https://www.bing.com/news/search?q=$q&format=rss",
    "https://www.bing.com/news/search?q=OpenAI+global+policy+head&format=rss"
  )
}

# Pull items
$items = @()
foreach($u in $feeds){
  try {
    [xml]$rss = (Invoke-WebRequest -UseBasicParsing -Uri $u -TimeoutSec 20).Content
    if ($rss -and $rss.rss.channel.item) { $items += $rss.rss.channel.item }
  } catch { }
}

# Extract role snippet
$observedRole = $null
foreach($it in $items){
  $txt = ($it.title + " " + $it.description)
  if ($expectedName) {
    if ($txt -match ("(?i)\b" + [regex]::Escape($expectedName).Replace('\ ','\s+') + "\b") -and
        $txt -match '(?i)(vp|head|chief|lead).{0,40}(policy|public policy|global policy)') { $observedRole = $Matches[0]; break }
  } else {
    if ($txt -match '(?i)openai' -and $txt -match '(?i)(vp|head|chief|lead).{0,40}(policy|public policy|global policy)') { $observedRole = $Matches[0]; break }
  }
}

$changed = $false; $notes = @()
if ($observedRole) {
  $notes += "Observed role snippet: [$observedRole]"
  if ($expectedRole -and ($observedRole -notmatch [regex]::Escape($expectedRole))) { $changed = $true; $notes += "Expected role: [$expectedRole] does not match observed." }
} else { $notes += "No role snippet observed; unable to verify." }

# Write report
$ts = Get-Date -Format 'yyyyMMdd_HHmmss'
$outDir = Resolve-Path (Join-Path $here '..\reports\role-guard') -ErrorAction SilentlyContinue
if (-not $outDir) { $outDir = Join-Path $here '..\reports\role-guard'; New-Item -ItemType Directory -Force -Path $outDir | Out-Null }
$reportPath = Join-Path $outDir "role_check_$ts.md"
("# Role Guard - Target Check","","*Time:* $(Get-Date)","*Expected Name:* $expectedName","*Expected Role:* $expectedRole","*Changed?:* " + ($(if($changed){"YES"}else{"no"})),"","## Notes") + $notes |
 Out-String | Set-Content -Encoding UTF8 $reportPath

# Persist state
$stateFile = Resolve-Path (Join-Path $here $StatePath) -ErrorAction SilentlyContinue
if (-not $stateFile) { $stateFile = Join-Path $here $StatePath; New-Item -ItemType Directory -Force -Path (Split-Path -Parent $stateFile) | Out-Null; '{}' | Set-Content -Encoding UTF8 $stateFile }
$state = Get-Content -Raw $stateFile | ConvertFrom-Json
$state.last_check=Get-Date; $state.expected_name=$expectedName; $state.expected_role=$expectedRole; $state.observed_role=$observedRole; $state.changed=$changed
$state | ConvertTo-Json -Depth 5 | Set-Content -Encoding UTF8 $stateFile

# Optional GH issue
if ($changed) { $gh = Get-Command gh -ErrorAction SilentlyContinue; if ($gh) { try { gh issue create --title "LehaneOps: Role/title change detected for $expectedName" --label "LehaneOps" --body (Get-Content -Raw $reportPath) | Out-Null } catch {} } }

"RoleGuard: report -> $reportPath; changed=$changed"
