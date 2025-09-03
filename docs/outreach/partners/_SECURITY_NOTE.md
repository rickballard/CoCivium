# ⚠️ Security Note: Raw Output Logs (`*.odt`) Prohibited

This folder **must never include unredacted PowerShell dumps or raw `.odt` session logs**.

Such files may leak:
- `$env:*` values
- Local file paths
- Toolchain state
- Developer credentials
- YAML headers in use

Always extract only reviewed, scrubbed markdown (`.md`) for sharing.

This rule is enforced by `.gitignore`.

