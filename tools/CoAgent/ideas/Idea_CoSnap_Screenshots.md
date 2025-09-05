# CoAgent idea: CoSnap (screenshot capture & paste)

## Why
Text tails (CoPong) are great, but UI context matters: dialogs, blocked buttons, red banners, diff views, etc.
Screenshots make “what I’m seeing” unambiguous and help when JS paste is blocked.

## What
- `CoSnap` — capture the **active window** to PNG under `~/Downloads/CoCivium-Logs`.
- `CoSnapScroll -Pages N` — grab N PageUp frames and stitch vertically.
- `CoSend -AsImage` — copy PNG to clipboard, focus chat, paste, and send.
- Keep it local; never auto-upload. Clear capture indicator.

## Guardrails (privacy/consent)
- Opt-in only; explicit commands/hotkeys.
- Visible feedback (tray tooltip, toast, or terminal message).
- Store locally; redact path in logs.
- Pre-commit hook to block unintended `.png` commits outside `artifacts/`.

## Implementation (Windows first)
- `user32.dll` (SetForegroundWindow, ShowWindow), `System.Drawing` for capture, `SendKeys` for paste.
- Later: macOS (CGWindowList / Quartz), Linux (X11/Wayland via native tools).

## UX
- Hotkeys (optional): Alt+PrintScreen -> CoSnap; Ctrl+Alt+P -> CoSend -AsImage.
- Plays nicely with CoPong: CoSend (text) by default, `-AsImage` when long/visual.

## Acceptance
- One command reliably captures the active window.
- Pasting works on common chat UIs; if blocked, it opens Explorer on the file.
- Docs in BPOE: a single “how to use it” section.

## Risks
- Flaky focus/paste -> mitigations: small delays, fallback to Explorer.
- Sensitive content -> opt-in, visible indicator, local-only storage.
