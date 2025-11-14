param([string]$RepoRoot = (Split-Path -Parent $PSScriptRoot))
$ErrorActionPreference="Stop"; Set-Location $RepoRoot
New-Item -ItemType Directory -Force -Path (Join-Path $RepoRoot "status") | Out-Null
$score=15; $status = if($score -ge 50){"RED"} elseif($score -ge 10){"AMBER"} else {"GREEN"}
$obj=[pscustomobject]@{ generatedUtc=(Get-Date).ToUniversalTime().ToString("o"); score=$score; status=$status; components=@{ sample=1 } }
$out=Join-Path $RepoRoot "status\codrift.json"; $obj | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath $out -Encoding UTF8
"CDI (CoDrift Index): {0}%" -f $score; "Status             : {0}" -f $status; "Wrote              : {0}" -f $out
