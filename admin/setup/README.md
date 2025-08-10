# Setup Folder

This folder contains scripts, registry files, and other distribution artifacts used for setting up or upgrading local environments.

## CRLF Preservation for Windows Scripts

Windows `.cmd` batch scripts and `.reg` registry files require **CRLF** (Carriage Return + Line Feed) line endings to run correctly.
If they are converted to LF-only endings (common on Linux/macOS systems), execution can fail or produce unexpected behavior.

### How This Repo Preserves CRLF

- `.gitattributes` includes:
  ```
  # Preserve CRLF for Windows scripts/regs
  *.cmd text eol=crlf
  *.reg text eol=crlf
  ```
- This ensures:
  - When checked out on Windows, files keep `CRLF`.
  - When committed from any OS, Git normalizes them to `CRLF` in the repository.

### Contributor Guidelines

1. **Do not** manually change line endings in `.cmd` or `.reg` files unless fixing actual content.
2. If you see a Git warning about line endings for these files, confirm that `.gitattributes` is present and correct.
3. If adding new `.cmd` or `.reg` files, simply commit them — Git will handle endings automatically.
4. Avoid opening these files in editors that auto-convert endings unless you explicitly disable that behavior.

---

**Tip:** If you work on Linux or macOS and need to create/update `.cmd` or `.reg` files, ensure your editor supports CRLF and respects `.gitattributes`.
