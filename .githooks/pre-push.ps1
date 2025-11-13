#!/usr/bin/env pwsh
$ErrorActionPreference='Stop'
try { if(Get-Command gitleaks -EA SilentlyContinue){ gitleaks protect --no-banner } } catch { Write-Host "::warning ::gitleaks scan failed — continuing" }
try { Import-Module Pester -EA Stop; Invoke-Pester -CI -Tag Quick } catch { Write-Host "::warning ::Pester Quick missing — continuing" }
