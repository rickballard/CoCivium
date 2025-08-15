Param(
  [string]$Src = "notes/migration/source_odt",
  [string]$Dst = "notes/migration/converted"
)
# Resolve pandoc path (handles fresh installs)
$pandoc = (Get-Command pandoc -ErrorAction SilentlyContinue)?.Source
if (-not $pandoc) { Write-Error "Pandoc not found on PATH."; exit 1 }

New-Item -ItemType Directory -Force $Dst | Out-Null

Get-ChildItem $Src -Filter *.odt | ForEach-Object {
  $name = [IO.Path]::GetFileNameWithoutExtension($_.Name)
  $relSrc = Resolve-Path -Relative $_.FullName
  $outDir = Join-Path $Dst "media\$name"
  $tmp  = Join-Path $env:TEMP ("odt2md_" + [guid]::NewGuid().ToString() + ".md")
  $out  = Join-Path $Dst ($name + ".md")

  # Convert with media extraction
  & $pandoc -f odt -t gfm --wrap=none --extract-media="$outDir" --output $tmp -- $_.FullName

  # Minimal front matter
  $front = @(
    "---"
    "title: ""$name"""
    "source_odt_abs: ""$($_.FullName.Replace('\','/'))"""
    "source_odt_rel: ""$($relSrc.Replace('\','/'))"""
    "converted_utc: ""$([DateTime]::UtcNow.ToString('s'))Z"""
    "---"
    ""
  ) -join "`n"

  $body = Get-Content $tmp -Raw
  Set-Content -Path $out -Value ($front + $body) -Encoding UTF8
  Remove-Item $tmp -Force -ErrorAction SilentlyContinue
}
