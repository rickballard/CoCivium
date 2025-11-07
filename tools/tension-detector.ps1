param(
  [Parameter(Mandatory=$true)] [string] $Repo,
  [Parameter(Mandatory=$true)] [int]    $PR
)
# Pull PR comments + reviews and compute a light divergence heuristic
$all = gh api repos/$Repo/issues/$PR/comments --paginate | ConvertFrom-Json
$rev = gh api repos/$Repo/pulls/$PR/reviews       --paginate | ConvertFrom-Json
$txt = @($all.body) + @($rev.body) | Where-Object { $_ -ne $null }
$words = ($txt -join " ").ToLower()

$neg = @('block','reject','concern','risk','harm','-1','nay','fail','unsafe','roll back','rollback','revert','should not','must not')
$pos = @('approve','looks good','lgtm','agree','okay','ok','+1','aye','safe','ship','merge')

$negC = ($neg | ForEach-Object { ([regex]::Matches($words, [regex]::Escape($_))).Count } | Measure-Object -Sum).Sum
$posC = ($pos | ForEach-Object { ([regex]::Matches($words, [regex]::Escape($_))).Count } | Measure-Object -Sum).Sum

$authors = @{}
foreach($c in $all){ $authors[$c.user.login] = 1 }
foreach($r in $rev){ $authors[$r.user.login] = 1 }

$score = if(($negC+$posC) -eq 0){ 0 } else { [math]::Round(($negC - $posC) / [double]($negC+$posC), 3) }
$result = [pscustomobject]@{
  pr          = $PR
  commenters  = $authors.Keys.Count
  neg_hits    = $negC
  pos_hits    = $posC
  divergence  = $score  # -1..+1 (pos > neg → negative divergence)
}

$result | ConvertTo-Json -Depth 3
