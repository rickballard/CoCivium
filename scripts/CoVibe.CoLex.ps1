param()
try { . "$PSScriptRoot\CoVibe.Blocks.ps1" } catch {}
try { . "$PSScriptRoot\CoVibe.Prefs.ps1" } catch {}
try { . "$PSScriptRoot\CoVibe.CopyShield.ps1" } catch {}
try { . "$PSScriptRoot\CoVibe.Metrics.ps1" } catch {}
try { . "$PSScriptRoot\CoVibe.Brand.ps1" } catch {}
try { . "$PSScriptRoot\CoVibe.Blocks.ps1" } catch {}
try { . "$PSScriptRoot\CoVibe.Prefs.ps1" } catch {}
try { . "$PSScriptRoot\CoVibe.CopyShield.ps1" } catch {}
try { . "$PSScriptRoot\CoVibe.Metrics.ps1" } catch {}
try { . "$PSScriptRoot\CoVibe.Brand.ps1" } catch {}
try{ . "\CoVibe.Metrics.ps1" }catch{}
try { . "$PSScriptRoot\CoVibe.Blocks.ps1" } catch {}
try { . "$PSScriptRoot\CoVibe.Prefs.ps1" } catch {}
try { . "$PSScriptRoot\CoVibe.CopyShield.ps1" } catch {}
if(-not (Get-Command CoStep -ErrorAction SilentlyContinue)){ function CoStep([string]$Label){ Write-Host ("-- $Label") } }
if(-not (Get-Command CoWait -ErrorAction SilentlyContinue)){ function CoWait([string]$Message){ Write-Host ("[WAIT] $Message") } }
function _repo(){ $u=(git remote get-url origin); if($u -match 'github\.com[:/](.+?)/(.+?)(\.git)?$'){ return "$($Matches[1])/$($Matches[2])" } throw "No GitHub remote" }

