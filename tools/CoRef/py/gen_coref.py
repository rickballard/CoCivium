import re, json, hashlib, datetime, sys, pathlib
ALPH = "0123456789ABCDEFGHJKMNPQRSTVWXYZ"
def base32_crockford(b: bytes) -> str:
    bits = 0; val = 0; out = []
    for by in b:
        val = (val << 8) | by; bits += 8
        while bits >= 5:
            bits -= 5; idx = (val >> bits) & 31
            out.append(ALPH[idx]); val &= (1 << bits) - 1
    if bits: out.append(ALPH[(val << (5 - bits)) & 31])
    return "".join(out)
def hash4(text: str) -> str:
    return base32_crockford(hashlib.sha256(text.encode("utf-8")).digest())[:4]
def canon(text: str) -> str:
    t = text.lower()
    t = re.sub(r"\s+", " ", t).strip()
    t = t.replace("“","\"").replace("”","\"").replace("’","'").replace("‘","'")
    return t
def parse_markdown(md: str):
    lines = md.splitlines()
    path = ""; pindex = 0; entries = []
    for line in lines:
        m = re.match(r"^\s*#{1,6}\s+(.*)", line)
        if m:
            title = m.group(1).strip()
            m2 = re.match(r"^(\d+(?:\.\d+)*)\s+", title)
            if m2: path = m2.group(1)
            pindex = 0; continue
        if line.strip() == "": continue
        pindex += 1
        c = canon(line); h4 = hash4(c)
        entries.append({
            "path": path, "anchor": f"p{pindex}", "hash": h4, "v": "A",
            "label": line[:64].strip(), "concepts": []
        })
    return entries
def main():
    if len(sys.argv) < 3:
        print("Usage: python gen_coref.py <markdown> <namespace> [<doc_id>]"); sys.exit(1)
    md_path = pathlib.Path(sys.argv[1]); ns = sys.argv[2]
    doc_id = sys.argv[3] if len(sys.argv) > 3 else f"{ns}:{md_path.stem}"
    md = md_path.read_text(encoding="utf-8")
    entries = parse_markdown(md)
    out = {
        "doc": doc_id.split(":")[-1], "system": "CoRef", "ns": ns,
        "version": "0.1", "generated_utc": datetime.datetime.utcnow().isoformat()+"Z",
        "entries": entries, "aliases": {}
    }
    out_path = md_path.with_suffix(".coref.json")
    out_path.write_text(json.dumps(out, indent=2), encoding="utf-8")
    print(f"Wrote {out_path} with {len(entries)} entries")
if __name__ == "__main__": main()
