# CONTRIBUTING (light)
- Branch: \eat/*\, \ix/*\, \infra/*\
- One PR = one intent; small diffs.
- Run local checks if possible; otherwise rely on CI (§BPOE_SEED_RULES).
- If CI fails:
  - markdownlint: blank lines around headings/lists; fence close; ≤80 cols when easy.
  - codespell: fix typos or whitelist in \.codespell.words\.
  - yamllint: 2-space indent, no trailing spaces.
