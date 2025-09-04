# Trust Policy (seed)
We flag sources that may conflict with CoCivium’s ethics/principles. This scanner is conservative:
- **allow.txt** — domains considered OK (no flag)
- **warn.txt**  — domains that may be OK but need a look (flag: WARN)
- **deny.txt**  — domains we avoid unless explicitly justified (flag: DENY)

Heuristics:
- Links in *this session’s* intake (`intake/*/session_<yyMMdd>`) are scanned.
- Unknown domains (in none of the lists) are treated as WARN until triaged into allow/warn/deny.
