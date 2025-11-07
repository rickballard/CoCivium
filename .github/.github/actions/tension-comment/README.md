# Tension → PR comment (composite action)

Renders a `tension.json` file into a Markdown table and comments it on the PR.

## Usage
```yaml
permissions:
  contents: read
  pull-requests: write

- uses: ./.github/actions/tension-comment
  with:
    json: tension.json
    md: tension.md
```
**Notes**
- Requires same-repo `pull_request` context (no forks).
- Uses default `GITHUB_TOKEN`; no extra secrets.
- Exits quietly if `tension.json` is missing.
