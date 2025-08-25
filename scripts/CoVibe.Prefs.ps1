# Reads docs/bpoe/prefs.yml into a PS object. Requires yq; else returns {}.
function Get-CoVibePrefs(){
  $y = Join-Path $PSScriptRoot '..\docs\bpoe\prefs.yml'
  if(Test-Path $y){ try { (& yq -o=json '.' $y) | ConvertFrom-Json } catch { @{} } } else { @{} }
}
