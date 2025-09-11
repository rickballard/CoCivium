import fs from "fs";
import path from "path";

// args: --persona "Name" --tags "a,b,c"
const args = process.argv.slice(2);
function argAfter(flag, def=""){ const i = args.indexOf(flag); return i>=0 && args[i+1] ? args[i+1] : def; }
const persona = argAfter("--persona","CoBotCitizen");
const personaTags = argAfter("--tags","").split(",").map(s=>s.trim()).filter(Boolean);

const OPENAI_KEY = process.env.OPENAI_API_KEY;
if (!OPENAI_KEY) { console.error("Missing OPENAI_API_KEY"); process.exit(1); }

const SYSTEM = `You are contributing one new IdeaCard per run to the CoCivium repository. Output ONLY valid JSON for a single IdeaCard file, no commentary. Keep titles short; include tags, dependencies, and capability_handles. sensitivity=public unless clearly internal.`;
const USER = `Generate ONE high-quality IdeaCard that helps hybrid civic society.
Constraints:
- persona voice: ${persona}
- topic priority buckets to consider (pick one): ["post-capture government recovery","transparent standards adoption","trust & provenance","civic safety drills","education/onboarding","workflow integrity","policy-as-code"]
- do NOT propose implementation; propose the idea at IdeaCard fidelity
- required fields: title, summary, rationale, impact, dependencies (array), tags (array), sensitivity, source_session, capability_handles (array)
Return ONLY the JSON of the card.`;

function extractJson(s){
  if (!s) return null;
  // 1) ```json ... ``` block
  const fence = s.match(/```json\s*([\s\S]*?)\s*```/i);
  if (fence) return fence[1].trim();
  // 2) first {...} block (greedy to last })
  const first = s.indexOf("{");
  const last  = s.lastIndexOf("}");
  if (first >= 0 && last > first) return s.slice(first, last+1);
  return null;
}

async function run(){
  const today = new Date();
  const y = today.getUTCFullYear();
  const m = String(today.getUTCMonth()+1).padStart(2,"0");
  const d = String(today.getUTCDate()).padStart(2,"0");
  const dayRoot = `docs/ideas/${y}-${m}-${d}/auto`;
  const cardsDir = path.join(dayRoot,"IdeaCards");
  fs.mkdirSync(cardsDir, { recursive: true });

  const resp = await fetch("https://api.openai.com/v1/chat/completions",{
    method:"POST",
    headers:{ "Authorization":`Bearer ${OPENAI_KEY}`, "Content-Type":"application/json" },
    body: JSON.stringify({
      model:"gpt-4o-mini",
      temperature:0.7,
      messages:[{role:"system",content:SYSTEM},{role:"user",content:USER}]
    })
  });
  if(!resp.ok){
    console.error("OpenAI error:", resp.status, await resp.text());
    process.exit(1);
  }
  const data = await resp.json();
  const raw = data?.choices?.[0]?.message?.content?.trim();
  const jsonish = extractJson(raw);
  if (!jsonish){
    console.error("Non-JSON AI output:", raw);
    process.exit(1);
  }
  let card;
  try { card = JSON.parse(jsonish); }
  catch(e){ console.error("JSON parse error:", e.message, "\nPayload:\n", jsonish); process.exit(1); }

  // Stamp persona + tags
  card.source_session = `AI Provocation Path — ${persona}`;
  const tagset = new Set([...(Array.isArray(card.tags)?card.tags:[]), ...personaTags.filter(Boolean), persona]);
  card.tags = Array.from(tagset);

  // Ensure required arrays
  if (!Array.isArray(card.dependencies)) card.dependencies = [];
  if (!Array.isArray(card.capability_handles)) card.capability_handles = [];
  if (!card.sensitivity) card.sensitivity = "public";

  // Filename
  const slug = String(card.title||"untitled").toLowerCase().replace(/[^a-z0-9]+/g,"-").replace(/(^-|-$)/g,"");
  const file = path.join(cardsDir, `auto_${slug}.json`);
  fs.writeFileSync(file, JSON.stringify(card,null,2), "utf8");

  // Manifest
  const manifestPath = path.join(dayRoot,"manifest.json");
  let manifest = { date:`${y}-${m}-${d}`, source:"ai-provocation", files:[] };
  if (fs.existsSync(manifestPath)) { try { manifest = JSON.parse(fs.readFileSync(manifestPath,"utf8")); } catch {} }
  const rel = path.join("IdeaCards", path.basename(file));
  if (!manifest.files.includes(rel)) manifest.files.push(rel);
  fs.writeFileSync(manifestPath, JSON.stringify(manifest,null,2), "utf8");

  // README
  const readmePath = path.join(dayRoot,"README.md");
  if (!fs.existsSync(readmePath)) {
    fs.writeFileSync(readmePath, `# AI Provocation — ${y}-${m}-${d}\n\nWeekly trickle inflow (draft PR). Persona: ${persona}\n`, "utf8");
  }

  console.log("Generated:", file, "persona:", persona);
}
run().catch(e => { console.error(e); process.exit(1); });
