param(
  [Parameter(Mandatory=$true)][string]$Path,
  [Parameter(Mandatory=$true)][string]$Key,
  [Parameter(Mandatory=$true)][string]$Content,
  [string]$Header = "# BPOE (Best Practices of Execution)",
  [switch]$NoGit
)
$ErrorActionPreference='Stop'; Set-StrictMode -Version Latest
$nl = [Environment]::NewLine
$begin = "<!-- BEGIN:$Key -->"
$end   = "<!-- END:$Key -->"
$dir = Split-Path $Path
if ($dir -and -not (Test-Path $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
if (!(Test-Path $Path)) { Set-Content -Path $Path -Value ($Header + $nl + $nl) -Encoding UTF8 }

$content = Get-Content -Raw $Path
$pattern = "(?s)<!-- BEGIN:$([regex]::Escape($Key)) -->.*?<!-- END:$([regex]::Escape($Key)) -->"
if ($content -match $pattern) { $content = [regex]::Replace($content, $pattern, '').TrimEnd() + $nl }
if ($content -notmatch '^\s*#\s+BPOE') { $content = $Header + $nl + $nl + $content }

$final = ($content.TrimEnd() + $nl + $begin + $nl + $Content + $nl + $end + $nl)

$current = Get-Content -Raw $Path
if ($current -ne $final) {
  Set-Content -Path $Path -Value $final -Encoding UTF8
  if (-not $NoGit) {
    if (git rev-parse --is-inside-work-tree 2>$null) {
      git add -- $Path | Out-Null
      git commit -m ("BPOE: ensure block '{0}' in {1}" -f $Key, $Path) | Out-Null
      try { git push | Out-Null } catch {}
    }
  }
  Write-Host ("Updated {0} [{1}]" -f $Path, $Key) -ForegroundColor Green
} else {
  Write-Host ("No change to {0} [{1}]" -f $Path, $Key) -ForegroundColor Green
}
