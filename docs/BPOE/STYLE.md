# Path & Separator Style

- Use **forward slashes** (`/`) for repo paths, URLs, and globs: e.g. `/proposals/**`.
- Show **Windows paths** only when you truly mean local filesystem locations, and pair with POSIX:

  - Windows: `%USERPROFILE%\Documents\CoCiviumLogs\preflight_latest.log`
  - macOS/Linux: `~/Documents/CoCiviumLogs/preflight_latest.log`

- Avoid trailing backslashes in Markdown—they can act as escapes or cause hard line breaks.

## Linking & references — Best Practice (BP)

**Goal:** stable references, reproducible context, fewer broken links.

- **Within the same repo (living docs):** use **relative links** like docs/file.md.
  - Keeps links working in forks and feature branches.
- **Anything that must not drift** (decision logs, strategy snapshots, cross-repo refs, or line-specific citations):
  - Use **GitHub permalinks pinned to a commit SHA**.
  - How: open the file on GitHub, press y (URL freezes to SHA), copy that URL.
- **Cross-repo links:** always use **permalinks** (SHA or tag).
- **Images:** prefer relative repo paths. For cross-repo permanence, use SHA-pinned raw URLs.
- **Avoid ../ chains** in top-level docs; restructure or link by permalink.
- **Separators:** Use / for repo paths/globs; backslashes only for true Windows filesystem examples.

