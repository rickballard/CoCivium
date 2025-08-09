
param(
  [string]$ProfileDir = "Default",
  [string]$OutDir     = "admin/setup"
)
$ErrorActionPreference = "Stop"

function Get-Prop($obj, [string]$path) {
  $cur = $obj
  foreach ($seg in ($path -split '\.')) {
    if ($null -eq $cur) { return $null }
    $prop = $cur.PSObject.Properties[$seg]
    if ($null -eq $prop) { return $null }
    $cur = $prop.Value
  }
  return $cur
}

$base = Join-Path "$env:LOCALAPPDATA\Google\Chrome\User Data" $ProfileDir
$prefsPath = Join-Path $base "Preferences"
$localStatePath = Join-Path "$env:LOCALAPPDATA\Google\Chrome\User Data" "Local State"
$extRoot = Join-Path $base "Extensions"

if (!(Test-Path $prefsPath))     { throw "Preferences not found: $prefsPath" }
if (!(Test-Path $localStatePath)){ throw "Local State not found: $localStatePath" }

$prefs = Get-Content -Raw $prefsPath | ConvertFrom-Json
$local = Get-Content -Raw $localStatePath | ConvertFrom-Json

# Core settings (best-effort - keys differ across versions)
$summary = [ordered]@{}
$summary.profile            = $ProfileDir
$summary.homepage           = Get-Prop $prefs "homepage"
$summary.homepage_is_newtab = Get-Prop $prefs "homepage_is_newtabpage"
$summary.restore_on_startup = Get-Prop $prefs "session.restore_on_startup"
$summary.startup_urls       = Get-Prop $prefs "session.startup_urls"
$summary.bookmark_bar       = Get-Prop $prefs "bookmark_bar.show_on_all_tabs"
$summary.search_provider    = @{
  name       = Get-Prop $prefs "default_search_provider.name"
  search_url = Get-Prop $prefs "default_search_provider.search_url"
}

# Flags (if present)
$summary.flags = Get-Prop $local "browser.enabled_labs_experiments"
if ($null -eq $summary.flags) { $summary.flags = @() }

# Extensions (id, name, version, enabled)
$ids = @()
try {
  $ids = ($prefs.extensions.settings | Get-Member -MemberType NoteProperty | Select-Object -ExpandProperty Name)
} catch {}

function Resolve-LocalizedName($dir, $manifest) {
  $name = $manifest.name
  if ($name -is [string] -and $name -match '^__MSG_(.+)__$') {
    $key = $matches[1]
    foreach ($loc in @('en_US','en','en-GB')) {
      $m = Join-Path $dir "_locales\$loc\messages.json"
      if (Test-Path $m) {
        try {
          $msgs = Get-Content -Raw $m | ConvertFrom-Json
          if ($msgs.$key.message) { return $msgs.$key.message }
        } catch {}
      }
    }
  }
  return $name
}

$exts = @()
foreach ($id in $ids) {
  $dir = Join-Path $extRoot $id
  if (!(Test-Path $dir)) { continue }
  $verDir = Get-ChildItem -Path $dir -Directory | Sort-Object Name -Descending | Select-Object -First 1
  if (-not $verDir) { continue }
  $manPath = Join-Path $verDir.FullName "manifest.json"
  if (!(Test-Path $manPath)) { continue }
  try { $man = Get-Content -Raw $manPath | ConvertFrom-Json } catch { continue }
  $name = Resolve-LocalizedName $verDir.FullName $man
  $ver  = $man.version
  $enabled = $true
  if ($prefs.extensions.settings.$id) {
    $state = $prefs.extensions.settings.$id.state
    $enabled = ($state -eq 1)
  }
  $exts += [pscustomobject]@{
    id=$id; name=$name; version=$ver; enabled=$enabled;
    store=("https://chromewebstore.google.com/detail/{0}" -f $id)
  }
}
$summary.extensions = $exts | Sort-Object name

# Write outputs (sanitized - no tokens/cookies/history)
$ts = (Get-Date).ToUniversalTime().ToString("yyyyMMddTHHmmssZ")
$outJson = Join-Path $OutDir ("chrome_profile_summary_{0}.json" -f $ts)
$outMd   = Join-Path $OutDir ("chrome_profile_summary_{0}.md"   -f $ts)

$summary | ConvertTo-Json -Depth 6 | Out-File -Encoding UTF8 $outJson

$lines = @("# Chrome Profile Summary ($ts)", "", "## Core", "")
$lines += "* Profile: **$ProfileDir**"
$lines += "* Homepage: **$($summary.homepage)** (is_newtab=$($summary.homepage_is_newtab))"
$lines += "* Restore on startup: **$($summary.restore_on_startup)**"
if ($summary.startup_urls) {
  $lines += "* Startup URLs:"; foreach ($u in $summary.startup_urls) { $lines += "  - $u" }
}
$lines += "* Bookmark bar visible: **$($summary.bookmark_bar)**"
$lines += "* Search provider: **$($summary.search_provider.name)** - $($summary.search_provider.search_url)"
$lines += ""
$lines += "## Flags"
if ($summary.flags.Count -gt 0) { foreach ($f in $summary.flags) { $lines += "- $f" } } else { $lines += "_None_" }
$lines += ""
$lines += "## Extensions (enabled state)"
$lines += ""
$lines += "| Name | Version | Enabled | ID | Store |"
$lines += "|------|---------|---------|----|-------|"
foreach ($e in $summary.extensions) {
  $lines += ("| {0} | {1} | {2} | {3} | [{3}]({4}) |" -f $e.name,$e.version,$e.enabled,$e.id,$e.store)
}
Set-Content -Path $outMd -Value ($lines -join "`r`n") -Encoding UTF8

Write-Host "Wrote $outJson"
Write-Host "Wrote $outMd"
