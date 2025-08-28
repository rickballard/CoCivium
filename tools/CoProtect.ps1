Set-StrictMode -Version Latest

function Test-CoProtectRequirements {
  $age = (Get-Command age -ErrorAction SilentlyContinue) -ne $null
  $bw  = (Get-Command bw  -ErrorAction SilentlyContinue) -ne $null
  $sess= [string]::IsNullOrWhiteSpace($env:BW_SESSION) -eq $false
  [pscustomobject]@{ age=$age; bw=$bw; bwSession=$sess }
}

function Get-AgePrivateKey {
  if (-not $env:BW_SESSION) { throw "BW_SESSION not set. Run: bw unlock --raw | clip; then `$env:BW_SESSION='<token>'" }
  $key = bw --session $env:BW_SESSION get notes "coagent-age-key" 2>$null
  if (-not $key -or $key -notmatch '^AGE-SECRET-KEY-1') { throw "Bitwarden item 'coagent-age-key' not found or invalid." }
  return $key
}

function Get-AgePublicKeyPath { return (Join-Path $PWD ".secrets\age.pub") }

function Ensure-TempDir {
  $tmp = Join-Path $PWD ".secrets\tmp"
  if (-not (Test-Path $tmp)) { New-Item -ItemType Directory -Force -Path $tmp | Out-Null }
  return $tmp
}

function Protect-Doc {
  param([Parameter(Mandatory)][string]$Path)
  $req = Test-CoProtectRequirements
  if (-not ($req.age -and $req.bw)) { throw "Need age.exe and bw.exe on PATH." }
  if (-not (Test-Path $Path)) { throw "File not found: $Path" }
  $pub = Get-AgePublicKeyPath
  if (-not (Test-Path $pub)) { throw "Missing public key: $pub" }
  $out = "$Path.age"
  age -e -p -o $out -R $pub -- $Path
  if ($LASTEXITCODE -ne 0 -or -not (Test-Path $out)) { throw "age encryption failed." }
  Remove-Item -Force $Path
  Write-Host ("Encrypted -> {0}" -f $out) -ForegroundColor Green
}

function Open-Doc {
  param([Parameter(Mandatory)][string]$EncryptedPath)
  $req = Test-CoProtectRequirements
  if (-not ($req.age -and $req.bw -and $req.bwSession)) { throw "Need age.exe, bw.exe, and BW_SESSION set." }
  if (-not (Test-Path $EncryptedPath)) { throw "Not found: $EncryptedPath" }

  $priv = Get-AgePrivateKey
  $tmp  = Ensure-TempDir
  $base = [IO.Path]::GetFileNameWithoutExtension($EncryptedPath)
  $out  = Join-Path $tmp $base

  $privFile = Join-Path $tmp "agekey.txt"
  $priv | Set-Content -Encoding UTF8 $privFile
  try {
    age -d -i $privFile -o $out -- $EncryptedPath
    if (-not (Test-Path $out)) { throw "age decryption failed." }
  } finally {
    try { Remove-Item -Force $privFile } catch {}
  }

  Write-Host ("Decrypted -> {0}" -f $out) -ForegroundColor Yellow
  try { Start-Process $out } catch {}
}

function Clean-ProtectTemp {
  $tmp = Join-Path $PWD ".secrets\tmp"
  if (Test-Path $tmp) {
    Get-ChildItem $tmp -File -ErrorAction SilentlyContinue | ForEach-Object {
      try { Remove-Item -Force $_.FullName } catch {}
    }
    Write-Host "Cleaned .secrets\tmp" -ForegroundColor Yellow
  }
}

# Wash-away on session exit
try { Register-EngineEvent -SourceIdentifier PowerShell.Exiting -Action { try { Clean-ProtectTemp } catch {} } | Out-Null } catch {}
