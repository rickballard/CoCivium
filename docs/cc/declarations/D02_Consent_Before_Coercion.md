# D-02 Consent Before Coercion

**Principle.** Authority expands only with **informed, revocable** consent; defaults minimize intrusion.

**Guarantees**
- Opt-in for new data uses or enforcement powers.
- One-click withdrawal (with published effects).
- No retaliation for refusal, beyond a proportionate loss of the consented feature.

**Implementations**
- Versioned consent records; change diffs presented at renewal.
- Data collection follows purpose-binding; unrelated use requires fresh consent.

**Checks**
- CI gate fails if purpose changes lack a matching consent migration.