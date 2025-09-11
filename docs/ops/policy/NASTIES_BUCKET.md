<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
# Nasties Bucket

Catalog of phrases/symbols/constructions we actively **block** in canonical docs/assets.

**Default:** block.
**Allowed with explicit exemption:** clearly poetic/quoted passages or files marked exempt.

## Exemptions (surgical, use sparingly)
- **Path-based:** `docs/poetry/**`, `scroll/**` treated as poetic.
- **Frontmatter** (at top of Markdown):
  ---
  poetic: true
  # or
  guard_exempt: ["nasties"]
  ---
- **Inline markers:** `<!-- guard:ignore-line -->`, or wrap with
  `<!-- guard:ignore-start -->` … `<!-- guard:ignore-end -->`

## Blocked (canonical list)
| Item | Preferred | Scope | Rationale | Added |
|---|---|---|---|---|
| “consent before coercion” | **consent not coercion** | docs/site/press | “before” implies sequence; “not” is unambiguous. | 2025-08-28 |

## Process
Propose edits to this file in PRs (label **policy**) and explain why any exemption is needed.







