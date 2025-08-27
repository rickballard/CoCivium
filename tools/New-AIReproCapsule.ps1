[CmdletBinding()] param()
$ts = Get-Date -Format "yyyy-MM-dd HH:mm:ssK"
$ref = (git rev-parse --abbrev-ref HEAD) 2>$null
$sha = (git rev-parse --short HEAD) 2>$null
$report = ".reports/ai-repro-$($sha)-$((Get-Date).ToString("yyyyMMdd-HHmmss")).txt"
New-Item -ItemType Directory -Force -Path ".reports" | Out-Null
"AI Repro Capsule"             | Out-File $report -Encoding UTF8
"Timestamp: $ts"              | Add-Content $report
"Branch: $ref  SHA: $sha"     | Add-Content $report
"OS: $([System.Environment]::OSVersion.VersionString)" | Add-Content $report
"PowerShell: $($PSVersionTable.PSVersion)"            | Add-Content $report
"gh --version: $(gh --version | Select-String -First 1)" | Add-Content $report
"Recent PRs:"                 | Add-Content $report
(gh pr list --state open --limit 5) | Add-Content $report
"Note: add minimal repro block + outputs below this line." | Add-Content $report
"---- REPRO BLOCK ----"       | Add-Content $report
Write-Host "Repro capsule -> $report"
