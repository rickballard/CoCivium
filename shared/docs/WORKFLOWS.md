# Workflow: Auto-add Issues & PRs to "Co Stack"

What it does
- On issue/PR open or reopen, look up the user project (Co Stack, #3) and add the item via GraphQL `addProjectV2ItemById`.

Prerequisites
- Actions secret: GH_PAT (classic) with scopes: repo, project.

Troubleshooting quick commands
- List recent runs:   gh run list --workflow auto-add-to-project.yml --limit 5
- Show latest logs:   gh run view --log
- Count project items:
  gh api graphql -F login=rickballard -F number=3 `
    -f query='query($login:String!,$number:Int!){ user(login:$login){ projectV2(number:$number){ items(first:1){ totalCount }}}}' `
    --jq '.data.user.projectV2.items.totalCount'

Notes
- We use GraphQL instead of `gh project item-add` to avoid owner-type issues.
- Keep the job minimal: use `gh` directly; no external actions required.
