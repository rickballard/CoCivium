#!/usr/bin/env pwsh
$ErrorActionPreference='Stop'
if(Get-Command gitleaks -EA SilentlyContinue){ gitleaks protect --staged --no-banner } else { Write-Host "::warning ::gitleaks not installed — SecretListener (local) is a no-op" -ForegroundColor Yellow }
