param()

$ErrorActionPreference = "Stop"
$readme = Join-Path $PWD "README.md"
if (!(Test-Path $readme)) { throw "README.md not found" }

$txt = Get-Content $readme -Raw

Write-Host "== CoCivium smoke check =="
Write-Host "Repo: $PWD"
Write-Host "File: README.md"

# 1) Newlines: hard fail on CR
if ($txt -match "`r") {
  Write-Host "✗ CR characters detected; convert to LF only."
  exit 1
} else {
  Write-Host "✓ LF line endings"
}

# 2) Minimal asset references (warn only)
$crestRef = $txt -match 'assets/cc/cc-crest\.png'
$eyesRef  = $txt -match 'assets/(status|diagrams)/two-eyes\.png'

if ($crestRef) { Write-Host "✓ CC crest referenced" } else { Write-Host "⚠ CC crest not referenced" }
if ($eyesRef)  { Write-Host "✓ Two Eyes referenced" } else { Write-Host "⚠ Two Eyes not referenced" }

# 3) Key links exist (warn only)
$ideaLink  = $txt -match '\]\(https://github\.com/.+/issues/new\?template=idea\.yml\)'
$choose    = $txt -match '\]\(https://github\.com/.+/issues/new/choose\)'
$editLink  = $txt -match '\]\(https://github\.com/.+/edit/main/README\.md\)'

if ($ideaLink) { Write-Host "✓ Idea Issue link present" } else { Write-Host "⚠ Idea Issue link missing" }
if ($choose)   { Write-Host "✓ Issues/choose link present" } else { Write-Host "⚠ Issues/choose link missing" }
if ($editLink) { Write-Host "✓ Edit-this-file link present" } else { Write-Host "⚠ Edit-this-file link missing" }

# 4) BOM / mojibake quick scan (warn only)
if ($txt.Length -gt 0 -and [int]$txt[0] -eq 0xFEFF) { Write-Host "⚠ UTF-8 BOM detected (harmless, but remove if easy)" } else { Write-Host "✓ No BOM" }

Write-Host "All checks OK (warnings are informational)."
exit 0
