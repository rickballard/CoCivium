param()
function CoMark(){
  $root = (Get-Location).Path
  $c1 = Join-Path $root "docs\brand\TM_CHECKLIST.md"
  $c2 = Join-Path $root "docs\brand\BRAND_STATUS.md"
  Write-Host ("Checklist : " + $c1)
  Write-Host ("Status    : " + $c2)
}