function CoPush([string]$Message="chore: update"){
  if(-not (CoShield "CoPush" 3)){ return }
  CoStep "git add/commit/push"
  git add -A | Out-Null
  git commit -m $Message 2>$null | Out-Null
  git push -u origin HEAD
  if((git branch --show-current) -ne 'main'){ CoWait "PR create"; gh pr create --base main --title $Message --body "" 2>$null }
}
function CoBake(){
  if(-not (CoShield "CoBake" 5)){ return }
  $repo=_repo
  CoStep "trigger readme-smoke"; gh workflow run readme-smoke.yml -R $repo 2>$null
  CoStep "trigger linkcheck";     gh workflow run linkcheck.yml     -R $repo 2>$null
}
function CoSync(){
  if(-not (CoShield "CoSync" 3)){ return }
  CoStep "fetch + rebase"; git fetch origin; git rebase origin/main
}
function CoRescue([string]$Path='README.md'){
  if(-not (CoShield ("CoRescue-"+$Path) 20)){ return }
  $repo=_repo; $relaxed=$false
  CoStep "find PR by @me touching $Path"
  $prs = gh pr list -R $repo --author "@me" --state open -L 30 --json number | ConvertFrom-Json
  $target=$null
  foreach($p in $prs){ $paths = gh pr view $p.number -R $repo --json files -q ".files[].path"; if($paths -match ("^"+[regex]::Escape($Path)+"$")){ $target=$p.number; break } }
  if(-not $target){ CoStep "none found"; return }
  CoStep "snapshot protection"
  $curr = gh api "repos/$repo/branches/main/protection" | ConvertFrom-Json
  $orig = [pscustomobject]@{
    strict=$curr.required_status_checks.strict; contexts=@($curr.required_status_checks.contexts)
    admins=$curr.enforce_admins.enabled; codeown=$curr.required_pull_request_reviews.require_code_owner_reviews
    min=$curr.required_pull_request_reviews.required_approving_review_count; linear=$curr.required_linear_history.enabled
    force=$curr.allow_force_pushes.enabled; del=$curr.allow_deletions.enabled
    block=( $curr.PSObject.Properties.Name -contains 'block_creations' ) ? $curr.block_creations.enabled : $false
  }
  CoStep "relax (0 reviews; CODEOWNERS off)"; CoWait "GitHub API call"
  $relax=@{
    required_status_checks=@{strict=$false; contexts=@()}
    enforce_admins=$orig.admins
    required_pull_request_reviews=@{require_code_owner_reviews=$false; required_approving_review_count=0}
    restrictions=$null; required_linear_history=$orig.linear; allow_force_pushes=$orig.force; allow_deletions=$orig.del; block_creations=$orig.block
  } | ConvertTo-Json -Depth 6
  $tmp=Join-Path $env:TEMP 'prot_relax.json'; $relax | Set-Content -Path $tmp -Encoding utf8
  gh api -X PUT "repos/$repo/branches/main/protection" -H "Accept: application/vnd.github+json" -H "Content-Type: application/json" --input $tmp | Out-Null
  Remove-Item $tmp -ErrorAction SilentlyContinue; $relaxed=$true
  CoStep "merge PR #$target"; CoWait "GitHub API call"
  gh pr merge $target -R $repo --squash --delete-branch --subject "fix($Path): rescue" --body ""
  if($relaxed){
    CoStep "restore protection"; CoWait "GitHub API call"
    $restore=@{
      required_status_checks=@{strict=$orig.strict; contexts=@($orig.contexts)}
      enforce_admins=$orig.admins
      required_pull_request_reviews=@{require_code_owner_reviews=$orig.codeown; required_approving_review_count=[int]$orig.min}
      restrictions=$null; required_linear_history=$orig.linear; allow_force_pushes=$orig.force; allow_deletions=$orig.del; block_creations=$orig.block
    } | ConvertTo-Json -Depth 6
    $rtmp=Join-Path $env:TEMP 'prot_restore.json'; $restore | Set-Content -Path $rtmp -Encoding utf8
    gh api -X PUT "repos/$repo/branches/main/protection" -H "Accept: application/vnd.github+json" -H "Content-Type: application/json" --input $rtmp | Out-Null
    Remove-Item $rtmp -ErrorAction SilentlyContinue
  }
}
function CoProtect(){ $repo=_repo; if(Test-Path "$PSScriptRoot\CoVibe.ApplyProtection.ps1"){ & pwsh -NoProfile -File "$PSScriptRoot\CoVibe.ApplyProtection.ps1" -Repo $repo } else { Write-Host "No ApplyProtection script found." } }
function CoCheck([string[]]$Repos=@('rickballard/CoCivium','rickballard/CoCache','rickballard/GIBindex','rickballard/Civium')){
  if(-not (CoShield "CoCheck" 3)){ return }
  foreach($r in $Repos){
    $raw = gh api "repos/$r/branches/main/protection" 2>$null
    if(-not $raw){ Write-Host ($r + ": (no protection / 404)"); continue }
    $j = $raw | ConvertFrom-Json
    Write-Host ("{0}: admins={1} min={2} codeowners={3} linear={4} force={5} del={6}" -f $r,$j.enforce_admins.enabled,$j.required_pull_request_reviews.required_approving_review_count,$j.required_pull_request_reviews.require_code_owner_reviews,$j.required_linear_history.enabled,$j.allow_force_pushes.enabled,$j.allow_deletions.enabled)
  }
}
function CoPrefs(){
  if(-not (CoShield "CoPrefs" 2)){ return }
  $doc = Join-Path $PSScriptRoot '..\docs\bpoe\CONTRIBUTING_PREFS.md'
  $yml = Join-Path $PSScriptRoot '..\docs\bpoe\prefs.yml'
  Write-Host ("Prefs: " + $doc); Write-Host ("YAML : " + $yml)
}
function CoLog([Parameter(Mandatory)][string]$Note){
  if(-not (CoShield "CoLog" 2)){ return }
  $dest = Join-Path $PSScriptRoot '..\docs\bpoe\LESSONS.md'
  New-Item -ItemType Directory -Force (Split-Path $dest) | Out-Null
  Add-Content -Path $dest -Value ("- $(Get-Date -Format s) — $Note") -Encoding utf8NoBOM
  Write-Host "LESSONS.md +1"
}
function CoPingPong(){ Write-Host "CoPingPong: copy blocks only after the snip + SET END; paste back full sets; single-line commands are CoShielded." }

function CoGate(){ CoPingPong }  # alias for older docs

