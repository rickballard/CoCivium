# Diagram gallery (example)

Below is a small gallery of key diagrams that could be used on this site.  
Each card links back to the canonical asset tracked in the **Hub graphics inventory**.

<div class="diagram-gallery">

  <div class="diagram-card">
    <a href="/docs/diagrams/cosuite-hub.svg">
      <img src="/docs/diagrams/cosuite-hub.svg" alt="CoSuite hub overview diagram" />
    </a>
    <h3>CoSuite hub</h3>
    <p>Shows the main CoSuite components and how they relate (CoCivium, CoAgent, CoCache, InSeed…).</p>
    <p class="diagram-meta">Source: <code>docs/diagrams/cosuite-hub.mmd</code></p>
  </div>

  <div class="diagram-card">
    <a href="/docs/diagrams/inseed-funnel.svg">
      <img src="/docs/diagrams/inseed-funnel.svg" alt="InSeed engagement funnel" />
    </a>
    <h3>InSeed engagement funnel</h3>
    <p>How prospects move from first contact to active contributor / client.</p>
    <p class="diagram-meta">Source: <code>docs/diagrams/inseed-funnel.mmd</code></p>
  </div>

</div>

---

> CSS hint (wherever your site CSS lives):

```css
.diagram-gallery {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
  gap: 1.5rem;
}

.diagram-card {
  border: 1px solid rgba(0,0,0,0.08);
  border-radius: 8px;
  padding: 1rem;
  background: #fff;
}

.diagram-card img {
  max-width: 100%;
  height: auto;
  display: block;
  margin-bottom: 0.75rem;
}

.diagram-card h3 {
  margin: 0 0 0.35rem;
}

.diagram-meta {
  font-size: 0.8rem;
  opacity: 0.7;
}
