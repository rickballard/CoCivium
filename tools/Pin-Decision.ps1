param(
  [Parameter(Mandatory)][string]$Title,
  [string]$Do = "",
  [string]$Advisory = ""
)
$ts = Get-Date -Format "yyyy-MM-dd HH:mm:ss K"
$ym = Get-Date -Format "yyyyMM"
$log = Join-Path "admin/history/decisions" "DECISIONS_$ym.md"

# ensure directory exists
$dir = Split-Path $log
if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Force $dir | Out-Null }

if (-not (Test-Path $log)) {
  @("# Decisions Log ($ym)", "") | Set-Content -Encoding utf8 $log
}

$entry = @(
  "## $Title",
  "*When:* $ts",
  "",
  "### DO",
  ($Do -ne "" ? $Do : "(none)"),
  "",
  "### ADVISORY",
  ($Advisory -ne "" ? $Advisory : "(none)"),
  "",
  "---",""
) -join "`n"

Add-Content -Path $log -Value $entry -Encoding utf8
Write-Host "Pinned: $Title → $log"
