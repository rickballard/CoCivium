# === CoAgent.psm1 (consolidated, corrected) ===
function Get-CoAgentStatus {
  param([string[]]$Repos=@("CoCivium","CoCache","GIBindex","Civium"))
  foreach($r in $Repos){
    Write-Host "`n=== $r ===" -ForegroundColor Cyan
    gh pr list    --repo "rickballard/$r" --limit 10
    gh issue list --repo "rickballard/$r" --limit 10
  }
}

function Invoke-CoAgentMergeDocs {
  param([string]$Repo="CoCivium")
  $prs = gh pr list --repo "rickballard/$Repo" --label docs --json number | ConvertFrom-Json
  foreach($p in $prs){
    $id = $p.number
    $files = gh api "repos/rickballard/$Repo/pulls/$id/files" --paginate --jq '.[].filename'
    $docOnly = -not ($files | Where-Object { $_ -notmatch '^(docs/|README|\.github/|assets/|website/)' -and $_ -notmatch '\.(md|gif|png|jpg|jpeg|svg|yml|yaml)$' })
    if($docOnly){ gh pr merge $id --repo "rickballard/$Repo" --squash --delete-branch --auto }
  }
}

function Test-CoRepoPolish {
  param([string]$RepoPath = (Get-Location).Path)
  Push-Location $RepoPath
  try{
    $hasGA = Test-Path ".gitattributes" -PathType Leaf
    $r = [ordered]@{}
    $r.Repo            = Split-Path -Leaf $RepoPath
    $r.GitAttributesLF = ($hasGA) -and ((Get-Content .gitattributes -Raw) -match 'eol=lf')
    $r.IssueChooser    = Test-Path ".github\ISSUE_TEMPLATE\config.yml"
    $r.HeroAssets      = (Test-Path "assets\hero\quote-960w.png") -and (Test-Path "assets\hero\hero.gif")
    $r.CrestMention    = (Test-Path "README.md") -and (Select-String -Path "README.md" -Pattern "CC crest" -SimpleMatch -Quiet)
    $r.TwoEyesMention  = (Test-Path "README.md") -and (Select-String -Path "README.md" -Pattern "Two Eyes" -SimpleMatch -Quiet)
    [pscustomobject]$r
  } finally { Pop-Location }
}

function Invoke-CoAgentPolishScan {
  param([string[]]$Repos=@("CoCivium","CoCache","GIBindex","Civium"))
  $root = Join-Path $HOME "Documents\GitHub"
  $rows = foreach($r in $Repos){ Test-CoRepoPolish -RepoPath (Join-Path $root $r) }
  $rows | Format-Table -AutoSize
}

function Invoke-CoAgentReview341 {
  Set-Location "$HOME\Documents\GitHub\CoCivium"
  $files = gh api repos/rickballard/CoCivium/pulls/341/files --paginate --jq '.[].filename'
  $bad = $files | Where-Object { $_ -notmatch '^(docs/|README|CONTRIBUTING|\.github/)' -and $_ -notmatch '\.(md|png|svg|gif|jpg|jpeg|yml|yaml)$' }
  if($bad){ gh pr comment 341 --body ":warning: Non-doc paths present:`n`n$($bad -join "`n")" }

  $md = $files | Where-Object { $_ -match '\.md$' }
  $hc = New-Object System.Net.Http.HttpClient
  $rx = '\[[^\]]+\]\((?<url>https?://[^)]+)\)'
  $badLinks = @()
  foreach($f in $md){
    $txt = Get-Content $f -Raw
    foreach($m in [regex]::Matches($txt,$rx)){
      $u = $m.Groups['url'].Value
      try{
        $resp = $hc.SendAsync((New-Object System.Net.Http.HttpRequestMessage 'Head',$u)).GetAwaiter().GetResult()
        if(-not $resp.IsSuccessStatusCode){ $resp = $hc.GetAsync($u).GetAwaiter().GetResult() }
        if(-not $resp.IsSuccessStatusCode){ $badLinks += "$f → $u ($($resp.StatusCode))" }
      } catch { $badLinks += "$f → $u (error)" }
    }
  }
  if($badLinks){ gh pr comment 341 --body (":broken_heart: Link check failures:`n" + ($badLinks -join "`n")) }
  gh pr comment 341 --body "CoAgent review pass done. Respond to comments, then we merge."
}

function Invoke-CoAgent {
  param([ValidateSet("status","merge-docs","polish-scan","review-341")] [string]$Cmd="status",
        [string]$Repo="CoCivium")
  switch($Cmd){
    "status"      { Get-CoAgentStatus }
    "merge-docs"  { Invoke-CoAgentMergeDocs -Repo $Repo }
    "polish-scan" { Invoke-CoAgentPolishScan }
    "review-341"  { Invoke-CoAgentReview341 }
  }
}

Export-ModuleMember -Function `
  Get-CoAgentStatus,Invoke-CoAgentMergeDocs,Test-CoRepoPolish,Invoke-CoAgentPolishScan,Invoke-CoAgentReview341,Invoke-CoAgent
# === end ===
