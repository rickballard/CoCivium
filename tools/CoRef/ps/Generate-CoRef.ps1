param(
  [Parameter(Mandatory=$true)] [string]$Path,            # Markdown file
  [Parameter(Mandatory=$true)] [string]$DocId = "FD:faiths-in-dialogue",
  [Parameter(Mandatory=$true)] [string]$Namespace = "FD",
  [Parameter(Mandatory=$false)] [string]$OutMap = ""
)
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

if (-not $OutMap) { $OutMap = [System.IO.Path]::ChangeExtension($Path, ".coref.json") }

function Get-Canonical([string]$text) {
  $t = $text.ToLowerInvariant()
  $t = [regex]::Replace($t, '\s+', ' ')
  $t = $t.Trim()
  return $t
}
function Hash4([string]$text) {
  $bytes = [System.Text.Encoding]::UTF8.GetBytes($text)
  $sha = [System.Security.Cryptography.SHA256]::Create()
  $h = $sha.ComputeHash($bytes)
  $alphabet = "0123456789ABCDEFGHJKMNPQRSTVWXYZ"
  $val = 0; $bits = 0; $out = New-Object System.Text.StringBuilder
  foreach ($b in $h) {
    $val = ($val -band 0) + $b
    $bits += 8
    while ($bits -ge 5) {
      $bits -= 5
      $idx = ($val -shr $bits) -band 31
      [void]$out.Append($alphabet[$idx])
      $val = $val -band ((1 -shl $bits) - 1)
    }
  }
  $s = $out.ToString()
  return $s.Substring(0,4)
}

$raw = Get-Content -Raw -Path $Path
$lines = $raw -split "`n"
$entries = @()
$path = ""
$pIndex = 0

foreach ($line in $lines) {
  if ($line -match '^\s*#{1,6}\s+(.*)') {
    $title = $Matches[1].Trim()
    if ($title -match '^(\d+(\.\d+)*)\s+') { $path = $Matches[1] }
    $pIndex = 0
    continue
  }
  if ($line.Trim().Length -eq 0) { continue }
  $pIndex += 1
  $canon = Get-Canonical $line
  $h4 = Hash4 $canon
  $entries += @{
    path = $path
    anchor = "p$($pIndex)"
    hash = $h4
    v = "A"
    label = ($line.Substring(0, [Math]::Min(64, $line.Length))).Trim()
    concepts = @()
  }
}

$out = @{
  doc = $DocId.Split(':')[-1]
  system = "CoRef"
  ns = $Namespace
  version = "0.1"
  entries = $entries
  aliases = @{}
}

$out | ConvertTo-Json -Depth 6 | Set-Content -Path $OutMap -Encoding UTF8
Write-Host "CoRef map written to $OutMap"
