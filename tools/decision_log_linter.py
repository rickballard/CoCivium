#!/usr/bin/env python3
# Minimal Decision Log linter.
# Checks presence of required sections and key metadata lines.
# Exit nonzero on failure.

import sys, re, pathlib

REQUIRED_SECTIONS = [
    r'^## Metadata',
    r'^## Context',
    r'^## Proposal',
    r'^## Considerations',
    r'^## Objections',
    r'^## Decision',
    r'^## Execution',
    r'^## Evidence Links',
    r'^## Dates',
]

REQUIRED_METADATA = [
    r'^- \*\*Proposer:\*\*\s*',
    r'^- \*\*Chair:\*\*\s*',
    r'^- \*\*Recorder:\*\*\s*',
    r'^- \*\*Quorum:\*\*\s*',
    r'^- \*\*Objection Window:\*\*\s*',
]

def lint(path: pathlib.Path) -> list[str]:
    text = path.read_text(encoding='utf-8', errors='ignore')
    problems = []
    for pat in REQUIRED_SECTIONS:
        if not re.search(pat, text, re.M):
            problems.append(f"Missing section: {pat[3:]}")
    for pat in REQUIRED_METADATA:
        if not re.search(pat, text, re.M):
            problems.append(f"Missing metadata: {pat.split('**')[1]}")
    return problems

def main(argv):
    targets = [pathlib.Path(p) for p in argv[1:]] or [pathlib.Path('kits/GLK/templates/Decision_Log.md')]
    all_problems = []
    for t in targets:
        if not t.exists():
            all_problems.append(f"File not found: {t}")
            continue
        probs = lint(t)
        if probs:
            all_problems.append(f"[{t}] " + " | ".join(probs))
    if all_problems:
        for p in all_problems:
            print(p)
        sys.exit(1)
    print("Decision Log linter: OK")
    sys.exit(0)

if __name__ == "__main__":
    main(sys.argv)
