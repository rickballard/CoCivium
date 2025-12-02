param([Parameter(Mandatory=$true)][string]$RepoPath,[string]$SchemaPath="schemas/co.noisebudget.schema.json")
$ErrorActionPreference='Stop'; Set-StrictMode -Version Latest
$files = Get-ChildItem -Path $RepoPath -Recurse -File -Include .conoise.json,.conoise.yaml,*.conoise.yml
if(!$files){ Write-Host "[CoNoise] none found"; exit 0 }
$missing=@()
foreach($f in $files){
try{
if($f.Extension -match "ya?ml"){
if(Get-Command ConvertFrom-Yaml -ErrorAction SilentlyContinue){
$obj = Get-Content -Raw $f.FullName | ConvertFrom-Yaml | ConvertTo-Json -Depth 20 | ConvertFrom-Json
} else { continue }
} else { $obj = Get-Content -Raw $f.FullName | ConvertFrom-Json }
foreach($k in @('budget','window','rollback_threshold')){ if($null -eq $obj.$k){ $missing += "$($f.FullName): missing $k" } }
} catch { Write-Error "Read failed $($f.FullName): $"; exit 1 }
}
if($missing){ "Missing fields:"; $missing | % { " - $" }; exit 2 }
Write-Host "[CoNoise] validated $($files.Count) file(s)"
