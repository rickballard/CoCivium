param([Parameter(Mandatory=$true)][string]$Title)

$utc = (Get-Date).ToUniversalTime()
$stamp = $utc.ToString("yyyyMMdd-HHmm") + "Z"
$slug  = ($Title -replace "[^\w\- ]","" -replace "\s+","-").ToLower()
$path  = "docs/ideas/$stamp-$slug.md"

$content = @"
---
title: $Title
status: draft
impact: med
effort: M
tags: []
created: $($utc.ToString("yyyy-MM-ddTHH:mmZ"))
---

One-liner.

## Rationale

## Sketch

## Next step
"@

New-Item -ItemType Directory -Force -Path docs/ideas | Out-Null
Set-Content -Encoding UTF8 -NoNewline -Path $path -Value $content
Write-Output "Created $path"