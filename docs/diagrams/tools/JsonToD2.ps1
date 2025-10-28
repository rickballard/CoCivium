Param([Parameter(Mandatory)][string]$In,[Parameter(Mandatory)][string]$Out)
$ErrorActionPreference="Stop"
$py = Join-Path $PSScriptRoot "json2d2.py"
if(!(Test-Path $py)){ throw "json2d2.py not found in tools" }
python "$py" "$In" > "$Out"
