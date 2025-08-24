param(
  [ValidateSet("list","log","count","rerun")][string]$Action="list",
  [string]$WorkflowFile="auto-add-to-project.yml",
  [string]$Owner="rickballard",
  [int]$ProjectNum=3
)
switch($Action){
  "list"  { gh run list --workflow $WorkflowFile --limit 10; break }
  "log"   { gh run view --log; break }
  "count" {
    gh api graphql -F login=$Owner -F number=$ProjectNum `
      -f query='query($login:String!,$number:Int!){ user(login:$login){ projectV2(number:$number){ items(first:1){ totalCount }}}}' `
      --jq '.data.user.projectV2.items.totalCount'
    break
  }
  "rerun" {
    $id = gh run list --workflow $WorkflowFile --limit 1 --json databaseId --jq '.[0].databaseId'
    if($id){ gh run rerun $id }
    break
  }
}
