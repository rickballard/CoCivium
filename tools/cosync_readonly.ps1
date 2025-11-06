param()

$ErrorActionPreference='Stop'
$GH   = Join-Path $HOME 'Documents\GitHub'
$Roots= @('CoCivium','CoCache','CoSteward','CoContrib') | % { Join-Path $GH $_ } | ? { Test-Path $_ }
foreach($r in $Roots){ git -C $r switch main *> $null; git -C $r pull --ff-only *> $null }

$Civ  = Join-Path $GH 'CoCivium'
$UTC  = (Get-Date).ToUniversalTime().ToString('yyyyMMdd-HHmmssZ')
$Day  = Get-Date -Format 'yyyyMMdd'
$NoteD= Join-Path $Civ "docs/intent/advice/notes/$Day"
$RptD = Join-Path $Civ "docs/reports"
$null = New-Item -ItemType Directory -Force -Path $NoteD,$RptD

# basic checks
$checks = [System.Collections.Generic.List[object]]::new()
function Add-Check($name,$ok,$info){ $checks.Add([pscustomobject]@{Name=$name;OK=[bool]$ok;Info=$info}) }
$mustExist = @(
  @{ Repo='CoCivium'; Path='docs/MEGASCROLLS.md' },
  @{ Repo='CoCivium'; Path='docs/index/README.md' },
  @{ Repo='CoCache' ; Path='advice/inbox/INBOX_LOG.md' }
)
foreach($m in $mustExist){ $p = Join-Path (Join-Path $GH $m.Repo) $m.Path; Add-Check "exists:$($m.Repo)/$($m.Path)" (Test-Path $p) $p }

# helpers index (CoCivium only)
$hits = foreach($g in @('tools\*.ps1','tools\*.psm1','scripts\*.ps1','.github\workflows\*.yml','.github\workflows\*.yaml')){
  Get-ChildItem -Path $Civ -Recurse -File -Include $g -ErrorAction SilentlyContinue | ? FullName -NotMatch '\\\.git\\'
}
$lines=@('# Helpers index','','| Kind | Path |','|---|---|')
foreach($h in $hits){
  $kind= if($h.Extension -in '.yml','.yaml'){ 'workflow' } elseif($h.Extension -eq '.psm1'){ 'module' } else { 'script' }
  $rel = $h.FullName.Replace((Resolve-Path $Civ).Path + [IO.Path]::DirectorySeparatorChar,'')
  $lines += "| $kind | ./$rel |"
}
$helpersIdx = Join-Path $Civ 'docs/index/HELPERS_INDEX.md'
($lines -join "`r`n") + "`r`n" | Set-Content -Encoding utf8NoBOM $helpersIdx

# thin stubs (CoCivium/docs)
function Get-WordCount([string]$s){ (($s -replace '\s+',' ' -replace '[^A-Za-z0-9 ]',' ').Trim() -split ' ').Where({$_}).Count }
$docs = Get-ChildItem (Join-Path $Civ 'docs') -Recurse -Include *.md | ? FullName -NotMatch '\\docs\\archive\\'
$stubFindings = [System.Collections.Generic.List[object]]::new()
$smells = @('tbd','todo','wip','stub','coming soon','placeholder')
foreach($f in $docs){
  $raw = Get-Content $f.FullName -Raw
  $noCode = [regex]::Replace($raw,'```.*?```','', 'Singleline')
  $wc = Get-WordCount $noCode
  $hasSmell = $false; foreach($s in $smells){ if($noCode -match "(?i)\b$s\b"){ $hasSmell=$true; break } }
  $lines = $noCode -split "`r?`n"
  $prose = $lines | ? { $_ -notmatch '^\s*(#|\-|\*|\d+\.|\>|\|)' -and $_ -match '\w' }
  $lowProse = ($prose.Count -lt 3)
  if($wc -lt 120 -or $hasSmell -or $lowProse){
    $rel = $f.FullName.Replace((Resolve-Path $Civ).Path + [IO.Path]::DirectorySeparatorChar,'')
    $stubFindings.Add([pscustomobject]@{ File=$rel; Words=$wc; Smell=$hasSmell; LowProse=$lowProse })
  }
}
$stubCsv = Join-Path $RptD "stub_candidates_$UTC.csv"
$stubFindings | Export-Csv -NoTypeInformation -Encoding UTF8 $stubCsv
Add-Check "thin-stub-candidates" ($stubFindings.Count -eq 0) "$($stubFindings.Count) found"

