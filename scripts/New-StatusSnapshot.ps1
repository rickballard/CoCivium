Param()
$ts=Get-Date -Format yyyyMMdd_HHmm
$out="notes/admin/status_$ts.md"
New-Item -ItemType Directory -Force notes/admin | Out-Null
$prs=(gh pr list --state open --json number,title,headRefName,createdAt,author | Out-String).Trim()
$iss=(gh issue list --state open --limit 200 --json number,title,labels,createdAt,author | Out-String).Trim()
$brs=(git branch -vv | Out-String).Trim()
$md="# Status snapshot $ts`n`n## Open PRs`n~~~json`n$prs`n~~~`n`n## Open issues`n~~~json`n$iss`n~~~`n`n## Local branches (vv)`n~~~text`n$brs`n~~~"
Set-Content -Path $out -Value $md -Encoding UTF8
