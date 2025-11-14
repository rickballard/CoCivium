param([string]$RepoRoot = (Split-Path -Parent $PSScriptRoot))
$ErrorActionPreference="Stop"; Set-Location $RepoRoot
$readme="README.md"; $src="status\codrift.json"
$j = if(Test-Path $src){ Get-Content $src -Raw | ConvertFrom-Json } else { $null }
$score=[string]($j?.score ?? "n/a"); $status=[string]($j?.status ?? "n/a")
$block=@("<!-- BEGIN: STATUS -->","### Operational Status",("CoDrift Index: {0}% ({1})" -f $score,$status),"<!-- END: STATUS -->")
$text= if(Test-Path $readme){ Get-Content $readme -Raw } else { "# " + (Split-Path -Leaf $Pwd) + "`n" }
$begin="<!-- BEGIN: STATUS -->"; $end="<!-- END: STATUS -->"
if($text -match [regex]::Escape($begin) -and $text -match [regex]::Escape($end)){
  $pre=$text.Substring(0,$text.IndexOf($begin)); $post=$text.Substring($text.IndexOf($end)+$end.Length)
  $text = ($pre.TrimEnd()+[Environment]::NewLine+($block -join [Environment]::NewLine)+[Environment]::NewLine+$post.TrimStart())
} else { $text = ($text.TrimEnd()+[Environment]::NewLine+[Environment]::NewLine+($block -join [Environment]::NewLine)+[Environment]::NewLine) }
Set-Content -LiteralPath $readme -Value $text -Encoding UTF8; "Updated README status block."
