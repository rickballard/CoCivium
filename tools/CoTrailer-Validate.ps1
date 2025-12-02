param([Parameter(Mandatory=$true)][string]$RepoPath,[string]$SchemaPath="schemas/co.trailer.schema.json")
$ErrorActionPreference='Stop'; Set-StrictMode -Version Latest
$files = Get-ChildItem -Path $RepoPath -Recurse -File -Include *.cotrail.json,*.cotrail.yaml,*.cotrail.yml
if(!$files){ Write-Host "[CoTrailer] none found"; exit 0 }
$errors=@()
foreach($f in $files){
  try{
    if($f.Extension -match "ya?ml"){
      if(Get-Command ConvertFrom-Yaml -ErrorAction SilentlyContinue){
        $obj = Get-Content -Raw $f.FullName | ConvertFrom-Yaml | ConvertTo-Json -Depth 20 | ConvertFrom-Json
      } else { continue }
    } else { $obj = Get-Content -Raw $f.FullName | ConvertFrom-Json }
    foreach($k in @('id','title','version','asset_type','intents','fitness')){
      if($null -eq $obj.$k){ $errors += "$($f.FullName): missing $k" }
    }
  } catch { $errors += "$($f.FullName): read/parse failed: $($_.Exception.Message)" }
}
if($errors.Count){ "Trailer errors:"; $errors | % { " - $_" }; exit 2 }
Write-Host "[CoTrailer] validated $($files.Count) file(s)"
