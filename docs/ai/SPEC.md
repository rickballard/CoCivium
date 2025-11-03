# GIBX spec (v0.1)

- Header: `; <asset-name> v<semver>.gibx`
- Directive: `@key: value`  (unique keys)
- Tag: `#key: value`        (may repeat)
- Comment: `; ...`
- Values: relative paths (preferred) or absolute URLs
- Unknown keys: ignore
- Mirror: a JSON file with the same basename MUST accompany each `.gibx`

JSON mirror schema (example):
{
  "asset": "CoCivium.FRONT_DOOR",
  "version": "0.1",
  "directives": { "frontdoor":"../../README.md", "map":"../links/HIGHLIGHTS.md" },
  "tags": { "license":["CC-BY-4.0"], "norms":[...], "intents":[...], "outputs":[...] }
}
