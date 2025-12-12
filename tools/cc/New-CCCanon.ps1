param(
    [Parameter(Mandatory=$true)][string] $SeedsDir,
    [Parameter(Mandatory=$true)][string] $OutputCanonPath,
    [switch] $AsciiOnly
)
$ErrorActionPreference='Stop'
Set-StrictMode -Version Latest

if (-not (Test-Path $SeedsDir)) { throw "Missing SeedsDir: $SeedsDir" }

$seedFiles = Get-ChildItem -LiteralPath $SeedsDir -Filter 'CC_Seed_*.md' | Sort-Object Name
if (-not $seedFiles) { throw "No CC_Seed_*.md files found in $SeedsDir" }

$sb = New-Object System.Text.StringBuilder
$null = $sb.AppendLine("# Cognocarta Consenti (Canon v0)")
$null = $sb.AppendLine()
$null = $sb.AppendLine("> Generated from Seeds. Edit Seeds, then regenerate.")
$null = $sb.AppendLine()
$null = $sb.AppendLine("---")
$null = $sb.AppendLine()

foreach ($f in $seedFiles) {
    $null = $sb.AppendLine("## " + $f.BaseName)
    $null = $sb.AppendLine()
    $raw = Get-Content -LiteralPath $f.FullName -Raw -Encoding UTF8
    # strip frontmatter-ish headers; keep canon body
    $body = ($raw -split "## Canon Text",2)[-1].Trim()
    $null = $sb.AppendLine($body)
    $null = $sb.AppendLine()
    $null = $sb.AppendLine("---")
    $null = $sb.AppendLine()
}

$text = $sb.ToString()

if ($AsciiOnly) {
    $text = $text.Replace("–","-").Replace("≠","!=")
}

$text | Set-Content -LiteralPath $OutputCanonPath -Encoding UTF8
