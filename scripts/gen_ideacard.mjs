import fs from "fs";
import path from "path";

const OPENAI_KEY = process.env.OPENAI_API_KEY;
if (!OPENAI_KEY) {
  console.error("Missing OPENAI_API_KEY");
  process.exit(1);
}

// Simple, explicit prompt — no actions, ideas only.
const SYSTEM = `You are contributing one new IdeaCard per run to the CoCivium repository. Output ONLY valid JSON for a single IdeaCard file, no commentary. Keep titles short; include tags, dependencies, and capability_handles. sensitivity=public unless clearly internal.`;

const USER = `Generate ONE high-quality IdeaCard that helps hybrid civic society.
Constraints:
- topic priority buckets to consider (pick one): ["post-capture government recovery", "transparent standards adoption", "trust & provenance", "civic safety drills", "education/onboarding", "workflow integrity", "policy-as-code"]
- do NOT propose implementation; propose the idea at IdeaCard fidelity
- fields required:
  title, summary, rationale, impact, dependencies (array), tags (array), sensitivity, source_session="AI Provocation Path", capability_handles (array)
Return ONLY the JSON of the card.`;

async function run() {
  const today = new Date();
  const y = today.getUTCFullYear();
  const m = String(today.getUTCMonth()+1).padStart(2,"0");
  const d = String(today.getUTCDate()).padStart(2,"0");
  const dayRoot = `docs/ideas/${y}-${m}-${d}/auto`;
  const cardsDir = path.join(dayRoot, "IdeaCards");
  fs.mkdirSync(cardsDir, { recursive: true });

  // Call OpenAI (Responses API / chat completion style)
  const resp = await fetch("https://api.openai.com/v1/chat/completions", {
    method: "POST",
    headers: { "Authorization": `Bearer ${OPENAI_KEY}`, "Content-Type": "application/json" },
    body: JSON.stringify({
      model: "gpt-4o-mini",
      temperature: 0.7,
      messages: [{role:"system", content:SYSTEM}, {role:"user", content:USER}]
    })
  });
  if (!resp.ok) {
    console.error("OpenAI error:", await resp.text());
    process.exit(1);
  }
  const data = await resp.json();
  const raw = data.choices?.[0]?.message?.content?.trim();
  let card;
  try {
    card = JSON.parse(raw);
  } catch (e) {
    console.error("Non-JSON AI output:", raw);
    process.exit(1);
  }

  // Filename from title → slug
  const slug = card.title.toLowerCase()
    .replace(/[^a-z0-9]+/g,"-").replace(/(^-|-$)/g,"");
  const file = path.join(cardsDir, `auto_${slug}.json`);
  fs.writeFileSync(file, JSON.stringify(card, null, 2), "utf8");

  // Minimal manifest
  const manifestPath = path.join(dayRoot, "manifest.json");
  let manifest = { date: `${y}-${m}-${d}`, source: "ai-provocation", files: [] };
  if (fs.existsSync(manifestPath)) {
    try { manifest = JSON.parse(fs.readFileSync(manifestPath, "utf8")); } catch {}
  }
  if (!manifest.files.includes(path.relative(dayRoot, path.join("IdeaCards", path.basename(file))))) {
    manifest.files.push(path.join("IdeaCards", path.basename(file)));
  }
  fs.writeFileSync(manifestPath, JSON.stringify(manifest, null, 2), "utf8");

  // README stub
  const readmePath = path.join(dayRoot, "README.md");
  if (!fs.existsSync(readmePath)) {
    fs.writeFileSync(readmePath, `# AI Provocation — ${y}-${m}-${d}\n\nWeekly trickle inflow (draft PR).`, "utf8");
  }

  console.log("Generated:", file);
}
run().catch(e => { console.error(e); process.exit(1); });
