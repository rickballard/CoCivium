# Trust Protocol (v0)
**Input:** Markdown files under `intake/*/session_<yyMMdd>`.  
**Policy:** `docs/bpoe/trust/allow.txt`, `warn.txt`, `deny.txt`.  
**Regex:** `(https?://[^\s\)\]>"]+)` on raw text.

**Classification:**
1. If domain ∈ deny → DENY  
2. Else if ∈ warn → WARN  
3. Else if ∈ allow → OK  
4. Else → WARN (unknown)

**Output (ephemeral, not committed):**
- A summary level (OK/WARN/DENY) and a small list of flagged links with reasons.
- If WARN/DENY, present a “Why?” toggle that shows the domain and policy source (warn/deny/unknown).
