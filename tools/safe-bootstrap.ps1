param()
function Banner($m){ Write-Host ("== {0} ==" -f $m) }
function Abort-GitOps { git rebase --abort 2>$null; git merge --abort 2>$null }
function Set-LF([string]$p){ (Get-Content $p -Raw) -replace "`r`n","`n" | Set-Content $p -NoNewline -Encoding utf8 }
function Update-QuickNav {
  $readme="README.md"; $start="<!-- QUICK-NAV:BEGIN -->"; $end="<!-- QUICK-NAV:END -->"
  $nav=$start+"`n"+
    "- [Start Here](docs/START-HERE.md)`n"+
    "- [Repo Map](docs/REPO-MAP.md)`n"+
    "- [Workflows](docs/WORKFLOWS.md)`n"+
    "- [Ideas Index](docs/ideas/INDEX.md)`n"+$end
  $txt = if (Test-Path $readme) { Get-Content $readme -Raw } else { "" }
  if ($txt -and $txt -match [regex]::Escape($start) -and $txt -match [regex]::Escape($end)) {
    $pat=[regex]::Escape($start)+"(.*?)"+[regex]::Escape($end)
    $txt=[regex]::Replace($txt,$pat,[System.Text.RegularExpressions.MatchEvaluator]{ param($m) $nav },"Singleline")
  } else { $txt=$nav+"`n`n"+$txt }
  $txt | Set-Content $readme -NoNewline -Encoding utf8; Set-LF $readme; Banner "QUICK-NAV updated"
}
function Ensure-DocsPlaceholders {
  $repoMap="docs\REPO-MAP.md"; $workflows="docs\WORKFLOWS.md"; $ideasDir="docs\ideas"; $ideasIdx="docs\ideas\INDEX.md"
  New-Item -ItemType Directory -Force -Path "docs" | Out-Null; New-Item -ItemType Directory -Force -Path $ideasDir | Out-Null
  if (-not (Test-Path $repoMap)) {
    Add-Content -LiteralPath $repoMap -Value "# Repo Map"
    Add-Content -LiteralPath $repoMap -Value ""
    Add-Content -LiteralPath $repoMap -Value "```mermaid"
    Add-Content -LiteralPath $repoMap -Value "flowchart TD"
    Add-Content -LiteralPath $repoMap -Value "  A[README] --> S[START-HERE]"
    Add-Content -LiteralPath $repoMap -Value "  A --> M[Repo Map]"
    Add-Content -LiteralPath $repoMap -Value "  A --> W[Workflows]"
    Add-Content -LiteralPath $repoMap -Value "  A --> C[CONTRIBUTING]"
    Add-Content -LiteralPath $repoMap -Value ""
    Add-Content -LiteralPath $repoMap -Value "  subgraph Docs"
    Add-Content -LiteralPath $repoMap -Value "    I[docs/ideas/*]:::dir"
    Add-Content -LiteralPath $repoMap -Value "    R[docs/REPO-MAP.md]"
    Add-Content -LiteralPath $repoMap -Value "    WF[docs/WORKFLOWS.md]"
    Add-Content -LiteralPath $repoMap -Value "    SH[docs/START-HERE.md]"
    Add-Content -LiteralPath $repoMap -Value "  end"
    Add-Content -LiteralPath $repoMap -Value ""
    Add-Content -LiteralPath $repoMap -Value "  subgraph Ops"
    Add-Content -LiteralPath $repoMap -Value "    GH[.github/workflows/*]:::dir"
    Add-Content -LiteralPath $repoMap -Value "  end"
    Add-Content -LiteralPath $repoMap -Value ""
    Add-Content -LiteralPath $repoMap -Value "  X[CoModules (canonical modules)]:::ext"
    Add-Content -LiteralPath $repoMap -Value "  I -->|pointer cards| X"
    Add-Content -LiteralPath $repoMap -Value "  M --- R"
    Add-Content -LiteralPath $repoMap -Value "  W --- WF"
    Add-Content -LiteralPath $repoMap -Value "  S --- SH"
    Add-Content -LiteralPath $repoMap -Value "  A --- C"
    Add-Content -LiteralPath $repoMap -Value "  GH:::dir"
    Add-Content -LiteralPath $repoMap -Value ""
    Add-Content -LiteralPath $repoMap -Value "  click R ""REPO-MAP.md"" ""Repo Map"""
    Add-Content -LiteralPath $repoMap -Value "  click WF ""WORKFLOWS.md"" ""Workflows"""
    Add-Content -LiteralPath $repoMap -Value "  click SH ""START-HERE.md"" ""Start Here"""
    Add-Content -LiteralPath $repoMap -Value "  click I ""ideas/INDEX.md"" ""Ideas Index"""
    Add-Content -LiteralPath $repoMap -Value ""
    Add-Content -LiteralPath $repoMap -Value "  classDef dir fill:#eef,stroke:#99c;"
    Add-Content -LiteralPath $repoMap -Value "  classDef ext fill:#efe,stroke:#7a7;"
    Add-Content -LiteralPath $repoMap -Value "```"
    Add-Content -LiteralPath $repoMap -Value ""
    Add-Content -LiteralPath $repoMap -Value "### What's where"
    Add-Content -LiteralPath $repoMap -Value "- **docs/**: repo-facing docs (map, workflows, start-here)."
    Add-Content -LiteralPath $repoMap -Value "- **.github/workflows/**: CI/CD."
    Add-Content -LiteralPath $repoMap -Value "- **CoModules**: canonical modules (pointer cards here)."
  }
  Set-LF $repoMap
  if (-not (Test-Path $workflows)) {
    Add-Content -LiteralPath $workflows -Value "# Workflows"
    Add-Content -LiteralPath $workflows -Value ""
    Add-Content -LiteralPath $workflows -Value "## PR Flow"
    Add-Content -LiteralPath $workflows -Value "```mermaid"
    Add-Content -LiteralPath $workflows -Value "flowchart TD"
    Add-Content -LiteralPath $workflows -Value "  A[Start Here] --> B[RepoAccelerator: local setup]"
    Add-Content -LiteralPath $workflows -Value "  B --> C[Create topic branch]"
    Add-Content -LiteralPath $workflows -Value "  C --> D[Commit (LF-only); pre-commit passes]"
    Add-Content -LiteralPath $workflows -Value "  D --> E[Open PR]"
    Add-Content -LiteralPath $workflows -Value "  E --> F[Review & checks]"
    Add-Content -LiteralPath $workflows -Value "  F --> G[Squash & merge]"
    Add-Content -LiteralPath $workflows -Value "```"
    Add-Content -LiteralPath $workflows -Value ""
    Add-Content -LiteralPath $workflows -Value "## Ideas Flow"
    Add-Content -LiteralPath $workflows -Value "```mermaid"
    Add-Content -LiteralPath $workflows -Value "flowchart TD"
    Add-Content -LiteralPath $workflows -Value "  S[Sources] --> N[New idea stub in docs/ideas/]"
    Add-Content -LiteralPath $workflows -Value "  N --> T[Triage: pointer vs in-repo doc]"
    Add-Content -LiteralPath $workflows -Value "  T -->|Canonical in CoModules| P[Pointer card -> CoModules]"
    Add-Content -LiteralPath $workflows -Value "  T -->|CoCivium-facing| D[Expand doc here]"
    Add-Content -LiteralPath $workflows -Value "  P --> IDX[Update Ideas Index]"
    Add-Content -LiteralPath $workflows -Value "  D --> IDX"
    Add-Content -LiteralPath $workflows -Value "```"
  }
  Set-LF $workflows
  if (-not (Test-Path $ideasIdx)) { Add-Content -LiteralPath $ideasIdx -Value "# Ideas Index"; Add-Content -LiteralPath $ideasIdx -Value "" }
  $files=Get-ChildItem $ideasDir -File -Filter *.md -ErrorAction SilentlyContinue | Where-Object { $_.Name -ne "INDEX.md" } | Sort-Object Name
  $lines=@(); if ($files){ $lines+="## Current ideas"; foreach($f in $files){ $lines+=("- [{0}](./{0})" -f $f.Name) } } else { $lines+="- _No ideas yet_ — add some!" }
  foreach($l in $lines){ Add-Content -LiteralPath $ideasIdx -Value $l }
  Set-LF $ideasIdx
}
try {
  Banner "Preflight"; Abort-GitOps; git fetch origin
  Banner "Docs"; Ensure-DocsPlaceholders
  Banner "Quick-Nav"; Update-QuickNav
  git add docs/REPO-MAP.md docs/WORKFLOWS.md docs/ideas/INDEX.md README.md
  git commit -m "docs: ensure quick-nav + placeholders (safe-bootstrap)"
  if (Get-Command gh -ErrorAction SilentlyContinue) {
    gh pr create --fill --title "docs: map + flows + index" --body "Adds quick-nav and docs placeholders; LF-only. If PowerShell shows >> or red, press Ctrl+C and re-run safe-bootstrap."
  } else { Write-Host "Tip: open a PR from the GitHub UI if desired." }
} catch { Write-Error $_ }
