$ErrorActionPreference="Stop"
param([string]$RepoRoot,[string]$Scope="docs")
$terms = @{}
try {
  $gib = Join-Path (Split-Path $RepoRoot -Parent) "GIBindex\docs\terms"
  if(Test-Path $gib){
    Get-ChildItem $gib -Filter *.md | % {
      $name = [IO.Path]::GetFileNameWithoutExtension($_.Name)
      $terms[$name] = ("../../GIBindex/docs/terms/{0}.md" -f $_.Name)
    }
  }
} catch {}
$mds = Get-ChildItem (Join-Path $RepoRoot $Scope) -Recurse -Include *.md
foreach($f in $mds){
  $t = Get-Content $f.FullName -Raw
  $orig = $t
  foreach($k in $terms.Keys){
    $rx = "(?<!\[)"+[regex]::Escape($k)+"(?!\])"
    $link = "["+$k+"]("+$terms[$k]+")"
    $t = [regex]::Replace($t,$rx,$link)
  }
  if($t -ne $orig){ Set-Content -Path $f.FullName -Encoding utf8NoBOM -Value $t }
}

