Set-StrictMode -Version Latest
$script:fail = $false
function Fail($m){ Write-Error $m; $script:fail = $true }

# Heartbeat must not use $script:
if (Select-String -Path tools/heartbeat.ps1 -SimpleMatch '$script:' -Quiet) {
  Fail "tools/heartbeat.ps1 contains `$script: (must use global __BPOE_* state)."
}

# Admin tools must import heartbeat & gh-safe and wrap long ops
$tools = @('tools/pr-admin-merge.ps1','tools/bp-unprotect.ps1')
foreach ($t in $tools) {
  if (!(Test-Path $t)) { Fail "$t missing"; continue }
  $content = Get-Content $t -Raw
  if ($content -notmatch 'heartbeat\.ps1')          { Fail "$t must dot-source heartbeat.ps1" }
  if ($content -notmatch 'gh-safe\.ps1')            { Fail "$t must dot-source gh-safe.ps1" }
  if ($content -notmatch 'Invoke-WithHeartbeat')    { Fail "$t must wrap long ops with Invoke-WithHeartbeat" }
}

if ($script:fail) { exit 1 } else { Write-Host "OK: BPOE validation passed." }