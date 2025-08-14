# Preservation Guide

## What to mirror
- Open-licensed papers, standards, and official docs central to CoCivium.
- Critical web pages likely to rot (recorded with date and hash).

## How to mirror
1. Save as `.pdf` or `.md` (for web articles, consider `SingleFile` exports).
2. Add a citation block: title, author, date, URL, access date.
3. Include a `.license.md` file indicating license or fair-use rationale.
4. Name files descriptively with date, e.g., `Holographic_Principle_Susskind_1995_excerpts.pdf`.

## Integrity
- Compute and store SHA-256 in a companion `.sha256` file.
- Avoid storing full copyrighted PDFs unless license allows; prefer excerpts + notes.

## Embedding in Markdown
Use relative links so files render on GitHub:
`[Susskind (1995) Holographic Principle — excerpts](../assets/sources/Holographic_Principle_Susskind_1995_excerpts.pdf)`
