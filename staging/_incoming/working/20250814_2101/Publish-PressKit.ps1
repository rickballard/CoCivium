# Publish-PressKit.ps1 — create a press release from a template + config, then draft Outlook emails
# Usage:
#   pwsh ./Publish-PressKit.ps1 -RepoDir "$HOME\Documents\GitHub\CoCivium" -Branch "campaign/press-kit-v0-YYYYMMDD" -DryRun
param(
  [string]$RepoDir = "$HOME\Documents\GitHub\CoCivium",
  [string]$Branch  = "campaign/press-kit-v0",
  [string]$TemplatePath = "$HOME\Downloads\PressRelease_Template.md",
  [string]$ConfigPath   = "$HOME\Downloads\PressRelease_Config.yaml",
  [string]$MediaCsv     = "$HOME\Downloads\Media_List.csv",
  [switch]$DryRun
)

Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'

function Read-KeyValues([string]$path){
  $map = @{}; Get-Content -LiteralPath $path | ForEach-Object {
    if ($_ -match '^\s*#') { return }
    if ($_ -match '^\s*$') { return }
    if ($_ -match '^\s*([^:]+)\s*:\s*(.*)$') {
      $k=$matches[1].Trim(); $v=$matches[2].Trim()
      $map[$k]=$v
    }
  }; return $map
}

if(!(Test-Path $TemplatePath)){ throw "Missing template: $TemplatePath" }
if(!(Test-Path $ConfigPath)){ throw "Missing config: $ConfigPath" }
$kv = Read-KeyValues $ConfigPath
$content = Get-Content -LiteralPath $TemplatePath -Raw
$kv.GetEnumerator() | ForEach-Object {
  $token = '{{' + $_.Key + '}}'
  $content = $content -replace [regex]::Escape($token), [regex]::Escape($_.Value).Replace('\','\\')
}

# Write into repo
$OutDir = Join-Path $RepoDir "docs\press"
New-Item -ItemType Directory -Path $OutDir -Force | Out-Null
$fname = ($kv['TITLE'] -replace '[^\w\- ]','').Trim().Replace(' ','-') + ".md"
$OutFile = Join-Path $OutDir $fname
Set-Content -LiteralPath $OutFile -Value $content -NoNewline

# Commit on a campaign branch
Push-Location $RepoDir
git fetch origin --prune | Out-Null
git switch -c $Branch origin/main 2>$null || git switch -c $Branch
git add $OutFile
git commit -m "feat(press): add press release draft '$($kv['TITLE'])'" | Out-Null
git push -u origin $Branch
$pr = gh pr create --fill --title "Press kit: $($kv['TITLE'])" --label "content" 2>$null

Write-Host "Press release saved at: $OutFile"
if($pr){ Write-Host "PR opened:`n$pr" } else { Write-Host "PR already exists or could not auto-open." }

# Draft Outlook emails (optional)
if(Test-Path $MediaCsv){
  try{
    $rows = Import-Csv -LiteralPath $MediaCsv
    $ol = New-Object -ComObject Outlook.Application
    foreach($r in $rows){
      $mail = $ol.CreateItem(0)
      $mail.To = $r.Email
      $mail.Subject = "Press: " + $kv['TITLE']
      $body = @"
Hi $($r.Name),

Quick pitch from CoCivium (consent-first governance for agentic AI).  We’re releasing: $($kv['SUMMARY'])

Why now: $($kv['WHY_IT_MATTERS'])

Press notes + full release: $($kv['LINK_PRESS_KIT'])
Happy to brief or join a panel.

— Rick Ballard
Oakville, ON
$($kv['PRESS_EMAIL'])
"@
      $mail.Body = $body
      $mail.Display() | Out-Null
    }
  } catch {
    Write-Warning "Outlook draft generation skipped: $($_.Exception.Message)"
  }
} else {
  Write-Warning "Media CSV not found at $MediaCsv — skipping drafts."
}
Pop-Location