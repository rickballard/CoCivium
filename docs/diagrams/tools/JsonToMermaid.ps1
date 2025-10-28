Param([Parameter(Mandatory)][string]$In,[Parameter(Mandatory)][string]$Out)
$ErrorActionPreference="Stop"
$py = Join-Path $PSScriptRoot "json2mermaid.py"
if(!(Test-Path $py)){ throw "json2mermaid.py not found in tools" }
python "$py" "$In" > "$Out"
