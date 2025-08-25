$script:CoMetricsFile = $null

function CoMetricsInit{
  try{
    $root = (Get-Location).Path
    $dir = Join-Path $root ".covibe"
    New-Item -ItemType Directory -Force $dir | Out-Null
    $script:CoMetricsFile = Join-Path $dir "metrics.ndjson"
    if(-not (Test-Path $script:CoMetricsFile)){ "" | Set-Content $script:CoMetricsFile -Encoding utf8 }
  } catch {}
}

function CoMetricsEvent([Parameter(Mandatory)][string]$Type,[hashtable]$Data){
  if(-not $script:CoMetricsFile){ CoMetricsInit }
  try{
    $o = [ordered]@{
      ts=(Get-Date).ToString("s"); type=$Type; set=$global:CoSetId; block=$global:CoBlockId; letter=$global:CoBlockLetter; step=$global:CoStepN
    }
    if($Data){ foreach($k in $Data.Keys){ $o[$k]=$Data[$k] } }
    ($o | ConvertTo-Json -Compress) | Add-Content $script:CoMetricsFile -Encoding utf8
  } catch {}
}

function CoAwayStart([string]$Why=""){ CoMetricsEvent 'away_start' @{why=$Why} }
function CoAwayEnd(){ CoMetricsEvent 'away_end' @{} }

function CoPulse(){
  if(-not $script:CoMetricsFile){ CoMetricsInit }
  if(-not (Test-Path $script:CoMetricsFile)){ Write-Host "No metrics yet."; return }
  $lines = Get-Content $script:CoMetricsFile -ErrorAction SilentlyContinue
  if(-not $lines){ Write-Host "No metrics yet."; return }

  $idleMax = [int]([Environment]::GetEnvironmentVariable('COVIBE_IDLE_MAX_SECS')); if($idleMax -le 0){ $idleMax = 300 }

  $bySet=@{}
  foreach($line in $lines){
    try{ $e=$line|ConvertFrom-Json }catch{ continue }
    if(-not $e.set){ continue }
    if(-not $bySet.ContainsKey($e.set)){ $bySet[$e.set]=@() }
    $bySet[$e.set] += $e
  }

  $today=(Get-Date).Date
  $done=@()

  foreach($sid in $bySet.Keys){
    $evts = $bySet[$sid] | Sort-Object { [datetime]$_.ts }
    $start = ($evts | Where-Object type -eq 'set_start' | Select-Object -First 1)
    $finish= ($evts | Where-Object type -eq 'set_end'   | Select-Object -Last 1)
    if(-not $start -or -not $finish){ continue }
    $t0=[datetime]$start.ts; $t1=[datetime]$finish.ts
    if($t0 -lt $today){ continue }

    $wall = ($t1 - $t0).TotalSeconds

    $explicit=0.0; $stack=$null
    foreach($e in $evts){
      if($e.type -eq 'away_start'){ $stack=[datetime]$e.ts }
      elseif($e.type -eq 'away_end' -and $stack){ $explicit += ([datetime]$e.ts - $stack).TotalSeconds; $stack=$null }
    }
    if($stack){ $explicit += ($t1 - $stack).TotalSeconds }

    $capsum=0.0; $prev=$t0
    foreach($e in $evts){
      if($e.type -in @('step','set_end','block_start')){
        $dt = ([datetime]$e.ts - $prev).TotalSeconds
        if($dt -gt 0){ $capsum += [math]::Min($dt,$idleMax) }
        $prev = [datetime]$e.ts
      }
    }
    $auto = [math]::Max(0.0, $wall - $capsum)
    $active = [math]::Max(0.0, $wall - $explicit - $auto)
    $steps  = ($evts | Where-Object type -eq 'step').Count
    $effPct = if($wall -gt 0){ [math]::Round(100.0 * ($active / $wall), 0) } else { 0 }

    $done  += [pscustomobject]@{ id=$sid; wall=$wall; active=$active; auto=$auto; explicit=$explicit; steps=$steps; eff=$effPct }
  }

  if($done.Count -eq 0){ Write-Host "No completed sets today."; return }

  $count=$done.Count
  $avgSteps=[math]::Round((($done|Measure-Object steps -Average).Average),2)

  function _med([double[]]$a){ $a=$a|Sort-Object; if($a.Count%2){ $a[[int]($a.Count/2)] } else { ($a[($a.Count/2)-1]+$a[$a.Count/2])/2 } }
  $wallMed=[math]::Round((_med ($done|Select-Object -Expand wall)),1)
  $actMed =[math]::Round((_med ($done|Select-Object -Expand active)),1)
  $autoMed=[math]::Round((_med ($done|Select-Object -Expand auto)),1)
  $effMed =[math]::Round((_med ($done|Select-Object -Expand eff)),0)

  Write-Host ("CoPulse: {0} sets | efficiency {1}% (median, active/wall) | wall {2}s | active {3}s | auto-away {4}s | avg steps {5}" -f $count,$effMed,$wallMed,$actMed,$autoMed,$avgSteps)
}
function CoSessionInit([string]$Team=""){
  if(-not $env:COVIBE_SESSION){ $env:COVIBE_SESSION = ("S-" + (Get-Date -Format 'yyyyMMdd-HHmmss') + "-" + ([guid]::NewGuid().ToString('N').Substring(0,6))) }
  CoMetricsEvent 'session_start' @{ sid=$env:COVIBE_SESSION; team=$Team }
  Write-Host ("-- [CoSession] active sid={0} {1}" -f $env:COVIBE_SESSION, ($(if($Team){"team="+$Team}else{""})))
}
function CoSessionEnd(){ if($env:COVIBE_SESSION){ CoMetricsEvent 'session_end' @{ sid=$env:COVIBE_SESSION }; $env:COVIBE_SESSION=$null; Write-Host "-- [CoSession] ended" } }
function CoChatStart([string]$Topic=""){ if(-not $env:COVIBE_SESSION){ CoSessionInit } ; CoMetricsEvent 'chat_start' @{ sid=$env:COVIBE_SESSION; topic=$Topic }; Write-Host ("-- [CoChat] in-session sid={0} {1}" -f $env:COVIBE_SESSION,($(if($Topic){"topic="+$Topic}else{""}))) }
function CoChatEnd(){ if($env:COVIBE_SESSION){ CoMetricsEvent 'chat_end' @{ sid=$env:COVIBE_SESSION }; Write-Host ("-- [CoChat] end sid={0}" -f $env:COVIBE_SESSION) } }
