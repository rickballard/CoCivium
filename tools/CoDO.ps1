function New-DO {
  [CmdletBinding()] param([Parameter(Mandatory)][string]$Title,[string]$Id)
  $tz = [System.TimeZoneInfo]::FindSystemTimeZoneById("Eastern Standard Time")
  $now = [System.TimeZoneInfo]::ConvertTime([DateTimeOffset]::UtcNow,$tz)
  if (-not $Id) { $Id = (Get-ChildItem .reports\do-*.md -ErrorAction SilentlyContinue | Measure-Object).Count + 1 }
  "[{0}] DO-{1} — {2}" -f $now.ToString("yyyy-MM-dd HH:mm 'ET'"), $Id, $Title
}
function Save-DO {
  [CmdletBinding()] param([Parameter(Mandatory)][string]$Text)
  $fname = ".reports/do-log-$((Get-Date).ToString('yyyyMMdd')).md"
  Add-Content -Encoding UTF8 $fname $Text
  Write-Host "Saved → $fname"
}
function End-DO {
  [CmdletBinding()] param([Parameter(Mandatory)][string]$Outcome,[string]$Id)
  $tz = [System.TimeZoneInfo]::FindSystemTimeZoneById("Eastern Standard Time")
  $now = [System.TimeZoneInfo]::ConvertTime([DateTimeOffset]::UtcNow,$tz)
  "[{0}] DO-{1} — Outcome: {2}" -f $now.ToString("yyyy-MM-dd HH:mm 'ET'"), ($Id?$Id:'?'), $Outcome
}
