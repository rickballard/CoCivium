param(
  [string]$GibxPath = "docs/ai/FRONT_DOOR.gibx",
  [string]$JsonPath = "docs/ai/FRONT_DOOR.json"
)
$ErrorActionPreference="Stop"
$repo = git rev-parse --show-toplevel
$gibx = Join-Path $repo $GibxPath
$json = Join-Path $repo $JsonPath
if(!(Test-Path $gibx)){ throw "Missing $GibxPath" }
if(!(Test-Path $json)){ throw "Missing $JsonPath" }

function Parse-Gibx([string]$Path){
  $dir=@{}; Get-Content $Path | %{
    if($_ -match "^\s*@([^:]+)\s*:\s*(.+)$"){ $dir[$Matches[1]]=$Matches[2] }
  }; $dir
}

$gd = Parse-Gibx $gibx
$jd = (Get-Content $json -Raw | ConvertFrom-Json).directives

$gKeys = @($gd.Keys | Sort-Object)
$jKeys = @($jd.PSObject.Properties.Name | Sort-Object)

$missInJson = $gKeys | ? { $_ -notin $jKeys }
$missInGibx = $jKeys | ? { $_ -notin $gKeys }

if($missInJson){ throw "JSON mirror missing keys: $($missInJson -join ', ')" }
if($missInGibx){ throw "GIBX missing keys present in JSON: $($missInGibx -join ', ')" }

Write-Host "GIBX⇄JSON directives match."
