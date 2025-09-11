param([int]$MinBytes = 500)
$targets = @("insights","codex","consent","intent","resolution","ethos","identity",
             "discussions","amendments","domains","seed","lexicon","projects")
$rows = @()
foreach($t in $targets){
  if (-not (Test-Path $t)) { continue }
  $files = Get-ChildItem $t -Recurse -File -Include *.md,*.mdx -ErrorAction SilentlyContinue
  foreach($f in $files){
    $raw = Get-Content $f.FullName -Raw
    $bytes = [Text.Encoding]::UTF8.GetByteCount($raw)
    $isStub = ($bytes -lt $MinBytes) -or ($raw -match '(?i)\b(TODO|TBD|WIP|stub|draft)\b')
    if ($isStub) { $rows += [pscustomobject]@{ path=$f.FullName; bytes=$bytes } }
  }
}
$rows = $rows | Sort-Object bytes
$lines = @("# Stub report — $(Get-Date -Format yyyy-MM-dd)","")
if ($rows.Count -eq 0) {
  $lines += "No stubs detected 🎉"
} else {
  $lines += "| bytes | path |"
  $lines += "|------:|------|"
  foreach($r in $rows){
    $rel = $r.path.Replace((Resolve-Path .).Path,'').TrimStart('\','/')
    $lines += ("| {0} | {1} |" -f $r.bytes, $rel)
  }
}
New-Item -ItemType Directory -Force notes | Out-Null
Set-Content notes/stub_report.md ($lines -join "`r`n") -Encoding UTF8
