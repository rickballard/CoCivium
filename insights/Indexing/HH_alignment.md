# Alignment with Hitchhiker Plan (HH) and GIBindex (CoRef)

Goal: concept-first IDs that remain stable when prose changes. Human-visible structure remains readable (1.2.3),
but integrity keys bind to canonicalized content and a concept registry (CR:*).

- Top-down HH index provides the master map of repos and assets.
- Bottom-up CoRef provides addressable anchors at section/paragraph/sentence/list-item level.
- GIBindex stores compressed dictionaries and concept aliases to accelerate AI navigation.
- CoCache consumes sidecars for cross-repo linking.

Bridging rules:
1. Every document has a CoRef sidecar (`*.coref.json`).
2. Every concept has a CR key in the concept registry (`concept_registry.coref.json`).
3. HH master index references docs by repo path and embeds the CoRef `doc_id` and version.
4. When prose moves: update sidecar `aliases` to redirect old CoRef keys to new ones.
5. When concepts evolve: version bump the CR entry and keep a `replaced_by` chain.
