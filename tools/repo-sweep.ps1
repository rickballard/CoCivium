param()
$ErrorActionPreference="Stop"
$ts = Get-Date -Format "yyyyMMdd_HHmmss"
$inv = "admin/history/inventory"; New-Item -ItemType Directory -Force $inv | Out-Null
$report = Join-Path $inv "REPO_SWEEP_$ts.md"

$exts = @('.md','.mdx','.markdown','.txt','.yml','.yaml','.json','.ps1','.sh')
$files = Get-ChildItem -Recurse -File | Where-Object { $exts -contains $_.Extension.ToLower() } | Sort-Object FullName

$crlf = New-Object System.Collections.Generic.List[string]
$bad  = New-Object System.Collections.Generic.List[string]
$noH1 = New-Object System.Collections.Generic.List[string]
$dupH1= New-Object System.Collections.Generic.List[string]
$badL = New-Object System.Collections.Generic.List[string]
$seen = @{}
$goodName = '^[a-z0-9][a-z0-9\-.]*$'

foreach($f in $files){
  $raw = try { Get-Content -LiteralPath $f.FullName -Raw -ErrorAction Stop } catch { "" }
  if ($null -ne $raw -and $raw -match "`r") { $crlf.Add($f.FullName) }
  if (-not ($f.Name -match $goodName)) { $bad.Add($f.FullName) }

  if ($f.Extension -in @('.md','.mdx','.markdown')){
    $m = [regex]::Match(($raw ?? ""), '^\s*#\s+(.+)$', [Text.RegularExpressions.RegexOptions]::Multiline)
    if (-not $m.Success){ $noH1.Add($f.FullName) } else {
      $h1 = $m.Groups[1].Value.Trim()
      if ($seen.ContainsKey($h1)) { $dupH1.Add("$($f.FullName)  ⇐  '$h1'") } else { $seen[$h1] = $true }
    }
    $ms = [regex]::Matches(($raw ?? ""), '(?<!\!)\[[^\]]+\]\((?<url>[^)\s]+)\)')
    foreach($x in $ms){
      $u=$x.Groups['url'].Value
      if ($u -match '^(?:https?://|mailto:|#)') { continue }
      $u2 = ($u -split '#')[0] -split '\?' | Select-Object -First 1
      if (-not $u2) { continue }
      $candidate = try {
        if ($u2.StartsWith('/')) { Join-Path $PWD $u2.TrimStart('/').Replace('/','\') }
        else { [IO.Path]::GetFullPath((Join-Path $f.DirectoryName ($u2.Replace('/','\')))) }
      } catch { $null }
      if (-not $candidate -or -not (Test-Path -LiteralPath $candidate)) { $badL.Add("$($f.FullName) → $u") }
    }
  }
}

function Sec($t,$a){ @("## $t"; if($a.Count){$a}else{"(none)"}; "") }
$lines = @("# Repo sweep ($ts)","",
"## Summary",
"- Files scanned: **$($files.Count)**",
"- CRLF lines present: **$($crlf.Count)**",
"- Bad filenames (not kebab/space/caps): **$($bad.Count)**",
"- Markdown without H1: **$($noH1.Count)**",
"- Duplicate H1 titles: **$($dupH1.Count)**",
"- Broken local links (best-effort): **$($badL.Count)**","") +
(Sec "CRLF offenders" $crlf) +
(Sec "Bad filenames"  $bad)  +
(Sec "Markdown without H1" $noH1) +
(Sec "Duplicate H1 titles" $dupH1) +
(Sec "Broken local links"  $badL)

$lf = ($lines -join "`n") -replace "`r",""
[IO.File]::WriteAllText($report,$lf,[Text.UTF8Encoding]::new($false))
Write-Host "Wrote $report"
