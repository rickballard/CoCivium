param(
  [string]$RepoRoot = ".",
  [string]$Stamp    = (Get-Date -Format "yyMMdd"),
  [int]   $WarnLines = 2000,
  [int]   $WarnFiles = 25,
  [long]  $WarnStageMB = 20
)
$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$root = (Resolve-Path $RepoRoot).Path
$indexDir = Join-Path $root 'index'
$reports  = Join-Path $root 'reports'
$icDir    = Join-Path $root ("intake\ideacards\session_{0}" -f $Stamp)
$cwDir    = Join-Path $root ("intake\cowraps\session_{0}"   -f $Stamp)
$stageRaw = Join-Path $root ("intake\staging\session_{0}\raw" -f $Stamp)
$mapPath  = Join-Path $root ("index\INTAKE_MAP_session_{0}.tsv" -f $Stamp)
$logPath  = Join-Path $reports ("BPOE_ERRORS_{0}.ndjson" -f (Get-Date -Format 'yyyyMMdd'))
$null = New-Item -ItemType Directory -Force -Path $indexDir,$reports -EA SilentlyContinue

function Sum-Lines($folder){
  if (-not (Test-Path $folder)) { return 0 }
  $files = Get-ChildItem $folder -Filter *.md -File -Recurse -EA SilentlyContinue
  ($files | ForEach-Object {
    try { (Get-Content $_.FullName -EA Stop | Measure-Object -Line).Lines } catch { 0 }
  } | Measure-Object -Sum).Sum
}

$icCount = @(Get-ChildItem $icDir -File -EA SilentlyContinue).Count
$cwCount = @(Get-ChildItem $cwDir -File -EA SilentlyContinue).Count
$mdFiles = $icCount + $cwCount
$mdLines = (Sum-Lines $icDir) + (Sum-Lines $cwDir)

$stageBytes = 0L
if (Test-Path $stageRaw){ $stageBytes = (Get-ChildItem $stageRaw -File -Recurse -EA SilentlyContinue | Measure-Object -Sum Length).Sum }
$stageMB = [math]::Round(($stageBytes / 1MB),2)

$errCount = 0
if (Test-Path $logPath){
  $errCount = (Get-Content $logPath -EA SilentlyContinue | Where-Object { $_ -match '\S' } | Measure-Object).Count
}
$mapOk = Test-Path $mapPath

$uLines = if($WarnLines   -gt 0 -and $mdLines  -gt 0){ [double]$mdLines  / [double]$WarnLines   } else { 0.0 }
$uFiles = if($WarnFiles   -gt 0){ [double]$mdFiles / [double]$WarnFiles } else { 0.0 }
$uStage = if($WarnStageMB -gt 0){ [double]$stageMB / [double]$WarnStageMB } else { 0.0 }
$util   = [math]::Max($uLines, [math]::Max($uFiles, $uStage))
$bloatPct = [int]([math]::Round([math]::Min(1.0,$util)*100,0))
$effPct   = [int]([math]::Max(0, [math]::Min(100, 100 - $bloatPct)))

# Trust read (repo-level)
$trustJson = Join-Path $indexDir 'TRUST_FLAGS.json'
$trustLevel = 'OK'
if (Test-Path $trustJson){
  try{ $trust = Get-Content $trustJson -Raw -EA Stop | ConvertFrom-Json; if($trust.level){ $trustLevel = $trust.level } }catch{}
}
$trustPart = if ($trustLevel -eq 'OK') { 'Trust~OK' } elseif ($trustLevel -eq 'DENY') { 'Trust~[DENY](index/TRUST_STATUS.md)' } else { 'Trust~[WARN](index/TRUST_STATUS.md)' }

$one = "OE Status: Efficiency~{0}% SessionBloat~{1}% ErrorCount~{2} FilesAccessed~{3} FilesIC~{4} FilesCW~{5} Stage~{6}MB Map~{7} {8}" -f `
        $effPct, $bloatPct, $errCount, $mdFiles, $icCount, $cwCount, $stageMB, ($(if($mapOk){'OK'}else{'MISSING'})), $trustPart

# JSON + one-liner at repo level
@{ ts=(Get-Date).ToString('o'); session=$Stamp;
   metrics=@{ md_files=$mdFiles; md_lines=$mdLines; stage_mb=$stageMB; ic=$icCount; cw=$cwCount; bpoe_errors=$errCount; map_exists=$mapOk };
   status=@{ efficiency=$effPct; session_bloat=$bloatPct; trust=$trustLevel } } |
  ConvertTo-Json -Depth 5 | Set-Content -Encoding UTF8 (Join-Path $indexDir 'OE_STATUS.json')
$one | Set-Content -Encoding UTF8 (Join-Path $indexDir 'OE_STATUS.md')

Write-Host $one
