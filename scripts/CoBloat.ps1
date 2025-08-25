function Test-CoSessionBloat {
  param([int]$Turns=0,[int]$Branches=0,[int]$OpenPRs=0,[int]$RecentErrors=0)
  if($Turns -ge 100) { return $true }
  if($Branches -ge 3 -or $OpenPRs -ge 3) { return $true }
  if($RecentErrors -ge 3) { return $true }
  return $false
}
function Get-CoBloatStats {
  New-Item -ItemType Directory -Force ".co" | Out-Null
  $turns = (Get-Content -ErrorAction SilentlyContinue ".co\turns.count" | ForEach-Object {[int]$_}); if(-not $turns){$turns=0}
  $branches = ((git branch --list | Measure-Object).Count)
  $openprs = 0; if(Get-Command gh -ErrorAction SilentlyContinue){ $openprs = (gh pr list --state open -L 100 | Measure-Object).Count }
  $errors = (Get-Content -ErrorAction SilentlyContinue ".co\errors.count" | ForEach-Object {[int]$_}); if(-not $errors){$errors=0}
  [pscustomobject]@{Turns=$turns;Branches=$branches;OpenPRs=$openprs;RecentErrors=$errors}
}
function Enable-CoDump { New-Item -ItemType Directory -Force ".co" | Out-Null; Set-Content ".co\dump.enabled" "1"; Write-Host "CoDump enabled (optional Downloads handoff)"; }
function Disable-CoDump { if(Test-Path ".co\dump.enabled"){ Remove-Item ".co\dump.enabled" -Force }; Write-Host "CoDump disabled"; }
function Test-CoDumpEnabled { return (Test-Path ".co\dump.enabled") }
function Suggest-CoDumpIfBloat {
  $s = Get-CoBloatStats
  if(Test-CoSessionBloat -Turns $s.Turns -Branches $s.Branches -OpenPRs $s.OpenPRs -RecentErrors $s.RecentErrors){
    if(-not (Test-CoDumpEnabled)){
      Write-Host "[Suggest] Session looks heavy. Run Enable-CoDump to allow optional handoff files in Downloads." -ForegroundColor Yellow
    }
  }
}
function CoTick {
  New-Item -ItemType Directory -Force ".co" | Out-Null
  $n = 0; if(Test-Path ".co\turns.count"){ $n = [int](Get-Content ".co\turns.count") }
  Set-Content ".co\turns.count" ($n+1)
}
