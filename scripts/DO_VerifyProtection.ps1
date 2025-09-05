param(
  [string]$Branch = 'main',
  [string[]]$RequiredContexts = @('safety-gate/gate','readme-smoke/check'),
  [switch]$RequireAdminBypass
)
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$prot = gh api repos/:owner/:repo/branches/$Branch/protection -H "Accept: application/vnd.github+json" | ConvertFrom-Json

$got = @()
if ($prot.required_status_checks.contexts) { $got += $prot.required_status_checks.contexts }
if ($prot.required_status_checks.checks)   { $got += ($prot.required_status_checks.checks | ForEach-Object { $_.context }) }
$got = $got | Where-Object { $_ } | Sort-Object -Unique

$missing = @()
foreach ($c in $RequiredContexts) {
  if ($got -notcontains $c) { $missing += $c }
}

$okAdmin = -not $prot.enforce_admins.enabled

if ($RequireAdminBypass -and -not $okAdmin) {
  Write-Error "Admin bypass OFF (enforce_admins=true)."
}
if ($missing) {
  Write-Error ("Missing required checks: " + ($missing -join ', '))
}

if ((-not $missing) -and (-not $RequireAdminBypass -or $okAdmin)) {
  Write-Host ("✓ Protections OK: [" + ($got -join ', ') + "] — admin bypass " + ($(if($okAdmin){'ON'}else{'OFF'})))
  exit 0
} else {
  exit 1
}
