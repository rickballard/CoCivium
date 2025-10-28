# BPOE Seed Rules (short)
- Prefer PRs over zips for repo-native work; use zips only for cross-session “advice-bombs”.
- Auto-merge on; squash-only; delete branch on merge.
- JSON is canonical for diagrams; Mermaid/D2 blocks are generated; do not hand-edit.
- Keep docs lint-clean (markdownlint/codespell); add proper nouns to \.codespell.words\.
- Keep YAML tidy; CI workflows fail PRs on drift (yamllint).
