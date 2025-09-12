function Invoke-GhApiSafe {
  param(
    [Parameter(Mandatory)] [string]$Path,
    [ValidateSet("GET","POST","PUT","PATCH","DELETE")] [string]$Method = "GET",
    [switch]$Quiet
  )
  $oldEAP = $ErrorActionPreference
  $ErrorActionPreference = "Continue"

  $haveNat = ($PSVersionTable.PSVersion.Major -ge 7) -and (Get-Variable PSNativeCommandUseErrorActionPreference -Scope Global -EA SilentlyContinue)
  if ($haveNat) { $oldNat = $PSNativeCommandUseErrorActionPreference; $global:PSNativeCommandUseErrorActionPreference = $false }

  try {
    $out  = & gh api @("-X", $Method) $Path 2>&1
    $code = $LASTEXITCODE
  } finally {
    $ErrorActionPreference = $oldEAP
    if ($haveNat) { $global:PSNativeCommandUseErrorActionPreference = $oldNat }
  }

  if (-not $Quiet) { $out }
  return $code
}