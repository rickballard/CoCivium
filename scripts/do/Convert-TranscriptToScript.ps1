[CmdletBinding()]
param(
  [Parameter(ValueFromPipeline=$true)] [string[]]$Text,
  [string]$OutFile,
  [switch]$FromClipboard
)
begin { $buf = @() }
process { if ($null -ne $Text) { $buf += $Text } }
end {
  if ($FromClipboard) { $buf = (Get-Clipboard) -split "`r?`n" }
  elseif (-not $buf -or ($buf -join '').Length -eq 0) { try { $buf = ([Console]::In.ReadToEnd()) -split "`r?`n" } catch {} }

  filter Clean-Transcript {
    $line = $_
    if ($line -match '^\sPS [^>]+>\s') { $line = $line -replace '^\sPS [^>]+>\s','' }
    if ($line -match '^\s>>>\s$') { return }
    if ($line -match '^\s>>\s')   { $line = $line -replace '^\s>>\s','' }
    if ($line -match '^\s\^(C|Z)\s$') { return }
    if ($line -match '^\s--- .+ ---\s$') { return }
    if ($line -match '^\s(ParserError:|Get-Process:|KeyboardInterrupt|Exception:)') { return }
    if ($line -match '^\s\{.*\}\s*$' -and $line -match '"ts"\s*:\s*\d+' -and $line -match '"event"\s*:\s*"\w+') { return }
    $line
  }

  $result = $buf | Clean-Transcript
  $body   = ($result -join "`r`n").Trim()
  if ($OutFile) {
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $OutFile) | Out-Null
    Set-Content -Path $OutFile -Value $body -Encoding utf8
  } else {
    $body
  }
}
