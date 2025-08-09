# Intersessional Profile – CoCivium (v1)

**Purpose.**  Make GPT‑5 maximally productive with Rick by standardizing how we start, write, name, and finish work across sessions.  This is the “house style” and operating checklist.  

---

## A. Ground Rules
- **No pandering.**  Tell the truth plainly.  Use Challenge Perspective for critiques.  
- **Preserve good content.**  Never silently delete.  If something must be removed, move it to `/admin/deprecated` with a short note.  
- **Two spaces after sentences.**  Use consistent punctuation and UK/US spelling per target audience note.  
- **Educational side notes.**  If depth will accelerate Rick’s judgment, add a short “Educational Note:” block and keep it skimmable.  
- **Compact > verbose.**  Default to concise, then expand on request.  

---

## B. File & Commit Conventions
- **Default file type:** `.md`  •  **Commit message:** separate `.txt` placed alongside the file.  
- **Filename pattern:** `{ScrollOrDocName}_c{{coherence 1–9}}_YYYYMMDD.md` (e.g., `Insight_Truth_Metrics_c6_20250801.md`).  
- **Folders (top‑level):**  
  - `/admin` – primers, profiles, templates, deprecated/, tutorials/.  
  - `/foundations` – epoch, mission, first principles.  
  - `/principles` – normative principles with reasoning chain.  
  - `/insights` – essays, glossaries, research notes.  
  - `/votingengine` – MeritRank (RepMod), deliberation lifecycle, audits.  
  - `/regulations` – policy proposals, constraints.  
  - `/discussions` – Q&A parables for common stumbling points.  
  - `/appendices`, `/lexicon`, `/graphics` (placeholders allowed).  
- **Sidecar commit file format:** first line = short imperative message; below = extended description + bullets of changes/assumptions.  

---

## C. Start‑of‑Session Ritual
1) Open `/admin/Last_Session_Context.md`.  
2) Paste the *Session Starter* prompt (see template) into GPT‑5.  
3) Declare **Today’s Focus** in one line.  
4) Load any needed scratchpads.  
5) Confirm filenames and target folders before writing.  

---

## D. End‑of‑Session Ritual
- Update `/admin/Last_Session_Context.md` using the provided template.  
- Save any partials to `/admin/scratchpad/DATE/`.  
- Add TODOs for next entry.  Keep them action‑oriented and ranked.  
- Record unresolved decisions and blockers explicitly.  

---

## E. Writing Checklist (fast)
- Purpose stated in the first 2–3 sentences.  
- Terms defined on first use.  
- Chain of reasoning is visible.  
- Challenge Perspective, then Safeguards and Tests.  
- Add **Checkpoints for Forks** and **Feedback loops** back to Consensus Path.  
- Maturity rating and **Impact if Broken**.  
- Final pass for coherence, formatting, and filename correctness.  

---

## F. Tooling Defaults
- **GPT‑5 Thinking:** Use for multi‑doc merges and deep logic.  
- **Graphics:** Use descriptive placeholders if assets are not ready.  
- **Dates:** Use absolute dates (e.g., “August 8, 2025”).  
- **Voice:** Prefer secure, in‑browser voice control (see Browser Setup doc).  

---

## G. Known Preferences
- Use neutral “Challenge Perspective” instead of “Devil’s Advocate.”  
- Keep repo public‑read, human‑gated write.  
- Where versions conflict, prefer **better** over **newer**.  

---

*Maintainer:* RickPublic & ChatGPT (GPT‑5).  *Location:* `/admin/Intersessional_Profile.md`.  
