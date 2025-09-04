param(
  [string]$RepoRoot = ".",
  [string]$Stamp    = (Get-Date -Format "yyMMdd")
)
$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$root     = (Resolve-Path $RepoRoot).Path
$trustDir = Join-Path $root 'docs\bpoe\trust'
$allow    = Join-Path $trustDir 'allow.txt'
$warn     = Join-Path $trustDir 'warn.txt'
$deny     = Join-Path $trustDir 'deny.txt'
$indexDir = Join-Path $root 'index'
$icDir    = Join-Path $root ("intake\ideacards\session_{0}" -f $Stamp)
$cwDir    = Join-Path $root ("intake\cowraps\session_{0}"   -f $Stamp)
$null = New-Item -ItemType Directory -Force -Path $indexDir -EA SilentlyContinue

function Load-List($path){
  if (-not (Test-Path $path)) { return @() }
  Get-Content $path -EA SilentlyContinue |
    Where-Object { $_ -match '\S' -and -not $_.Trim().StartsWith('#') } |
    ForEach-Object { $_.Trim().ToLowerInvariant() } |
    Where-Object { $_ -ne "" } | Select-Object -Unique
}
$Allow=[Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
$Warn =[Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
$Deny =[Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
(Load-List $allow)|%{ $Allow.Add($_)|Out-Null }; (Load-List $warn)|%{ $Warn.Add($_)|Out-Null }; (Load-List $deny)|%{ $Deny.Add($_)|Out-Null }

$files = @(Get-ChildItem $icDir,$cwDir -Filter *.md -File -Recurse -EA SilentlyContinue)
$links = [System.Collections.Generic.List[object]]::new()
$rx='(https?://[^\s\)\]>"]+)'
foreach($f in $files){
  try{
    $t=Get-Content $f.FullName -Raw -EA Stop
    [Regex]::Matches($t,$rx)|%{
      try{ $u=[Uri]$_.Value; if($u.Host){ $links.Add([pscustomobject]@{ file=$f.FullName; url=$_.Value; host=$u.Host.ToLowerInvariant() }) } }catch{}
    }
  }catch{}
}
$flags=[System.Collections.Generic.List[object]]::new()
foreach($L in $links | Select-Object -Unique url,host,file){
  $host=$L.host; $level='OK'; $reason=''
  if($Deny.Contains($host)){ $level='DENY'; $reason='domain in deny.txt' }
  elseif($Warn.Contains($host)){ $level='WARN'; $reason='domain in warn.txt' }
  elseif(-not $Allow.Contains($host)){ $level='WARN'; $reason='unknown domain' }
  if($level -ne 'OK'){
    $flags.Add([pscustomobject]@{
      file=$L.file.Substring($root.Length).TrimStart('\','/'); url=$L.url; domain=$host; level=$level; reason=$reason
    })
  }
}
$summary = if($flags.Count -eq 0){'OK'} elseif($flags | Where-Object {$_.level -eq 'DENY'}){'DENY'} else {'WARN'}

$trustJson = Join-Path $indexDir 'TRUST_FLAGS.json'
$trustMd   = Join-Path $indexDir 'TRUST_STATUS.md'
@{ ts=(Get-Date).ToString('o'); session=$Stamp; level=$summary; count=$flags.Count; flags=$flags } |
  ConvertTo-Json -Depth 5 | Set-Content -Encoding UTF8 $trustJson

$lines = @("# Trust Status","","**Overall:** $summary  •  **Flags:** $($flags.Count)","")
foreach($f in $flags){ $lines += "- `$( $f.level )` **$($f.domain)** — $($f.reason)  (`$($f.file)`) → <$($f.url)>" }
if($flags.Count -eq 0){ $lines += "- No questionable sources detected for this session." }
$lines -join "`n" | Set-Content -Encoding UTF8 $trustMd

Write-Host ("Trust: {0} • flags {1}" -f $summary, $flags.Count)
