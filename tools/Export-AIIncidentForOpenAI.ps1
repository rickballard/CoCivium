[CmdletBinding()]
param(
  [string]$InputPath = (Get-ChildItem ".reports/ai-repro-*.txt" | Sort-Object LastWriteTime -Descending | Select-Object -First 1).FullName,
  [ValidateSet("product","api","security","gptstore","unknown")]
  [string]$Kind = "product"
)
if (-not $InputPath) { throw "No repro capsule found. Run tools/New-AIReproCapsule.ps1 first."; }

$txt = Get-Content -Raw $InputPath

# Redact obvious secrets & long tokens
$patterns = @(
  'sk-[A-Za-z0-9]{20,}',            # API keys
  '(?i)(authorization:\s*bearer\s+)[A-Za-z0-9\.\-_]{20,}',
  '(?i)(openai_api_key|password|token|secret)\s*[:=]\s*[^\r\n]+',
  '[A-Za-z0-9+\/]{80,}={0,2}'        # base64-ish blobs
)
foreach($p in $patterns){ $txt = [regex]::Replace($txt, $p, '$1[REDACTED]') }

# Trim paths
$repoRoot = (git rev-parse --show-toplevel) 2>$null
if ($repoRoot) { $txt = $txt.Replace($repoRoot, '<REPO_ROOT>') }

# Build export
$outDir = ".reports/export"
New-Item -ItemType Directory -Force -Path $outDir | Out-Null
$out = Join-Path $outDir ("openai-report-" + (Get-Date -Format 'yyyyMMdd-HHmmss') + ".md")

@"
# External Report (Sanitized)

**Kind:** $Kind  
**Timestamp:** $(Get-Date -Format 'u')  
**Branch:** $(git rev-parse --abbrev-ref HEAD)  **SHA:** $(git rev-parse --short HEAD)

## Summary
<one-paragraph summary here>

## Minimal Repro (sanitized)
$txt

## Environment
OS: $([System.Environment]::OSVersion.VersionString)
PowerShell: $($PSVersionTable.PSVersion)
"@ | Set-Content -Encoding UTF8 $out

Write-Host "Export ready: $out"

# Open the correct channel
switch ($Kind) {
  "product" { Start-Process "https://help.openai.com/en/articles/6614161-how-can-i-contact-support" } # support chat widget
  "api"     { Start-Process "https://help.openai.com/en/" } # Help Center → API category
  "gptstore"{ Start-Process "https://help.openai.com/en/articles/8554982-how-should-i-report-a-gpt" }
  "security"{ Start-Process "https://openai.com/policies/coordinated-vulnerability-disclosure-policy/" }
  default   { Start-Process "https://help.openai.com/en/" }
}
