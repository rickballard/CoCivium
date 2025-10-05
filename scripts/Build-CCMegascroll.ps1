[CmdletBinding()]
param(
  [string]$Root,
  [string]$PartsRel   = 'frameworks/CC-Scroll.parts',
  [string]$OutMdRel   = 'frameworks/CC-Scroll.megascroll.md',
  [string]$OutHtmlRel = 'site-human/assets/cc-scroll.html'
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

function Resolve-RepoRoot {
  param([string]$ProvidedRoot)
  if ($ProvidedRoot) { return (Resolve-Path $ProvidedRoot).Path }
  if ($PSScriptRoot) { try { return (Split-Path -Parent $PSScriptRoot) } catch {} }
  try {
    $gitTop = & git rev-parse --show-toplevel 2>$null
    if ($LASTEXITCODE -eq 0 -and $gitTop) { return $gitTop.Trim() }
  } catch {}
  $fallback = Join-Path $env:USERPROFILE 'Documents/GitHub/CoCivium'
  if (Test-Path $fallback) { return $fallback }
  throw "Cannot determine repo root. Pass -Root explicitly."
}

$root     = Resolve-RepoRoot -ProvidedRoot $Root
$partsDir = Join-Path $root $PartsRel
$outMd    = Join-Path $root $OutMdRel
$outHtml  = Join-Path $root $OutHtmlRel

# Ensure output dirs exist
$null = New-Item -ItemType Directory -Force -Path (Split-Path $outMd)   | Out-Null
$null = New-Item -ItemType Directory -Force -Path (Split-Path $outHtml) | Out-Null

# Bootstrap parts dir if missing
if (-not (Test-Path $partsDir)) {
  New-Item -ItemType Directory -Force -Path $partsDir | Out-Null
  @"
# CC Scroll — Intro
This is a bootstrap placeholder. Replace files in **$($PartsRel)** with your real sections,
named like `01-Intro.md`, `02-Values.md`, `03-Operating-Framework.md`, etc.
"@ | Set-Content (Join-Path $partsDir '01-Intro.md') -Encoding UTF8
}

# Pull parts (array-wrap so .Count always exists)
$parts = @(Get-ChildItem $partsDir -Filter '*.md' | Sort-Object Name)
if ($parts.Count -eq 0) { throw "No CC parts (*.md) found in $partsDir" }

# Header
$header = @"
---
title: "Cognocarta Consenti — Megascroll"
version: 0.1
generated: $(Get-Date -Format s)
---
<!-- AUTO-GENERATED: Do not edit directly. See /$PartsRel -->
# Cognocarta Consenti (CC) — Megascroll

"@

# Concatenate with section dividers
$bodyBlocks = foreach ($p in $parts) {
  "# [$($p.BaseName)]`n" + (Get-Content $p.FullName -Raw) + "`n`n---`n"
}
$megascroll = $header + ($bodyBlocks -join "`n")
Set-Content -Path $outMd -Value $megascroll -Encoding UTF8

# Simple HTML wrapper (pre + glow)
$encoded = [System.Net.WebUtility]::HtmlEncode((Get-Content $outMd -Raw))
$html = @"
<!doctype html><meta charset="utf-8">
<title>Cognocarta Consenti — Megascroll</title>
<style>
 body{margin:2rem auto;max-width:900px;line-height:1.6;font:16px/1.6 system-ui,Segoe UI,Arial}
 .scroll{background:#0b0b10;color:#e7e7ff;padding:2rem;border-radius:18px;box-shadow:0 0 40px #8ea2ff55}
 .scroll h1,.scroll h2,.scroll h3{color:#cfd6ff;text-shadow:0 0 10px #7f8cff55}
 .scroll hr{border:0;border-top:1px solid #333;margin:2rem 0}
 a{color:#a8b5ff}
 pre{white-space:pre-wrap}
</style>
<div class="scroll"><pre>$encoded</pre></div>
"@
Set-Content -Path $outHtml -Value $html -Encoding UTF8

Write-Host "Megascroll built:"
Write-Host " - $outMd"
Write-Host " - $outHtml"
