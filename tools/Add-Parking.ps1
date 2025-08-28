param([Parameter(Mandatory)][string]$Text)
$lot="docs/ops/PARKING_LOT.md"
$stamp=(Get-Date).ToString("yyyy-MM-dd HH:mm")
Add-Content -Path $lot -Encoding utf8 -Value ("- [{0}] {1}" -f $stamp,$Text)
