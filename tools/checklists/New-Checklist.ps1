Param([Parameter(Mandatory)][string]$Name,[string]$Title)
$ErrorActionPreference="Stop"
$R=(Resolve-Path "$PSScriptRoot\..\..").Path
$dir=Join-Path $R "docs\checklists"; New-Item -ItemType Directory -Force $dir|Out-Null
$f=Join-Path $dir ("{0}.md" -f $Name)
$lines=@()
$lines+=("# "+($Title ?? $Name))
$lines+=("")
$lines+=("Priority: [P1|P2|P3]   Owner: [name]   Repo: CoCivium   Updated: {0}" -f (Get-Date -Format "yyyy-MM-dd"))
$lines+=("")
$lines+=("## Tasks")
$lines+=("- [ ] Example task 1")
$lines+=("- [ ] Example task 2")
$lines+=("")
$lines+=("## Notes")
$lines+=("")
$lines | Set-Content -Encoding utf8 $f
Write-Host "Created: $f" -ForegroundColor Green
