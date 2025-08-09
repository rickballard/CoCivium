
param(
  [string]$ManifestPath = "admin/setup/chrome_upgrade_manifest.json",
  [string]$OutDir       = "admin/setup/dist"
)
$ErrorActionPreference = "Stop"

if (!(Test-Path $ManifestPath)) { throw "Manifest not found: $ManifestPath" }
$cfg = Get-Content -Raw $ManifestPath | ConvertFrom-Json

$ts = (Get-Date).ToUniversalTime().ToString("yyyyMMddTHHmmssZ")
$pack = Join-Path $OutDir ("ChromeUpgrade_{0}" -f $ts)
New-Item -ItemType Directory -Force -Path $pack | Out-Null

# Map startup modes to policy values (Chrome policy)
$startupMap = @{
  newtab      = 1
  urls        = 4
  lastsession = 5
}

$reg = @()
$reg += 'Windows Registry Editor Version 5.00'
$reg += ''
$reg += '[HKEY_CURRENT_USER\Software\Policies\Google\Chrome]'

if ($cfg.homepage) {
  $reg += ('"HomepageLocation"="{0}"' -f $cfg.homepage)
  if ($cfg.homepage_is_newtab -eq $true) {
    $reg += '"HomepageIsNewTabPage"=dword:00000001'
  } else {
    $reg += '"HomepageIsNewTabPage"=dword:00000000'
  }
}
if ($cfg.bookmark_bar -ne $null) {
  $reg += ('"BookmarkBarEnabled"=dword:{0}' -f ($(if($cfg.bookmark_bar){"00000001"}else{"00000000"})))
}
if ($cfg.restore_on_startup) {
  $mode = $cfg.restore_on_startup.ToLower()
  if (!$startupMap.ContainsKey($mode)) { throw "Unknown restore_on_startup: $mode" }
  $reg += ('"RestoreOnStartup"=dword:{0:X8}' -f $startupMap[$mode])
  if ($mode -eq 'urls' -and $cfg.startup_urls) {
    $reg += ''
    $reg += '[HKEY_CURRENT_USER\Software\Policies\Google\Chrome\RestoreOnStartupURLs]'
    $i = 1
    foreach ($u in $cfg.startup_urls) { $reg += ('"{0}"="{1}"' -f $i,$u); $i++ }
  }
}
if ($cfg.extensions -and $cfg.extensions.Count -gt 0) {
  $reg += ''
  $reg += '[HKEY_CURRENT_USER\Software\Policies\Google\Chrome\ExtensionInstallForcelist]'
  $i = 1
  foreach ($id in $cfg.extensions) {
    $reg += ('"{0}"="{1};https://clients2.google.com/service/update2/crx"' -f $i,$id)
    $i++
  }
}

$apply = Join-Path $pack "apply.reg"
$rollback = Join-Path $pack "rollback.reg"
$changes = Join-Path $pack "CHANGES.md"
$install = Join-Path $pack "INSTALL.cmd"
$undo    = Join-Path $pack "UNDO.cmd"

Set-Content -Path $apply    -Value ($reg -join "`r`n") -Encoding ASCII
# Conservative rollback: remove the Chrome policy subtree we touched
Set-Content -Path $rollback -Value "Windows Registry Editor Version 5.00`r`n`r`n[-HKEY_CURRENT_USER\Software\Policies\Google\Chrome]" -Encoding ASCII

$md = @("# Chrome Upgrade Pack", "", "**Generated:** $ts", "", "### Will apply", "")
if ($cfg.homepage)           { $md += "- Homepage → `$($cfg.homepage)` (NewTabPage=$($cfg.homepage_is_newtab -eq $true))" }
if ($cfg.bookmark_bar -ne $null) { $md += "- Bookmark bar → `$($cfg.bookmark_bar)`" }
if ($cfg.restore_on_startup) { $md += "- Restore on startup → `$($cfg.restore_on_startup)`" }
if ($cfg.startup_urls)       { foreach ($u in $cfg.startup_urls){ $md += "  - $u" } }
if ($cfg.extensions)         { $md += "- Forcelist extensions:"; foreach ($e in $cfg.extensions){ $md += "  - $e" } }
$md += ""
$md += "> Note: Applying policies marks Chrome as **Managed** for this user. Rollback restores the previous unmanaged state for HKCU."
Set-Content -Path $changes -Value ($md -join "`r`n") -Encoding UTF8

Set-Content -Path $install -Value "@echo off`r`nreg import ""%~dp0apply.reg""`r`necho Applied. Restart Chrome.`r`npause" -Encoding ASCII
Set-Content -Path $undo    -Value "@echo off`r`nreg import ""%~dp0rollback.reg""`r`necho Rolled back. Restart Chrome.`r`npause" -Encoding ASCII

Write-Host "Wrote pack: $pack"
