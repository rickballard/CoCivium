Param()
[int64]$Limit = 100MB
$lines = @(); while($l = [Console]::In.ReadLine()){ if($l -and $l.Trim()){ $lines += $l } }
if($lines.Count -eq 0){ exit 0 }

function Get-BatchCheck([string[]]$Shas){
  if(!$Shas){ return @() }
  $txt = ($Shas -join "`n") + "`n"
  $psi = New-Object System.Diagnostics.ProcessStartInfo
  $psi.FileName = 'git'; $psi.Arguments = 'cat-file --batch-check'
  $psi.UseShellExecute = $false; $psi.RedirectStandardInput = $true; $psi.RedirectStandardOutput = $true
  $p = [System.Diagnostics.Process]::Start($psi)
  $p.StandardInput.Write($txt); $p.StandardInput.Close()
  $out = $p.StandardOutput.ReadToEnd(); $p.WaitForExit()
  return $out -split "`n"
}

$found = New-Object System.Collections.Generic.List[object]
foreach($ln in $lines){
  $parts = $ln -split '\s+'; if($parts.Count -lt 4){ continue }
  $local,$localSha,$remote,$remoteSha = $parts[0..3]
  $range = if($remoteSha -match '^[0]{40}$'){ $localSha } else { "$remoteSha..$localSha" }

  $map = @{}
  foreach($row in (git rev-list --objects $range 2>$null)){
    $p = $row -split ' '
    if($p[0] -and -not $map.ContainsKey($p[0])){ $map[$p[0]] = ($p.Count -gt 1 ? ($p[1..($p.Count-1)] -join ' ') : '') }
  }
  foreach($r in (Get-BatchCheck @($map.Keys))){
    if(-not $r){ continue }
    $f = $r -split '\s+'
    if($f.Count -ge 3 -and $f[1] -eq 'blob'){
      $size = [int64]$f[2]
      if($size -ge $Limit){
        $found.Add([pscustomobject]@{ sha=$f[0]; mb=[math]::Round($size/1MB,2); path=$map[$f[0]]; local=$local; remote=$remote })
      }
    }
  }
}

if($found.Count -gt 0){
  Write-Host '[BLOB-GUARD] Push blocked: blobs >= 100MB present.' -ForegroundColor Red
  $found | Sort-Object mb -Descending | Format-Table -Auto sha,mb,path,local,remote | Out-String | Write-Host
  Write-Host 'See docs/bpoe/BLOB_GUARD.md for rewrite steps.' -ForegroundColor Yellow
  exit 1
}
exit 0
