function Enter-CoPrompt{
  try { $script:OldPrompt = (Get-Item function:\prompt).ScriptBlock } catch {}
  function prompt { "PS> " }
}
function Exit-CoPrompt{
  if($script:OldPrompt){ Set-Item function:\prompt $script:OldPrompt; $script:OldPrompt=$null }
  else{ Remove-Item function:\prompt -ErrorAction SilentlyContinue }
}
function Start-CoBlock([Parameter(Mandatory)][string]$Name){
  if(-not $global:CoBlockSeq){ $global:CoBlockSeq = 0 }
  $global:CoBlockSeq++
  $global:CoBlockLetter = [char](65 + (($global:CoBlockSeq-1) % 26))  # A..Z loop
  $global:CoStepN = 0
  $global:CoBlockId = "$Name $(Get-Date -Format 'yyyyMMdd-HHmm')"
  Write-Host ("==== [$($global:CoBlockLetter):$global:CoBlockId] ====")
}
function CoStep([string]$Label){
  if(-not $global:CoBlockLetter){ $global:CoBlockLetter = 'A' }
  $global:CoStepN = 1 + [int]($global:CoStepN)
  $stamp = Get-Date -Format 'mmss'
  Write-Host ("-- [$($global:CoBlockLetter).$($global:CoStepN)@$stamp] $Label")
}
function CoWait([string]$Message){ Write-Host ("[WAIT] $Message") }
function CoSnip([string]$Note){
  $name = ($global:CoBlockId -split ' ')[0]
  if(-not $Note){ $Note = "$name executed" }
  Write-Host ""; Write-Host (":) ---easy-snip--- $Note"); 1..5 | ForEach-Object { Write-Host "" }
}
function CoSetStart([Parameter(Mandatory)][string]$Name){
  Enter-CoPrompt
  $global:CoSetId = "$Name $(Get-Date -Format 'yyyyMMdd-HHmm')"
  Write-Host ("===== [SET:$global:CoSetId] BEGIN =====")
}
function CoSetEnd([string]$Note){
  if(-not $Note){ $Note = "Set $global:CoSetId complete" }
  CoSnip $Note
  Write-Host ("===== [SET:$global:CoSetId] END =====")
  Exit-CoPrompt
}