# reinvention (light)
function Tok([string]$s){ (($s.ToLower() -replace '(?m)^\s*#.*$','') -replace '[^a-z0-9_\.\/\- ]',' ' -replace '\s+',' ').Split(' ') | ? { $_.Length -ge 3 } }
function Jac($A,$B){
  if(-not $A -or -not $B){ return 0.0 }
  $a=[System.Collections.Generic.HashSet[string]]::new(); $b=[System.Collections.Generic.HashSet[string]]::new()
  foreach($x in $A){$a.Add($x) | Out-Null}; foreach($y in $B){$b.Add($y) | Out-Null}
  if($a.Count -eq 0 -or $b.Count -eq 0){ return 0.0 }
  $i=0; foreach($w in $a){ if($b.Contains($w)){ $i++ } }
  $u=$a.Count + $b.Count - $i; if($u -le 0){ return 0.0 }; [Math]::Round($i/$u,4)
}
$feature = @()
foreach($g in @('tools\*.ps1','tools\*.psm1','scripts\*.ps1','.github\workflows\*.yml','.github\workflows\*.yaml')){
  foreach($f in Get-ChildItem -Path $Civ -Recurse -File -Include $g -ErrorAction SilentlyContinue | ? FullName -NotMatch '\\\.git\\'){
    $raw = Get-Content $f.FullName -Raw -Encoding UTF8
    $feature += [pscustomobject]@{ Path=$f.FullName; Kind= if($f.Extension -in '.yml','.yaml'){ 'workflow' } elseif($f.Extension -eq '.psm1'){ 'module' } else { 'script' }; NameKey=$f.Name.ToLower(); Tokens=(Tok $raw) }
  }
}
$edges = New-Object System.Collections.Generic.List[object]
for($i=0;$i -lt $feature.Count;$i++){
  for($j=$i+1;$j -lt $feature.Count;$j++){
    if($feature[$i].Kind -ne $feature[$j].Kind){ continue }
    $ns = Jac (Tok $feature[$i].NameKey) (Tok $feature[$j].NameKey)
    if($ns -lt 0.20){ continue }
    $sim = Jac $feature[$i].Tokens $feature[$j].Tokens
    if($sim -ge 0.60){ $edges.Add([pscustomobject]@{A=$feature[$i].Path;B=$feature[$j].Path;Kind=$feature[$i].Kind;NameSim=$ns;Sim=$sim}) }
  }
}
$reinventCsv = Join-Path $RptD "reinvention_pairs_$UTC.csv"
$edges | Export-Csv -NoTypeInformation -Encoding UTF8 $reinventCsv
Add-Check "reinvention-pairs" ($edges.Count -eq 0) "$($edges.Count) pairs"

$needs=$false; foreach($c in $checks){ if(-not $c.OK){ $needs=$true; break } }
if($edges.Count -gt 0 -or $stubFindings.Count -gt 0){ $needs=$true }

$Note = Join-Path $NoteD "VIOLET_RECEIPT_CoSyncRO_$UTC.md"
$lines=@("# ■ Violet Receipt - Read-only CoSync","","**Stamp:** $UTC","**Repos:** CoCivium","**NeedsFullCoSync:** $needs","","### Checks")
foreach($c in $checks){ $lines+= "- [$($c.OK ? 'ok' : 'fail')] $($c.Name)  $($c.Info)" }
$lines+= "","### Artifacts","- Stub candidates CSV: docs/reports/$(Split-Path $stubCsv -Leaf)","- Reinvention pairs CSV: docs/reports/$(Split-Path $reinventCsv -Leaf)","- Helper catalogue: docs/index/HELPERS_INDEX.md","","> If NeedsFullCoSync is true, run your standard CoSync and re-check."
($lines -join "`r`n") + "`r`n" | Set-Content -Encoding utf8NoBOM $Note
Write-Host "VIOLET-RECEIPT => $Note"
