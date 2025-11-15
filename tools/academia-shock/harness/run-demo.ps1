param(
  [string]$Task = "demo-br"
)
$ErrorActionPreference = "Stop"
function UTS { (Get-Date).ToUniversalTime().ToString('yyyyMMddTHHmmssZ') }
$root    = Split-Path -Parent $MyInvocation.MyCommand.Path
$receipt = Join-Path $root ("receipt_{0}.json" -f (UTS))

# Synthetic metrics (placeholder): tune in MW6.2
$metrics = switch ($Task) {
  "demo-br" { @{ BR=0.91; CL=0.0;  PPR=0.0;  PF=0.0 } }
  "demo-cl" { @{ BR=0.0;  CL=0.88; PPR=0.0;  PF=0.0 } }
  "demo-ppr"{ @{ BR=0.0;  CL=0.0;  PPR=0.73; PF=0.0 } }
  "demo-pf" { @{ BR=0.0;  CL=0.0;  PPR=0.0;  PF=0.85 } }
  default   { @{ BR=0.5;  CL=0.5;  PPR=0.5;  PF=0.5 } }
}

# Create a placeholder artifact and hash it
$artifact = Join-Path $root ("artifact_{0}.txt" -f (UTS))
"demo artifact for $Task" | Set-Content -Encoding UTF8 $artifact
$sha256 = (Get-FileHash -Algorithm SHA256 $artifact).Hash.ToLower()

$receiptObj = [ordered]@{
  run_id   = (New-Guid).ToString()
  ts_utc   = (Get-Date).ToUniversalTime().ToString("o")
  task     = $Task
  metrics  = $metrics
  artifacts= @(@{ path = (Resolve-Path $artifact).Path; sha256 = $sha256 })
  notes    = "Seed demo; replace with real harness in MW6.x"
}
$receiptObj | ConvertTo-Json -Depth 8 | Set-Content -Encoding UTF8 $receipt
Write-Host "Wrote receipt: $receipt" -ForegroundColor Green
