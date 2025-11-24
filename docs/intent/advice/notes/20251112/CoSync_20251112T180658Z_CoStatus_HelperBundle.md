# CoSync  -  Suggestion: CoStatus HelperBundle (aggregated) (20251112T180658Z)

## Intent
Package the CoStatus line into a single, drop-in **HelperBundle** so sessions can call one API and get:
- colored tier (CU/PU/HU/WT → OK/SOFT/HARD/FATAL)
- countdown/elapsed bar
- drift (+/− vs target sec)
- receipts emission (status snapshots)
- null-safe GitHub label parsing
- $PSScriptRoot interactive safety

## Proposed bundle shape (suggestion; CoPrime to own/evolve)
\	ools/heartbeat/CoStatusBundle/\
- **CoStatus.API.ps1**  -  Show-CoStatus -Phase -Tier -TargetSec -Start -CU -PU -HU -WT (single entrypoint)
- **CoStatus.Receipt.ps1**  -  Write-CoStatusReceipt -Line -Kind <phase> (ensures \eceipts\ path)
- **CoStatus.SafePaths.ps1**  -  Get-ScriptRoot (handles empty $PSScriptRoot), Ensure-ReceiptsDir
- **CoStatus.Examples.ps1**  -  minimal examples for DO_* scripts
- **README.md**  -  quick adoption steps (one dot-source + two calls)

> Sessions do:  
> ./heartbeat/CoStatusBundle/CoStatus.API.ps1  
> $s=Get-Date; Show-CoStatus -Phase 'Sweep' -Tier 'OK' -TargetSec 60 -Start 

## Null-safety + interactive safety (snippets for bundle)
`powershell
# Safe script root for console & compiled contexts
function Get-ScriptRoot {
  C:\Users\Chris\Downloads\_waves\MegaWave_TypoFix_Colmmunity_v0.1.4_20251111T044528Z_0cb29bcb0c8e\payload\receipts\fix_summary_20251111T212228Z.txt = 
  if([string]::IsNullOrEmpty(C:\Users\Chris\Downloads\_waves\MegaWave_TypoFix_Colmmunity_v0.1.4_20251111T044528Z_0cb29bcb0c8e\payload\receipts\fix_summary_20251111T212228Z.txt)){
    C:\Users\Chris\Downloads\_waves\MegaWave_TypoFix_Colmmunity_v0.1.4_20251111T044528Z_0cb29bcb0c8e\payload\receipts\fix_summary_20251111T212228Z.txt = Split-Path -Parent System.Management.Automation.InvocationInfo.MyCommand.Path
    if([string]::IsNullOrEmpty(C:\Users\Chris\Downloads\_waves\MegaWave_TypoFix_Colmmunity_v0.1.4_20251111T044528Z_0cb29bcb0c8e\payload\receipts\fix_summary_20251111T212228Z.txt)){ C:\Users\Chris\Downloads\_waves\MegaWave_TypoFix_Colmmunity_v0.1.4_20251111T044528Z_0cb29bcb0c8e\payload\receipts\fix_summary_20251111T212228Z.txt = (Get-Location).Path }
  }
  return C:\Users\Chris\Downloads\_waves\MegaWave_TypoFix_Colmmunity_v0.1.4_20251111T044528Z_0cb29bcb0c8e\payload\receipts\fix_summary_20251111T212228Z.txt
}

# Ensure receipts dir exists
function Ensure-ReceiptsDir {
   = Get-ScriptRoot
  C:\Users\Chris\Downloads\_waves\MegaWave_SessionClose_TypoFix_v0.2.0_20251112T144454Z_de585564\payload\receipts = Join-Path  'receipts'
  if(-not (Test-Path C:\Users\Chris\Downloads\_waves\MegaWave_SessionClose_TypoFix_v0.2.0_20251112T144454Z_de585564\payload\receipts)){ New-Item -ItemType Directory -Force -Path C:\Users\Chris\Downloads\_waves\MegaWave_SessionClose_TypoFix_v0.2.0_20251112T144454Z_de585564\payload\receipts | Out-Null }
  return C:\Users\Chris\Downloads\_waves\MegaWave_SessionClose_TypoFix_v0.2.0_20251112T144454Z_de585564\payload\receipts
}

# Labels null-safe extraction
function Get-LabelNames(@{labels=System.Object[]; number=547; repository=; title=[intent] TypoFix ColmmunityΓåÆCommunity (20251112T071855Z); url=https://github.com/rickballard/CoCivium/pull/547}){
  return @(@{labels=System.Object[]; number=547; repository=; title=[intent] TypoFix ColmmunityΓåÆCommunity (20251112T071855Z); url=https://github.com/rickballard/CoCivium/pull/547}.labels | Where-Object {  -and .name } | ForEach-Object name)
}
Adoption target

CoPrime to publish v0 spec + tiny test harness.

Sessions: one dot-source + call at phase start/end, pipe final line to Write-CoStatusReceipt.

Pointers

Today’s TypoFix wave receipts + PRs show the places to hook a status print/receipt.

 empty error reproduced (interactive console); handled by Get-ScriptRoot above.

Next steps (for CoPrime)

 Approve/adjust API surface (Show-CoStatus) and schema (line format + tiers).

 Ship CoStatusBundle v0 into tools/heartbeat/CoStatusBundle/.

 Add a micro CI check: "CoStatus quick render" (smoke-test ANSI + width).

 Publish a 10-line “How to call from DO_*” doc; update one wave as exemplar.
