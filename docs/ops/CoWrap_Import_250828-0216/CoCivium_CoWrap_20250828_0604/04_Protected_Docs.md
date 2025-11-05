<!-- status: stub; target: 150+ words -->
# Protected Docs  -  Default & Alternative

## Default: age + Bitwarden (CoProtect)
- Public key in repo: `.secrets/age.pub`
- Private key stored in Bitwarden: `coagent-age-key`
- Scripts: `tools/CoProtect.ps1` (Protect‑Doc / Open‑Doc)
- README: step‑by‑step including winget/scoop/choco options
- Example: [docs/product/PLAN-PRIVATE-EXAMPLE.md](docs/product/PLAN-PRIVATE-EXAMPLE.md) encrypted to `.age`

**Optional CI guardrail (plaintext leakage)**
- Add a lint to fail if `*.age` peers have unencrypted twins changed in same PR.
- Start as **warning**; promote to fail once teams are comfortable.

## Alternative: SOPS parity (documented, easy to flip)
- Keys: Bitwarden‑managed; `.sops.yaml` policy.
- CI: ensure SOPS files validate and decrypt locally in PR checks.

**Decision:** Default is **age + Bitwarden** (now). Reconsider if dependency on SOPS tooling is desired org‑wide.




