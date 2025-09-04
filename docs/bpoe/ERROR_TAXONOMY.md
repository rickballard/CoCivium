# BPOE Error Taxonomy (v1)

- PASTE_TRUNCATION: User paste interrupted or block partially copied.
- HERESTRING_EXPANSION: Double-quoted here-string expanded vars while writing file.
- PIPELINE_SCOPE: `$_`/scope mismatch inside `switch` or pipeline block.
- UNSET_VAR: Variable used before assignment due to prior error.
- IO_PATH: Path missing or file system permission/lock.
- CLASSIFIER_MISS: Heuristics misclassified an intake item.

Each log line (NDJSON) SHOULD include: ts, stage, item, message, category, target, script, line, psver, cwd.
