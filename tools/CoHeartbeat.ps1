param($CU="OK",$PU="OK",$HU="OK",$WT="OK",$Out="console")
$map = @{
  "OK"=@{dot="🟢";name="OK"}; "SOFT"=@{dot="🟡";name="SOFT"}; "HARD"=@{dot="🟠";name="HARD"}; "FATAL"=@{dot="🔴";name="FATAL"}; "NA"=@{dot="⚪";name="NA"}
}
function New-CoBloatLine {
  param($CU,$PU,$HU,$WT)
  $fmt = @("CU",$CU),("PU",$PU),("HU",$HU),("WT",$WT) | ForEach-Object {
    $m=$map[$_[1]]; "{0} {1}" -f $m.dot,$_[0]
  }
  "CoBloat: " + ($fmt -join "  ")
}
$line = New-CoBloatLine -CU $CU -PU $PU -HU $HU -WT $WT
if($Out -eq "console"){ Write-Host $line }
elseif($Out -eq "markdown"){ $line | Set-Content -Path (Join-Path $PWD ".cobloat_line.md") -Encoding utf8 }
else{ $line }
