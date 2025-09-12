param(
  [Parameter(Mandatory=$true)][string]$MasterCsv,      # workflows/output/contacts_master.csv
  [Parameter(Mandatory=$true)][string]$LinkedInCsv     # raw LinkedIn connections export
)
Set-StrictMode -Version Latest; $ErrorActionPreference = "Stop"

$master   = Import-Csv $MasterCsv -Encoding UTF8
$linkedin = Import-Csv $LinkedInCsv -Encoding UTF8

# Build simple email index
$byEmail = @{}
foreach ($l in $linkedin){
  $em = ($l."Email Address" ?? $l.email ?? $l.Email)
  if ($em) {
    $em = $em.Trim().ToLower()
    if (-not $byEmail.ContainsKey($em)) { $byEmail[$em] = @() }
    $byEmail[$em] += $l
  }
}

function Score-Name($m, $l){
  $mn = ($m.full_name ?? '').ToLower()
  $ln = (($l."First Name" + ' ' + $l."Last Name") ?? '').ToLower()
  if ($mn -and $ln -and $mn -eq $ln) { return 100 }
  if ($mn -and $ln -and $mn -like "$ln*") { return 80 }
  return 0
}

[int]$matched=0
foreach ($r in $master){
  $hit = $null
  if ($r.email -and $byEmail.ContainsKey($r.email)){
    $hit = $byEmail[$r.email] | Select-Object -First 1
    $r.match_confidence = 100
    $r.reach_channel = if ($r.email) {'both'} else {'linkedin_msg'}
  } else {
    $cand = $linkedin | Where-Object {
      ($_. "First Name" + ' ' + $_. "Last Name") -and
      ($r.full_name) -and
      ($r.full_name.Split()[0]) -eq ($_. "First Name")
    } | Select-Object -First 1
    if ($cand) { $r.match_confidence = [Math]::Max($r.match_confidence, (Score-Name $r $cand)); $hit = $cand }
  }
  if ($hit) { $matched++ }
}

$master | Export-Csv -NoTypeInformation -Encoding UTF8 -Path $MasterCsv
Write-Host "Matched approx $matched / $($master.Count) contacts (updated in place)"
