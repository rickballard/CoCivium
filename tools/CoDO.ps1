function New-DO {
  [CmdletBinding()] param([Parameter(Mandatory)][string]$Title,[string]$Id)
  $tz  = [System.TimeZoneInfo]::FindSystemTimeZoneById("Eastern Standard Time")
  $now = [System.TimeZoneInfo]::ConvertTime([DateTimeOffset]::UtcNow,$tz)
  $id  = $Id; if (-not $id) { $id = (Get-ChildItem .reports\do-*.md -ErrorAction SilentlyContinue | Measure-Object).Count + 1 }
  $stamp = $now.ToString("yyyy-MM-dd HH:mm 'ET'")
  "[{0}] DO-{1} — {2}" -f $stamp, $id, $Title
}

function End-DO {
  [CmdletBinding()] param([Parameter(Mandatory)][string]$Outcome,[string]$Id)
  $tz  = [System.TimeZoneInfo]::FindSystemTimeZoneById("Eastern Standard Time")
  $now = [System.TimeZoneInfo]::ConvertTime([DateTimeOffset]::UtcNow,$tz)
  $id  = $Id; if (-not $id) { $id = "?" }
  "[{0}] DO-{1} — Outcome: {2}" -f $now.ToString("yyyy-MM-dd HH:mm 'ET'"), $id, $Outcome
}

function Save-DO {
  [CmdletBinding()] param([Parameter(Mandatory)][string]$Text)
  New-Item -ItemType Directory -Force -Path .reports | Out-Null
  $log = ".reports/do-log-$((Get-Date).ToString('yyyyMMdd')).md"
  Add-Content -Encoding utf8 -Path $log -Value $Text
}

function Show-AssistantPrefs {
  if (Test-Path .cocivium.assist.json) { Get-Content -Raw .cocivium.assist.json } else { 'NO PREFS FILE (.cocivium.assist.json) FOUND' }
}
