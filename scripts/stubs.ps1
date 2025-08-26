param(
  [switch]$Symlink,                  # try symlink; falls back to copy if unavailable
  [Parameter(ValueFromRemainingArguments=$true)][string[]]$Paths
)

# Canonical content
$CANON = "docs/_shared/STUB-EMPTY.md"
if(!(Test-Path $CANON)){ throw "Missing $CANON. Run DO-AC first." }

function Get-RepoSlug {
  $url = (git remote get-url origin) 2>$null
  if(-not $url){ return "rickballard/CoCivium" }
  if($url -match '[:/](?<owner>[^/]+)/(?<name>[^/.]+)(?:\.git)?$'){
    return "$($Matches['owner'])/$($Matches['name'])"
  }
  "rickballard/CoCivium"
}

function Write-Stub([string]$dest){
  $repoRoot = (git rev-parse --show-toplevel) 2>$null
  if(-not $repoRoot){ $repoRoot = (Resolve-Path .).Path }
  $absDest  = Join-Path $repoRoot $dest
  New-Item -ItemType Directory -Force (Split-Path $absDest) | Out-Null

  $slug = Get-RepoSlug
  $rel  = $dest -replace '\\','/'
  $issueUrl = "https://github.com/$slug/issues/new?labels=triage%3Astub-report&title=Stub%20placeholder%20found:%20$([uri]::EscapeDataString($rel))"

  if($Symlink){
    try {
      # Prefer relative link target
      $relTarget = [IO.Path]::GetRelativePath((Split-Path $absDest), (Join-Path $repoRoot $CANON))
      New-Item -Path $absDest -ItemType SymbolicLink -Value $relTarget -Force | Out-Null
      return
    } catch {
      # fall through to copy
    }
  }

  # Copy-managed with path-aware header + issue link, but content comes from canonical
  $canon = Get-Content -Raw -LiteralPath $CANON
  $header = @"
<!-- STUB:STANDARD (generated) -->
> You’re viewing a standard parked page for **$rel**  
> If this was a dead end, please report: $issueUrl

"@
  ($header + $canon) | Set-Content -LiteralPath $absDest -Encoding UTF8 -NoNewline
}

if($Paths -and $Paths.Count -gt 0){
  foreach($p in $Paths){ Write-Stub $p }
}else{
  Write-Host "Usage examples:"
  Write-Host "  pwsh -File scripts/stubs.ps1 docs/backlog/_TODO.stub.md docs/cc/_INDEX.stub.md"
  Write-Host "  pwsh -File scripts/stubs.ps1 -Symlink docs/cc/_INDEX.stub.md"
}