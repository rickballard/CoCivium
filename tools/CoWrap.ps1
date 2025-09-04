param(
  [string]$Note = "",
  [string[]]$RepoDirs = @(
    "$HOME\Documents\GitHub\CoCivium",
    "$HOME\Documents\GitHub\CoCache",
    "$HOME\Documents\GitHub\CoModules"
  ),
  [string]$Downloads = (Join-Path $HOME "Downloads"),
  [string[]]$Patterns = @(
    "*HANDOFF*.zip","*CoWrap*.zip","*cowrap*.zip",
    "RickPad*.odt","RickPad*.md","*IdeaCard*.md",
    "*Migration*Resume*.md","*Session*Resume*.md",
    "CoAgentKit*.zip","*handoff*.zip"
  ),
  [switch]$ExpandZips,
  [switch]$Push,
  [switch]$OpenPR
)
Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'
$ts = Get-Date -Format 'yyyyMMdd_HHmm'
$work = Join-Path $env:TEMP "CoWrap_$ts"
$payload = Join-Path $work 'payload'
$reports = Join-Path $work 'reports'
$unpacked = Join-Path $work 'unpacked'
New-Item -ItemType Directory -Force -Path $payload,$reports,$unpacked | Out-Null

# 1) Sweep Downloads
$dlFiles = @()
if(Test-Path $Downloads){
  $dlFiles = Get-ChildItem $Downloads -File -Recurse -EA SilentlyContinue |
    Where-Object { $Patterns | ForEach-Object { $_ } | ForEach-Object { $name=$_.ToString(); if($PSItem.Name -like $name){ $true } } }
  foreach($f in $dlFiles){ Copy-Item $f.FullName -Destination $payload -Force }
}

# 2) Repo reports
function Add-RepoReport([string]$dir){
  if(!(Test-Path $dir)){ return }
  Push-Location $dir
  try{
    $root = (git rev-parse --show-toplevel 2>$null)
    if(!$root){ return }
    $name = Split-Path $root -Leaf
    $out = Join-Path $reports ("{0}_git.txt" -f $name)
    $sb = New-Object System.Text.StringBuilder
    $null = $sb.AppendLine("== $name @ $root ==")
    $null = $sb.AppendLine((git remote -v 2>$null))
    $null = $sb.AppendLine("---- status -sb ----")
    $null = $sb.AppendLine((git status -sb 2>$null))
    $null = $sb.AppendLine("---- last 20 ----")
    $null = $sb.AppendLine((git --no-pager log --oneline -n 20 2>$null))
    $null = $sb.AppendLine("---- untracked ----")
    $null = $sb.AppendLine((git ls-files --others --exclude-standard 2>$null))
    $null = $sb.AppendLine("---- open PRs (top 30) ----")
    $gh = (Get-Command gh -EA SilentlyContinue)
    if($gh){ $null = $sb.AppendLine((gh pr list --state open --limit 30 2>$null)) }
    [IO.File]::WriteAllText($out, $sb.ToString())
  } finally { Pop-Location }
}

$RepoDirs | ForEach-Object { Add-RepoReport $_ }

# 3) Optional unzip of handoffs
if($ExpandZips){
  Get-ChildItem $payload -Filter *.zip -File -EA SilentlyContinue | ForEach-Object {
    $dest = Join-Path $unpacked ($_.BaseName)
    New-Item -ItemType Directory -Force -Path $dest | Out-Null
    Expand-Archive -LiteralPath $_.FullName -DestinationPath $dest -Force
  }
}

# 4) Summary + manifest
$summary = @()
$summary += "# CoWrap Summary ($ts)"
$summary += ""
$summary += "- Note: $Note"
$summary += "- Downloads swept: $Downloads"
$summary += "- Patterns: " + ($Patterns -join ', ')
$summary += "- Files copied: {0}" -f $dlFiles.Count
$summary += "- Repo reports: " + ((Get-ChildItem $reports -File -EA SilentlyContinue).Count)
$summary += "- PS: $($PSVersionTable.PSVersion)"
$summary += ""
$sumPath = Join-Path $work "SUMMARY.md"
$summary -join "`n" | Set-Content -Encoding UTF8 $sumPath

$manifest = [ordered]@{
  timestamp = $ts
  note = $Note
  downloads = $Downloads
  patterns = $Patterns
  files = $dlFiles | ForEach-Object { $_.FullName }
  repos  = $RepoDirs
  machine = $env:COMPUTERNAME
  user = $env:UserName
  ps = $PSVersionTable.PSVersion.ToString()
}
$manPath = Join-Path $work "MANIFEST.json"
$manifest | ConvertTo-Json -Depth 5 | Set-Content -Encoding UTF8 $manPath

# 5) Zip into CoCache/handoffs
$OutRepo = "$HOME\Documents\GitHub\CoCache"
$OutDir  = Join-Path $OutRepo "handoffs"
New-Item -ItemType Directory -Force -Path $OutDir | Out-Null
$zipName = "CoWrap_$ts.zip"
$zipPath = Join-Path $OutDir $zipName
if(Test-Path $zipPath){ Remove-Item $zipPath -Force }
Compress-Archive -Path (Join-Path $work '*') -DestinationPath $zipPath -Force

Write-Host "CoWrap bundle: $zipPath"

# 6) Optional commit/push/PR
if($Push){
  Push-Location $OutRepo
  try{
    git fetch origin | Out-Null
    $branch = "handoff/cowrap-$ts"
    git switch -C $branch | Out-Null
    git add "handoffs/$zipName"
    git commit -m "CoWrap: session handoff ($ts) — $Note" | Out-Null
    git push -u origin HEAD | Out-Null
    if($OpenPR){
      $title = "CoWrap handoff $ts — $Note"
      gh pr create --title $title --body "Automated CoWrap bundle: $zipName" 2>$null | Out-Null
    }
  } finally { Pop-Location }
}
