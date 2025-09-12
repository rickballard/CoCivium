param([Parameter(Mandatory=$true)][string]$InputDir,[Parameter(Mandatory=$true)][string]$OutputCsv)
Set-StrictMode -Version Latest;$ErrorActionPreference="Stop"
function Normalize-Email([string]$e){if([string]::IsNullOrWhiteSpace($e)){return $null};$e=$e.Trim().ToLower();if($e -notmatch '^[^@\s]+@[^@\s]+\.[^@\s]+$'){return $null};$e}
function Split-Name([string]$full){$full=($full??"").Trim();if($full -eq ""){return @{Given="";Family=""}};$p=$full -split '\s+';@{Given=$p[0];Family=$p[-1]}}
$rows=[System.Collections.Generic.List[object]]::new()
Get-ChildItem -Path $InputDir -File -Include *.csv | ForEach-Object{
  $src=$_.Name.ToLower();$data=Import-Csv $_ -Encoding UTF8
  foreach($r in $data){
    $name=$r.full_name ?? $r.name ?? "$($r.first_name) $($r.last_name)"
    $email=Normalize-Email ($r.email ?? $r.email_address ?? $r.mail)
    $nm=Split-Name $name
    if(-not $email -and [string]::IsNullOrWhiteSpace($name)){continue}
    $rows.Add([pscustomobject]@{
      full_name=$name;given_name=$nm.Given;family_name=$nm.Family;email=$email
      company=$r.company ?? $r.organization ?? $r.current_company;title=$r.title ?? $r.job_title
      source=(if($src -like '*linkedin*'){'linkedin'}elseif($src -like '*export*'){'email'}else{'legacy'})
      match_confidence=0;reach_channel=if($email){'email'}else{'unknown'};notes=''
    })
  }
}
$dedup=@{}
foreach($x in $rows){
  $k=if($x.email){"e::$($x.email)"}else{"n::$($x.full_name)|$($x.company)"}
  if(-not $dedup.ContainsKey($k)){$dedup[$k]=$x;continue}
  $y=$dedup[$k]
  foreach($prop in 'company','title','reach_channel'){
    if([string]::IsNullOrWhiteSpace($y.$prop) -and -not [string]::IsNullOrWhiteSpace($x.$prop)){$y.$prop=$x.$prop}
  }
  if($y.source -ne 'linkedin' -and $x.source -eq 'linkedin'){$y.source='linkedin'}
}
$dedup.Values | Sort-Object family_name, given_name | Export-Csv -NoTypeInformation -Encoding UTF8 -Path $OutputCsv
Write-Host "Wrote $($dedup.Count) unique contacts to $OutputCsv"
