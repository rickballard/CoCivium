(async function(){
  const nodes = document.querySelectorAll(".gib[data-gib]");
  for(const n of nodes){
    const key = n.getAttribute("data-gib");
    try{
      const res = await fetch(`/site/assets/gib/${key}.svg`, {cache:"force-cache"});
      if(res.ok){ n.innerHTML = await res.text(); }
    }catch(e){ /* keep fallback */ }
  }
})();