# Brand Poetry — Lead‑ins & Outs (Pattern v1)

> Purpose: set tone (beauty), ground intent (duty), and frame content without overselling.
> Use for: README openings, ONRAMP intros, episode outros.

## Structure (canonical)
1. **Beauty (2–4 lines)** — image or feeling; gentle, human.
2. **Duty (1–2 lines)** — why we’re here; guardrails in one breath.
3. **Content Bridge (1–2 lines)** — “Today we’ll…”
4. **Critique / Honesty (1–2 lines)** — where we’re unsure or cautious.
5. **Call to Co‑Evolve (1 line)** — invite to help; agency without pressure.
6. **Footer (machine‑readable)** — metadata for versioning.

### Footer spec
```yaml
poetry:
  version: 1
  congruence: draft|reviewed|canon
  author: <name or handle>
  date: YYYY‑MM‑DD
  related: [README, ONRAMP, Course, …]
```
> Store under `docs/brand/poetry/*.md`. Use `congruence: reviewed` once a second mind signs off.

## Example (short)
> We tune toward each other in small signals —

> a rhythm light enough to carry.

>

> We build tools that earn trust because they are held by it.

>

> Today: a brief on how to start, and the promises we refuse to break.

>

> We may miss a beat; tell us when we do.

>

> Come play a round of make‑better with us.

---

poetry:
  version: 1
  congruence: draft
  author: you
  date: 2025‑08‑26
  related: [ONRAMP]

