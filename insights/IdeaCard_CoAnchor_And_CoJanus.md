<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
<!-- status: stub; target: 150+ words -->
# IdeaCard — CoAnchor Canonicals & “CoJanus” Switch

**Problem / Tension**  
Some documents need elevated, quasi-immutable status (history, mythos, founding texts). We need edit quorum, versioned legacy retention, and a reversible switch between “current” and “legacy” without saying “A/B”.

**Hypothesis**  
Introduce **CoAnchor** status and a **CoJanus** switch (two-faced: legacy/current). CoAnchor files carry stricter governance and are twin-managed for multi-year comparatives.

**Value / Impact**  
Protects narrative/legitimacy; reduces churn; enables long-horizon study; improves contributor trust.

**Key Design**  
- Front-matter flags: `coanchor: true`, `cojanus: { twin: "<path>" }`, `steward:`, `quorum:`.
- PR checks: steward sign-off + quorum; auto-build twin; banner in footer.
- CLI: `CoJanus New|Flip|Status`.

**Next Steps (90d)**  
- [ ] Add policy + CODEOWNERS + CI checks for CoAnchor.  
- [ ] Implement `CoJanus` script and footer banner pattern.  
- [ ] Migrate existing founding texts to CoAnchor.

**Tags:** #cocivium #governance #docs #canon



