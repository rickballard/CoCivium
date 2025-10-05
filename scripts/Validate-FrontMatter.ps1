# scripts/Validate-FrontMatter.ps1
[CmdletBinding()]param()
Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'

function Get-RepoRoot {
  try { $t = & git rev-parse --show-toplevel 2>$null; if ($LASTEXITCODE -eq 0 -and $t){ return $t.Trim() } } catch {}
  if ($PSScriptRoot) { return (Split-Path -Parent $PSScriptRoot) }
  throw "Cannot resolve repo root."
}

$root = Get-RepoRoot
$insights = Join-Path $root 'insights'
if (-not (Test-Path $insights)) { Write-Host "No /insights folder. Nothing to validate."; exit 0 }

$errors = New-Object System.Collections.Generic.List[string]
$files  = Get-ChildItem $insights -Filter '*.md' -Recurse

foreach ($f in $files) {
  $text = Get-Content $f.FullName -Raw
  if ($text -notmatch '^\s*---\s*([\s\S]*?)\s*---') { $errors.Add("No front-matter: $($f.FullName)"); continue }
  $fmRaw = $Matches[1]

  foreach ($key in @('title','pair','categories','status','human_touch','summary')) {
    if ($fmRaw -notmatch "(?m)^\s*$([regex]::Escape($key))\s*:") { $errors.Add("Missing $key in $($f.Name)") }
  }

  $mPair = [regex]::Match($fmRaw, '(?m)^\s*pair\s*:\s*([^\r\n#]+)')
  if ($mPair.Success) {
    $pair = $mPair.Groups[1].Value.Trim().ToLower()
    if (@('theory','practice') -notcontains $pair) { $errors.Add("Bad pair in $($f.Name): $pair") }
  } else { $errors.Add("Missing pair in $($f.Name)") }

  $mHt = [regex]::Match($fmRaw, '(?m)^\s*human_touch\s*:\s*([^\r\n#]+)')
  if ($mHt.Success) {
    $ht = $mHt.Groups[1].Value.Trim().ToLower()
    if (@('true','false') -notcontains $ht) { $errors.Add("human_touch must be true|false in $($f.Name)") }
  } else { $errors.Add("Missing human_touch in $($f.Name)") }
}

if ($errors.Count) { $errors | ForEach-Object { Write-Error $_ }; exit 1 }
Write-Host "Front-matter looks good on $($files.Count) insight file(s)."
