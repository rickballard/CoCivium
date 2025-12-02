param([Parameter(Mandatory=$true)][string]$RepoPath,[string]$SchemaPath = ".\schemas\co.trailer.schema.json")
$ErrorActionPreference='Stop'; Set-StrictMode -Version Latest
function Note($m){ Write-Host "[CoTrailer] $m" }
$schema = Get-Content -Raw -Path $SchemaPath | ConvertFrom-Json
$files = Get-ChildItem -Path $RepoPath -Recurse -File -Include *.cotrail.json,*.cotrail.yaml,*.cotrail.yml
if(!$files){ Note "No trailer files found"; exit 0 }
$missing = @()
foreach($f in $files){
  try{
    if($f.Extension -match "ya?ml"){
      if(Get-Command ConvertFrom-Yaml -ErrorAction SilentlyContinue){
        $obj = Get-Content -Raw -Path $f.FullName | ConvertFrom-Yaml | ConvertTo-Json -Depth 20 | ConvertFrom-Json
      } else { Note "Skipping YAML due to missing ConvertFrom-Yaml: $($f.FullName)"; continue }
    } else { $obj = Get-Content -Raw -Path $f.FullName | ConvertFrom-Json }
    foreach($k in $schema.required){ if($null -eq $obj.$k){ $missing += "$($f.FullName): missing '$k'" } }
  } catch { Write-Error "Failed to read $($f.FullName): $_"; exit 1 }
}
if($missing){ "Required fields missing:"; $missing | % { " - $_" }; exit 2 }
Note ("Validated {0} trailer files" -f $files.Count)
