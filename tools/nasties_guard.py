#!/usr/bin/env python3
import json, os, re, sys, pathlib

CFG = ".github/nasties.rules.json"

def load_cfg():
    with open(CFG, "r", encoding="utf-8") as f:
        return json.load(f)

def list_files(cfg):
    # list tracked files and filter by globs and exclude dirs
    root = pathlib.Path(".").resolve()
    tracked = os.popen("git ls-files").read().splitlines()
    inc = cfg["include_globs"]
    exd = set(cfg.get("exclude_dirs", []))
    files = []
    for rel in tracked:
        p = pathlib.Path(rel)
        if any(part in exd for part in p.parts):
            continue
        ok = False
        for g in inc:
            if p.match(g):
                ok = True; break
        if ok: files.append(p)
    return files

def is_exempt(path, text, cfg):
    # path-based
    rp = str(path).replace("\\","/") + ("/" if path.is_dir() else "")
    for prefix in cfg.get("poetic_paths", []):
        if rp.startswith(prefix) or rp.startswith("./"+prefix):
            return True
    # frontmatter (very light parser)
    if text.startswith("---"):
        end = text.find("\n---", 3)
        if end != -1:
            fm = text[3:end].lower()
            if "poetic: true" in fm: return True
            if "guard_exempt" in fm and "nasties" in fm: return True
    return False

def strip_ignored(text, markers):
    # remove regions between start/end; drop lines with ignore_line
    s, e, l = markers["ignore_start"], markers["ignore_end"], markers["ignore_line"]
    out, skip = [], False
    for raw in text.splitlines():
        line = raw
        if s in line: skip = True
        if not skip and l not in line: out.append(line)
        if e in line: skip = False
    return "\n".join(out)

def main():
    cfg = load_cfg()
    files = list_files(cfg)
    markers = cfg.get("inline_markers", {})
    violations = []
    compiled = []
    for r in cfg["rules"]:
        flags = 0
        if "i" in r.get("flags",""): flags |= re.I
        compiled.append((r, re.compile(r["pattern"], flags)))

    for path in files:
        try:
            txt = pathlib.Path(path).read_text(encoding="utf-8")
        except Exception:
            continue
        if is_exempt(path, txt, cfg): continue
        if markers: txt = strip_ignored(txt, markers)
        lines = txt.splitlines()
        for r, rx in compiled:
            for m in rx.finditer(txt):
                # map match to line/col
                upto = txt[:m.start()]
                line = upto.count("\n")+1
                col  = len(upto.split("\n")[-1]) + 1
                snippet = lines[line-1].strip()
                violations.append((str(path), line, col, r, snippet))

    if violations:
        for path, line, col, r, snippet in violations:
            msg = f"Use '{r['preferred']}' instead of pattern '{r['pattern']}'."
            print(f"::error file={path},line={line},col={col}::{msg}")
            print(f"{path}:{line}:{col}: {snippet}")
        print(f"\nFAILED: {len(violations)} violation(s).")
        sys.exit(1)
    else:
        print("OK: no nasties found.")
        sys.exit(0)

if __name__ == "__main__":
    main()