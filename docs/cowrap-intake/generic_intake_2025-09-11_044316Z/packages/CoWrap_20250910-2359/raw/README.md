# CoWrap — 20250910-2359

## TL;DR
This bundle captures **what's done**, **what's next**, and **how to continue** without hunting across sessions.

### Key Achievements
- **CoAgent repo (desktop):** initialized, .gitignore hardened for docs/private, encrypted 7z used for any sensitive content.
- **Encrypted private archive:** header-encrypted (-mhe=on), password-managed locally.
- **Backchannel (CoTemp):** inbox/outbox/notes/logs structure live; CoTicker overlay in place; diagnostic and ensure scripts created.
- **CoProfile seed:** staged under modules/CoProfile/seed/CoProfile_Seed with schema/prefs starter.
- **Diagnostics:** STATUS snapshots included in /STATUS.

### What’s Next (high priority)
1. **Home Assistant camera UX**
   - Frigate motion popup(s) on detection; autoclose after **15s**.
   - Lovelace card for quick review + archive link.
   - See /HA/automations.frigate_popup.yaml and /HA/lovelace.frigate_card.yaml.
2. **Backchannel hardening**
   - Optional: switch overlay to **AppBar** (true reserved strip, no window overlap).
   - Optional: re-install periodic **Ensure-CoBackchannel** as a user task (requires elevation) *or* keep HKCU Run autostart.
3. **GitHub remote**
   - Create repo CoAgent in your org, replace placeholder remote, git push -u origin main.

### Guardrails
- **No secrets** in this zip. The /Private contents are exported **only** into the encrypted CoWrap_private_*.7z.
- Keep *plaintext* private materials inside docs/private/ in CoAgent and back them up via encrypted archives only.

### Pointers
- CoAgent root: $RepoPath
- CoTemp root:  $coTemp

See /STATUS for live state at capture time.
