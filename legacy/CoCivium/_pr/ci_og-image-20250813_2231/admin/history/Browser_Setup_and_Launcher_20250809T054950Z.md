# Browser Setup & Launcher (Chrome, Windows)

**Goal.**  Isolate a clean Chrome profile (“CoCivium”) with the right extensions and startup tabs so our sessions are repeatable and fast.  

---

## Step 1 — Create an isolated Chrome profile
We will launch Chrome with a dedicated **user‑data‑dir** so extensions and settings don’t collide with your daily browser.  

1. Save the provided `Launch_CoCivium_Chrome.bat` anywhere handy (e.g., Desktop).  
2. Double‑click it.  The first run creates the profile directory, then opens a window with install tabs for the recommended extensions and your working tabs.  

---

## Step 2 — Install the extensions
Install only what you trust.  The shortlist we rely on most:

- **Refined GitHub.**  UX fixes and quality‑of‑life features across GitHub.  
- **Gitako — GitHub File Tree.**  Adds a fast file tree for repos and PRs.  
- **MarkDownload — Markdown Web Clipper.**  Save pages as Markdown when needed.  
- **SingleFile.**  Save a whole page to one HTML for archival.  
- **Tab Session Manager.**  Name and restore window/tab sets; autosave on close.  
- **AI Prompt Genius.**  Keep a reusable library of prompts/snippets for priming.  
- **Voice Control for ChatGPT.**  Reliable in‑browser speech‑to‑text and read‑aloud.  

> **Security note.**  Avoid voice extensions that were removed from the Chrome Web Store; some popular ones were delisted in 2024.  Prefer actively‑maintained options.  

---

## Step 3 — Pin startup tabs (optional)
- ChatGPT new chat  
- GitHub `rickballard/CoCivium`  
- Any active Google Doc or Notion page you’re using as a staging area  

---

## Step 4 — Chrome settings (per‑profile)
- **On startup:** Continue where you left off.  
- **Downloads:** Ask where to save each file.  
- **Privacy:** Disable third‑party cookies only if it doesn’t break GitHub.  

---

## Appendix — Local voice input without extensions
If you want to skip extensions for voice, Windows provides **Win+H** dictation.  It’s basic but keeps everything local.  

