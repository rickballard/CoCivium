# Lessons Learned (Projects v2 + Actions)

- GraphQL `addProjectV2ItemById` is reliable across owner types.
- Use classic PAT in GH_PAT with `repo, project`.
- Author YAML from PS as here-strings to avoid accidental expansion.
- Keep shared ops docs + helpers under `shared/` and vendor via `git subtree` so forks work standalone.
