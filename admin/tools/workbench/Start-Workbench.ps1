param()
$ErrorActionPreference = "Stop"

$repo   = Join-Path $env:USERPROFILE "Documents\GitHub\CoCivium"
$logDir = Join-Path $env:USERPROFILE "Documents\CoCiviumLogs"
New-Item -ItemType Directory -Force $logDir | Out-Null
$ts     = Get-Date -Format "yyyyMMdd_HHmmss"

# 1) Preflight from repo root (so README.md is found), but don't block startup if it fails
$pre = Join-Path $repo "tools\readme-preflight.ps1"
if (Test-Path $pre) {
  $log = Join-Path $logDir ("preflight_{0}.log" -f $ts)
  Push-Location $repo
  try {
    (& pwsh -NoProfile -ExecutionPolicy Bypass -File $pre *>&1) |
      Tee-Object -FilePath $log | Out-Null
    Copy-Item $log (Join-Path $logDir "preflight_latest.log") -Force
  } catch {
    $_ | Out-String | Tee-Object -FilePath (Join-Path $logDir "preflight_latest.log") | Out-Null
  } finally { Pop-Location }
}

# 2) Open tabs via the Windows shell (respects default browser = Chrome for you)
$urls = @(
  "https://chat.openai.com/",
  "https://github.com/rickballard/CoCivium",
  "https://github.com/rickballard/CoCivium/blob/main/docs/ISSUEOPS.md"
)
foreach ($u in $urls) {
  Start-Process "cmd.exe" -ArgumentList "/c start """" `"$u`""
}
exit 0