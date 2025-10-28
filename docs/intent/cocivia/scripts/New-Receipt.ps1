# New-Receipt.ps1
param([Parameter(Mandatory=$true)][string]$OutDir,[string]$ModelId="example/1.0",[string]$Provider="ExampleAI",[string]$Jurisdiction="US")
Set-StrictMode -Version Latest; $ErrorActionPreference='Stop'
New-Item -ItemType Directory -Force -Path $OutDir | Out-Null
$receipt=@{model_id=$ModelId;provider=$Provider;version="1.0.0";jurisdictions_of_control=@($Jurisdiction);provenance=@{weights_lineage="pretrain->finetune"};evaluations=@();data_controls=@{residency=$Jurisdiction};freshness_utc=(Get-Date -AsUTC -Format o)}
$impact=@{project_id="$Provider-$ModelId";reporting_period_start=(Get-Date).AddDays(-90).ToString("yyyy-MM-dd");reporting_period_end=(Get-Date).ToString("yyyy-MM-dd");kpis=@{task_upskilling_pct=0;local_processing_ratio=0.0};methods="TBD";freshness_utc=(Get-Date -AsUTC -Format o)}
$receipt|ConvertTo-Json -Depth 8|Set-Content -Encoding UTF8 (Join-Path $OutDir "receipt.json")
$impact |ConvertTo-Json -Depth 8|Set-Content -Encoding UTF8 (Join-Path $OutDir "impact-annex.json")
