param(
    [string]$TagFilter = "CoCivia"
)

$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

function UTS {
    (Get-Date).ToUniversalTime().ToString("yyyyMMddTHHmmssZ")
}

$repo = Split-Path $PSScriptRoot -Parent
Set-Location $repo

$notesRoot     = Join-Path $repo "docs/intent/advice/notes"
$heartbeatRoot = Join-Path $repo "docs/intent/advice/heartbeat/CoCivia"

if(-not (Test-Path $heartbeatRoot)){
    New-Item -ItemType Directory -Path $heartbeatRoot | Out-Null
}

# 1) Recent CoSync notes that mention CoCivia
$recentNotes = @()
if(Test-Path $notesRoot){
    $recentNotes = Get-ChildItem -Path $notesRoot -Recurse -File -Filter "CoSync_CoCivia*.md" |
        Sort-Object LastWriteTime -Descending |
        Select-Object -First 5
}

# 2) Optional: CoCivia related PRs (if gh is configured)
$prInfo = $null
try{
    $json = gh pr list `
        --repo rickballard/CoCivium `
        --search $TagFilter `
        --json number,title,url `
        --state open
    if($json){
        $prInfo = $json | ConvertFrom-Json
    }
} catch {
    # gh not available or not configured; skip
}

$ts = UTS
$hbFile = Join-Path $heartbeatRoot ("Heartbeat_{0}.md" -f $ts)

$lines = @()
$lines += "# CoCivia Heartbeat"
$lines += ""
$lines += "UTC      : $ts"
$lines += "Source   : tools/CoCiviaHeartbeat.ps1"
$lines += ""
$lines += "## Recent CoSync_CoCivia* notes"
if($recentNotes -and $recentNotes.Count -gt 0){
    foreach($n in $recentNotes){
        $rel = $n.FullName.Replace($repo, "").TrimStart("\","/")
        $lines += "- $rel  (LastWrite: $($n.LastWriteTime.ToString("s"))) "
    }
} else {
    $lines += "- None found yet."
}

$lines += ""
$lines += "## Open CoCivia related PRs (search: `$TagFilter` in CoCivium)"
if($prInfo -and $prInfo.Count -gt 0){
    foreach($p in $prInfo){
        $lines += "- PR #$($p.number): $($p.title)"
        $lines += "  $($p.url)"
    }
} else {
    $lines += "- None found or gh not configured."
}

$lines += ""
$lines += "## Suggested next intents for Co1"
$lines += ""
$lines += "- Consider a CoCivia evolution session if no recent CoSync_CoCivia notes exist."
$lines += "- If there is a `RESTSeedDeferred` outcome in recent notes, propose a"
$lines += "  CoCiviaREST session to add and document /api/portal/meta."
$lines += "- If new CoPortal standards land, align CoCiviaCoPortal spec and worker with them."
$lines += ""
$lines += "## CoStatus"
$lines += ""
$lines += "CoStatus [Bus:CoCiviaHeartbeat][Outcome:NudgeCo1IfOpened]"

$lines -join "`r`n" | Out-File -FilePath $hbFile -Encoding UTF8

Write-Host "Heartbeat written to: $hbFile"
