Param(
  [string]$Src = "notes/migration/source_odt",
  [string]$Dst = "notes/migration/converted"
)
if (-not (Get-Command pandoc -ErrorAction SilentlyContinue)) {
  Write-Error "Pandoc not found. Install via winget (`winget install --id=JohnMacFarlane.Pandoc -e`) or Chocolatey (`choco install pandoc`)."
  exit 1
}
New-Item -ItemType Directory -Force $Dst | Out-Null

Get-ChildItem $Src -Filter *.odt | ForEach-Object {
  $name = [IO.Path]::GetFileNameWithoutExtension($_.Name)
  $tmp  = Join-Path $env:TEMP ("odt2md_" + [guid]::NewGuid().ToString() + ".md")
  $out  = Join-Path $Dst ($name + ".md")

  # Convert with Pandoc
  & pandoc -f odt -t gfm --wrap=none --output $tmp -- $_.FullName

  # Add minimal front matter and source pointer
  $front = @(
    "---"
    "title: ""$name"""
    "source_odt: ""$($_.FullName.Replace('\','/'))"""
    "converted_utc: ""$([DateTime]::UtcNow.ToString('s'))Z"""
    "---"
    ""
  ) -join "`n"

  $body = Get-Content $tmp -Raw
  Set-Content -Path $out -Value ($front + $body) -Encoding UTF8
  Remove-Item $tmp -Force -ErrorAction SilentlyContinue
}
