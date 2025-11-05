# Protecting Business-Plan Docs (Open-Core + Protected Plans)
We keep code and operational policies open. Some plans (pricing, partner decks, etc.) are stored **encrypted** in-repo as `*.age`.

**Keys**
- Public key is committed under `.secrets/age.pub`.
- Private key is **not** in the repo: it lives in Bitwarden as a Secure Note (name: `coagent-age-key`).

**Workflow (Windows, PowerShell)**
1) Unlock Bitwarden CLI: `bw unlock --raw | Set-Clipboard` then `setx BW_SESSION (paste token)` or set for current session: `$env:BW_SESSION = "<token>"`
2) Open a protected doc: `.\tools\CoProtect.ps1; Open-Doc docs/product/PLAN.md.age`
3) Create/encrypt a new doc: edit a plaintext file, then `Protect-Doc path\to\file.md` (produces `file.md.age` and deletes plaintext).

**Safety**
- Decrypted files are written under `.secrets\\tmp\\` (ignored by Git) and wiped on PowerShell exit.
- No profile edits; session-only behavior.

**Requirements**
- `age.exe` on PATH, Bitwarden CLI `bw.exe`, and `BW_SESSION` unlocked.

_We can later add Git smudge/clean filters or SOPS if needed._


