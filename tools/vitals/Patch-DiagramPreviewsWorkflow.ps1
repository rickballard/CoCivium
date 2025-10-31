param()

$ErrorActionPreference='Stop'
$root = (git rev-parse --show-toplevel)
$wf   = Join-Path $root ".github/workflows/diagram-previews.yml"
if(!(Test-Path $wf)){ throw "Workflow not found: $wf" }
$text = Get-Content -Raw -- $wf

# add workflow_dispatch under "on:"
if($text -notmatch '(?m)^\s*workflow_dispatch\s*:'){
  $text = $text -replace '(?ms)^on:\s*(\r?\n)', "on:`n  workflow_dispatch:`n"
}

# force puppeteer config flag for mmdc
$text = $text -replace 'mmdc -i "\$f" -o "\$out" --backgroundColor transparent(\s*)',
                 'mmdc -i "$f" -o "$out" --backgroundColor transparent -p .github/puppeteer.config.cjs$1'

# ensure _previews/** is force-added
if($text -notmatch '(?m)^\s*add_options:\s*"-f"\s*$'){
  $text = $text -replace '(?ms)(file_pattern:\s*docs/diagrams/_previews/\*\*[^\r\n]*)(\r?\n)',
                   "`$1`n          add_options: `"-f`"`n"
}

Set-Content -Encoding UTF8 -- $wf $text
Write-Host "Patched: $wf"
