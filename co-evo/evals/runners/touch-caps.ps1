param(
  [Parameter(Mandatory=$true)][string]$ChangedFilesJson
)
# Expect a JSON array of objects with properties: path, loc_delta
$files = $ChangedFilesJson | ConvertFrom-Json
$maxFiles = 32; $maxLoc = 1000
$loc = ($files | Measure-Object -Property loc_delta -Sum).Sum
if($files.Count -gt $maxFiles -or $loc -gt $maxLoc){
  Write-Error "Caps exceeded: files=$($files.Count) (max $maxFiles), loc_delta=$loc (max $maxLoc)."
}