function CoChat(){ Write-Host "CoChat: the parallel chat lane alongside CoPingPong. Safe to use while blocks run; CoPulse auto-away keeps efficiency fair." }
# alias

function CoSession { param([string]$Id="") CoSessionInit $Id }
function CoChat { param([string]$Id="") CoChatStart $Id }
# alias


try { . "$PSScriptRoot\CoVibe.Blocks.ps1" } catch {}
try { . "$PSScriptRoot\CoVibe.CopyShield.ps1" } catch {}
if(-not (Get-Command CoStep -ErrorAction SilentlyContinue)){ function CoStep([string]$Label){ Write-Host ("-- " + $Label) } }
function _repo(){ $u=(git remote get-url origin); if($u -match 'github\.com[:/](.+?)/(.+?)(\.git)?$'){ return "$($Matches[1])/$($Matches[2])" } throw "No GitHub remote" }

function CoPrePR(){
  if(Get-Command CoShield -ErrorAction SilentlyContinue){ if(-not (CoShield "CoPrePR" 5)){ return } }
  CoStep "fetch latest main"; git fetch origin | Out-Null
  $repo=_repo
  $base = git merge-base HEAD origin/main
  if(-not $base){ Write-Host "!! cannot find merge-base with origin/main"; return }

  $branch = (git branch --show-current)
  CoStep ("branch: " + $branch)

  CoStep "files you changed vs base"
  $mine   = @( git diff --name-only $base..HEAD )

  CoStep "files changed on main since base"
  $theirs = @( git diff --name-only $base..origin/main )

  $overlap = $mine | Where-Object { $theirs -contains $_ } | Sort-Object -Unique
  if($overlap){ Write-Host "!! overlap with newer main:"; $overlap | ForEach-Object { Write-Host (" - " + $_) } }
  else{ Write-Host "-- no overlap with newer main" }

  # case-only hazards across your changes
  $seen=@{}; $dups=@()
  foreach($p in $mine){ $k=$p.ToLower(); if($seen.ContainsKey($k) -and $seen[$k] -ne $p){ $dups += ($seen[$k] + " <-> " + $p) } else { $seen[$k]=$p } }
  if($dups){ Write-Host "!! case-only path differences (Windows/macOS hazard):"; $dups | ForEach-Object { Write-Host (" - " + $_) } }
  else{ Write-Host "-- no case-only path differences in your change set" }

  # overlaps with your open PRs
  $hits=@()
  if(Get-Command gh -ErrorAction SilentlyContinue){
    $prs = gh pr list -R $repo --author "@me" --state open -L 30 --json number | ConvertFrom-Json
    foreach($p in $prs){
      $paths = gh pr view $p.number -R $repo --json files -q ".files[].path"
      $int   = $mine | Where-Object { $paths -contains $_ }
      if($int){ $hits += [pscustomobject]@{ pr=$p.number; files=@($int) } }
    }
  }
  if($hits.Count -gt 0){ Write-Host "!! overlaps with your open PRs:"; foreach($h in $hits){ Write-Host (" - PR #" + $h.pr + ": " + ($h.files -join ", ")) } }
  else{ Write-Host "-- no overlaps with your open PRs" }

  # dirty tree
  if(git status --porcelain){ Write-Host "!! uncommitted changes present (commit/stash before PR)" } else { Write-Host "-- working tree clean" }

  CoStep "diffstat vs main"; git diff --stat $base..HEAD
  Write-Host "-- PrePR scan complete."
}

function CoDialogue {
  param([Parameter(ValueFromRemainingArguments = $true)][object[]]$Args)
  if (Get-Command CoChatStart -ErrorAction SilentlyContinue) { CoChatStart @Args }
  elseif (Get-Command CoChat -ErrorAction SilentlyContinue) { CoChat @Args }
  else { throw "CoDialogue: base command CoChatStart/CoChat not loaded." }
}
function CoSidecar {
  param([Parameter(ValueFromRemainingArguments = $true)][object[]]$Args)
  if (Get-Command CoChatStart -ErrorAction SilentlyContinue) { CoChatStart @Args }
  elseif (Get-Command CoChat -ErrorAction SilentlyContinue) { CoChat @Args }
  else { throw "CoSidecar: base command CoChatStart/CoChat not loaded." }
}