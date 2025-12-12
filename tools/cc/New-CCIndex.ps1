param(
    [Parameter(Mandatory=$true)][string] $CanonMarkdownPath,
    [Parameter(Mandatory=$true)][string] $OutputJsonPath
)
$ErrorActionPreference='Stop'
Set-StrictMode -Version Latest

if (-not (Test-Path $CanonMarkdownPath)) { throw "Missing canon: $CanonMarkdownPath" }

$raw = Get-Content -LiteralPath $CanonMarkdownPath -Raw -Encoding UTF8

# Chunking rule v0: split on "\n---\n" boundaries; fall back to double-newlines.
$chunksRaw = @()
if ($raw -match "(\r?\n)---(\r?\n)") {
    $chunksRaw = $raw -split "(\r?\n)---(\r?\n)"
} else {
    $chunksRaw = $raw -split "(\r?\n){2,}"
}

$chunks = @()
$idx = 1

foreach ($c in $chunksRaw) {
    $t = $c.Trim()
    if (-not $t) { continue }
    if ($t -like '# Cognocarta*') { continue }
    if ($t -like '> Generated*') { continue }

    $id = "CC-{0:D4}" -f $idx

    $obj = [ordered]@{
        id            = $id
        source_file   = [IO.Path]::GetFileName($CanonMarkdownPath)
        section       = ""
        text          = $t
        concept_tags  = @()
        personas      = @()
        tier          = "L1"
        spikiness     = "low"
        evo_pressures = @()
        tensions      = @()
        related_ids   = @()
        status        = "active"
    }

    $chunks += [pscustomobject]$obj
    $idx++
}

$chunks | ConvertTo-Json -Depth 8 | Set-Content -LiteralPath $OutputJsonPath -Encoding UTF8
