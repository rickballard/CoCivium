param(
  [string]$CoCache,
  [string]$Stamp
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$today     = Get-Date -Format 'yyyy-MM-dd'
$datedPref = (Get-Date -Format 'yyyyMMdd') + '_'

# Paths
$intakeRoot = Join-Path $CoCache 'intake'
$icDir      = Join-Path $intakeRoot ("ideacards\session_{0}" -f $Stamp)
$cwDir      = Join-Path $intakeRoot ("cowraps\session_{0}" -f $Stamp)
$stageRaw   = Join-Path $intakeRoot ("staging\session_{0}\raw" -f $Stamp)
$attachDir  = Join-Path $intakeRoot ("attachments\session_{0}" -f $Stamp)
$idxDir     = Join-Path $CoCache 'index'
$reportDir  = Join-Path $CoCache 'reports'
$null = New-Item -ItemType Directory -Force -Path $icDir,$cwDir,$attachDir,$idxDir,$reportDir | Out-Null

# BPOE logging
$BpoeErrPath = Join-Path $reportDir ("BPOE_ERRORS_{0}.ndjson" -f (Get-Date -Format 'yyyyMMdd'))
function Write-BpoeError {
  param([string]$Stage,[string]$Item,[Parameter(ValueFromPipeline)]$Err)
  try {
    $e = if ($Err -is [System.Management.Automation.ErrorRecord]) { $Err } else { $_ }
    $obj = [ordered]@{
      ts=(Get-Date).ToString("o"); stage=$Stage; item=$Item
      message=$e.Exception.Message; category=$e.CategoryInfo.Category; target=$e.CategoryInfo.TargetName
      script=$e.InvocationInfo.ScriptName; line=$e.InvocationInfo.ScriptLineNumber
      psver=$PSVersionTable.PSVersion.ToString(); cwd=(Get-Location).Path
    }
    ($obj | ConvertTo-Json -Compress) + "`n" | Add-Content -Encoding UTF8 $BpoeErrPath
  } catch {}
}

# Guards
if (-not (Test-Path $stageRaw)) { throw "Staging missing: $stageRaw" }
$allFiles = Get-ChildItem -Path $stageRaw -Recurse -File
if (-not $allFiles) { throw "No files under $stageRaw" }

# Clean only today's normalized outputs
$todayMask = "${datedPref}*.md"
Get-ChildItem $icDir -File -Filter $todayMask -EA SilentlyContinue | Remove-Item -Force -EA SilentlyContinue
Get-ChildItem $cwDir -File -Filter $todayMask -EA SilentlyContinue | Remove-Item -Force -EA SilentlyContinue

# Utils
function New-Slug($s){
  $t = ($s -replace '[^\p{L}\p{Nd}]+' , '-').ToLower()
  $t = ($t -replace '-+','-').Trim('-')
  if($t.Length -gt 60){ $t = $t.Substring(0,[Math]::Min(60,$t.Length)).Trim('-') }
  return $t
}
function Has-FrontMatter($text){ $text -match '^(?s)\A---\s*.*?\s---\s*' }
function Get-FirstHeading($text){ foreach($line in $text -split "`n"){ if($line -match '^\s*#\s+(.+)$'){ return $Matches[1].Trim() } } return $null }
function Classify-ByName($name){
  $n=$name.ToLower()
  if($n -like 'cowrap*' -or $n -match '(?:^|_)cowrap' -or $n -match '(^|_)wrap($|_)'){return 'cowrap'}
  if($n -match '(^|_)plan($|_)' -or $n -like '*_plan_*'){return 'cowrap'}
  if($n -like 'ideacard*'){return 'ideacard'}
  return 'ideacard'
}

$rows = [System.Collections.Generic.List[string]]::new()
$cards=0; $cwraps=0; $uncls=0

foreach($file in $allFiles){
  try{
    $src = $file.FullName
    $ext = $file.Extension.ToLower()

    # Assets/binaries
    if($ext -in '.png','.jpg','.jpeg','.gif','.pdf'){
      Copy-Item -Path $src -Destination $attachDir -Force
      $rows.Add(("asset`t{0}`t{1}`t{2}" -f $file.Name,$src,(Join-Path $attachDir $file.Name)))
      continue
    }

    # ODT/DOCX -> wrapper MD with link to attachment
    if($ext -in '.odt','.docx'){
      $kind  = Classify-ByName $file.Name
      Copy-Item -Path $src -Destination $attachDir -Force
      $title = [IO.Path]::GetFileNameWithoutExtension($file.Name)
      $slug  = New-Slug $title
      $dest  = if($kind -eq 'cowrap'){ Join-Path $cwDir ("${datedPref}${slug}.md") } else { Join-Path $icDir ("${datedPref}${slug}.md") }

      $front = @(
        '---',
        ('id: "{0}"'       -f $slug),
        ('title: "{0}"'    -f ($title -replace '"','\"')),
        'status: seed',
        ('category: "{0}"' -f $kind),
        'tags: []',
        'priority: normal',
        'owner: rick',
        ('created: {0}'    -f $today),
        ('source: "CardsWraps.zip/session_{0}"' -f $Stamp),
        '---', '', 
        ('> Attachment captured from zip. See: `../attachments/session_{0}/{1}`' -f $Stamp, $file.Name)
      ) -join "`n"
      $front | Set-Content -Encoding UTF8 $dest

      if($kind -eq 'cowrap'){$cwraps++}else{$cards++}
      $rows.Add(("{0}`t{1}`t{2}`t{3}" -f $kind,$file.Name,$src,$dest))
      continue
    }

    # MD/TXT -> normalize with front matter (no nested here-strings)
    if($ext -in '.md','.txt'){
      $raw   = Get-Content $src -Raw
      $kind  = Classify-ByName $file.Name
      $title = Get-FirstHeading $raw; if(-not $title){ $title = [IO.Path]::GetFileNameWithoutExtension($file.Name) }
      $slug  = New-Slug $title
      $dest  = if($kind -eq 'cowrap'){ Join-Path $cwDir ("${datedPref}${slug}.md") } else { Join-Path $icDir ("${datedPref}${slug}.md") }

      if(Has-FrontMatter $raw){
        $raw | Set-Content -Encoding UTF8 $dest
      } else {
        if($kind -eq 'cowrap'){
          $front = @(
            '---',
            'session: "Grand Migration Cleanup"',
            ('date: {0}' -f $today),
            'summary: ""','outcomes: []','open_items: []','next_session_hint: ""',
            '---', '', ('# {0}' -f $title), '', $raw
          ) -join "`n"
          $front | Set-Content -Encoding UTF8 $dest
        } else {
          $front = @(
            '---',
            ('id: "{0}"' -f $slug),
            ('title: "{0}"' -f ($title -replace '"','\"')),
            'status: seed','category: "ideacard"','tags: []','priority: normal','owner: rick',
            ('created: {0}' -f $today),
            ('source: "CardsWraps.zip/session_{0}"' -f $Stamp),
            '---','', $raw
          ) -join "`n"
          $front | Set-Content -Encoding UTF8 $dest
        }
      }

      if($kind -eq 'cowrap'){$cwraps++}else{$cards++}
      $rows.Add(("{0}`t{1}`t{2}`t{3}" -f $kind,$file.Name,$src,$dest))
      continue
    }

    # Unknown → stash
    Copy-Item -Path $src -Destination $attachDir -Force
    $rows.Add(("unknown`t{0}`t{1}`t{2}" -f $file.Name,$src,(Join-Path $attachDir $file.Name))); $uncls++
  }
  catch { $_ | Write-BpoeError -Stage "normalize-item" -Item $file.FullName }
}

$mapPath = Join-Path $idxDir ("INTAKE_MAP_session_{0}.tsv" -f $Stamp)
"category`tname`tfrom`tto" | Set-Content -Encoding UTF8 $mapPath
$rows | Add-Content -Encoding UTF8 $mapPath

Write-Host ("Normalized: {0} IdeaCards, {1} CoWraps, {2} unknowns/assets." -f $cards,$cwraps,$uncls)
Write-Host ("Index: {0}" -f $mapPath)
Write-Host ("BPOE log: {0}" -f $BpoeErrPath)
