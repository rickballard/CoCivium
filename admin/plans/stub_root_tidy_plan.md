# stub_root_tidy_plan

**Purpose:** propose relocating technical noise from repository root to keep the top of README.md front-and-center for non-technical visitors. **No moves have been made yet.** This is a planning doc.

## Principles
- Preserve all existing links (README, docs, workflows).
- Prefer consolidation under \/admin/\ for maintainer-only assets; leave public-facing content at root or \/docs\.
- Add redirects or update links in one sweep when approved.

## Candidates (to review)
- Dotfiles/configs likely to keep at root for tooling (leave in place): \.editorconfig\, \.gitattributes\, \.gitignore\
- Tooling configs that could move under \/admin/configs\ (if tools support custom paths): \.markdownlint*\, \.mdl*\, \.lychee.toml\, \.yamllint.yml\, \.codespell*\
- Internal scripts: \/merge-pr.sh\, \/ko-finisher.ps1\ → maybe \/admin/tools/\
- Histories: already under \/admin/history\
- Anything else flagged by inventory.

## Next steps
1) Approve or strike items above.
2) I will generate a move map and an atomic commit updating all links.
3) Run \	ools/readme-preflight.ps1\ and open PR.
