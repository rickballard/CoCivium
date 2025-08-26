# ================== CoWorkbench.ps1 ==================

# --- Transcript ---
function Start-CoTranscript {
  param([string]$Name = "CoCivium")
  $dir = Join-Path $HOME "Downloads\CoCivium-Logs"
  New-Item -ItemType Directory -Force $dir | Out-Null
  $stamp = Get-Date -Format "yyyyMMdd_HHmmss"
  $path  = Join-Path $dir "$Name-$stamp.ps1log"
  Start-Transcript -Path $path -IncludeInvocationHeader -Force | Out-Null
  Write-Host "→ Transcript: $path"
}
function Stop-CoTranscript { Stop-Transcript | Out-Null }

# --- Private helper used by shims like CoPong150 ---
function __CoPongImpl {
  [CmdletBinding()]
  param([ValidateRange(1,5000)][int]$Lines = 400)
  $dir  = Join-Path $HOME "Downloads\CoCivium-Logs"
  $last = Get-ChildItem $dir -Filter *.ps1log -ErrorAction SilentlyContinue |
          Sort-Object LastWriteTime -Descending | Select-Object -First 1
  if(-not $last){ Write-Warning "No transcript found. Run Start-CoTranscript first."; return }
  $out  = Get-Content -LiteralPath $last.FullName -Tail $Lines
  $text = @("PS CoPong >>>") + $out + @("<<< CoPong PS") -join "`r`n"
  $file = Join-Path $dir "copong_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"
  $text | Set-Content -LiteralPath $file -Encoding UTF8
  try { $text | Set-Clipboard } catch { Write-Warning "Clipboard not available; saved to: $file" }
  Write-Host "✓ CoPong: copied ~${Lines} lines from $($last.Name) to clipboard. Saved: $file"
}

# Shim commands so you can type CoPong150 / CoPong300, etc.
foreach($n in 50,100,150,300,600){
  $sb = [ScriptBlock]::Create("param()`n __CoPongImpl -Lines $n")
  Set-Item -Path ("Function:\CoPong{0}" -f $n) -Value $sb -Force
}

# Optional: convenience alias to your favorite size
Set-Alias CoCopy CoPong150 -Force

Write-Host "CoWorkbench loaded. Cmds: Start-CoTranscript, Stop-CoTranscript, CoPong50/100/150/300/600"
# ================== /CoWorkbench.ps1 ==================
function __CoPongBlocks([int]$Count = 50){
  $dir  = Join-Path $HOME "Downloads\CoCivium-Logs"
  $last = Get-ChildItem $dir -Filter *.ps1log -ErrorAction SilentlyContinue |
          Sort-Object LastWriteTime -Descending | Select-Object -First 1
  if(-not $last){ Write-Warning "No transcript found. Run Start-CoTranscript first."; return }
  $all = Get-Content -LiteralPath $last.FullName

  $idxs = for($i=0;$i -lt $all.Length;$i++){
    if($all[$i] -match '^\s*PS .+?>\s'){ $i }
  }

  if(-not $idxs){ Write-Warning "No prompt lines found."; return }
  $start = [Math]::Max(0, $idxs.Count - $Count)
  $fromIndex = $idxs[$start]
  $slice = $all[$fromIndex..($all.Length-1)]

  $text = @("PS CoPong >>>") + $slice + @("<<< CoPong PS") -join "`r`n"
  $file = Join-Path $dir "copong_blocks_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"
  $text | Set-Content -LiteralPath $file -Encoding UTF8
  try { $text | Set-Clipboard } catch {}
  Write-Host "✓ CoPongBlocks: copied last $Count command blocks. Saved: $file"
}
# wrappers: CoPongB50 / CoPongB150 / CoPongB300
foreach($n in 50,150,300){
  Set-Item -Path ("Function:\CoPongB{0}" -f $n) -Value ([ScriptBlock]::Create("param()`n __CoPongBlocks -Count $n")) -Force
}

