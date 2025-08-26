# CoAgent Kit loader (optional)
$kit = Join-Path $HOME 'Documents\GitHub\CoCivium\scripts\CoVibe.BP.ps1'
if (Test-Path $kit) {
  . $kit
  Set-Alias co-rescue CoBP-Rescue -Scope Global
}

# Defaults (session-local; comment out if you prefer manual)
$env:CO_BP_AUTOBRAND = '1'
$env:CO_BP_PROBE_SEC = '4'
$env:CO_BP_TOKENS    = '0'
