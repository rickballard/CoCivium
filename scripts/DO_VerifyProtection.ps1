param(
  [string]$Branch = 'main',
  [string[]]$RequiredContexts = @('safety-gate/gate','readme-smoke/check'),
  [switch]$RequireAdminBypass = $true
)
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$prot = gh api repos/:owner/:repo/branches/$Branch/protection -H "Accept: application/vnd.github+json" | ConvertFrom-Json

$okAdmin = -not $prot.enforce_admins.enabled
$rx = @()
foreach ($c in $RequiredContexts) {
  if ((@($prot.required_status_checks.contexts + ($prot.required_status_checks.checks | ForEach-Object { param(
  [string]$Branch = 'main',
  [string[]]$RequiredContexts = @('safety-gate/gate','readme-smoke/check'),
  [switch]$RequireAdminBypass = $true
)
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$prot = gh api repos/:owner/:repo/branches/$Branch/protection -H "Accept: application/vnd.github+json" | ConvertFrom-Json

$okAdmin = -not $prot.enforce_admins.enabled
$rx = @()
foreach ($c in $RequiredContexts) {
  if ($prot.required_status_checks.contexts -notcontains $c) { $rx += $c }
}

if ($RequireAdminBypass -and -not $okAdmin) {
  Write-Error "Admin bypass is OFF (enforce_admins=true)."
}
if ($rx) {
  Write-Error ("Missing required checks: " + ($rx -join ', '))
}
if (($RequireAdminBypass -and $okAdmin) -and -not $rx) {
  Write-Host "✓ Protections OK: admin bypass ON; required checks present."
  exit 0
} else {
  exit 1
}
.context })) -notcontains $c)) { $rx += $c }
}

if ($RequireAdminBypass -and -not $okAdmin) {
  Write-Error "Admin bypass is OFF (enforce_admins=true)."
}
if ($rx) {
  Write-Error ("Missing required checks: " + ($rx -join ', '))
}
if (($RequireAdminBypass -and $okAdmin) -and -not $rx) {
  Write-Host "✓ Protections OK: admin bypass ON; required checks present."
  exit 0
} else {
  exit 1
}

