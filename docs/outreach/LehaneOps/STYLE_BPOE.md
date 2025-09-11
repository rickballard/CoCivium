# BPOE: CLEAR SEPARATION OF ADVICE VS DO

RULES
- All non-DO guidance must be in a Markdown callout (lines start with "> ").
- DO instructions stay in single, paste-and-run fenced blocks labeled "ONEBLOCK".
- Headings may be plain. Inside code fences, nothing is quoted.

CALL OUT (ADVISORY) EXAMPLE
> This paragraph is advisory context/rationale. It is not executable.

ONEBLOCK (DO) EXAMPLE
    # ONEBLOCK — Example task
    echo "run me as-is"

WHY
- Prevents confusing advice with commands.
- Makes runnable steps visually obvious.
