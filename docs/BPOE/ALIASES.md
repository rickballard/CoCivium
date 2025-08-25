# Aliases & Commands (CoStack Kit)

**Canonical**: \CoChatStart\ (base); \CoChat\ (compat).

**Aliases**
- \CoDialogue\ → forwards to \CoChatStart\ (fallback \CoChat\)
- \CoSidecar\ → forwards to \CoChatStart\ (fallback \CoChat\)

**Load order (profile):** dot-source the file that defines \CoChatStart\ **before** \CoVibe.CoLex.ps1\.

**Contract:** aliases are thin wrappers; forward all arguments ($Args); no custom parameter binding in the alias functions.