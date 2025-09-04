(function(){
  function copy(btn){
    const wrap = btn.closest('.do');
    const code = wrap && wrap.querySelector('pre code');
    if(!code) return;
    const text = code.innerText;
    navigator.clipboard.writeText(text).then(()=>{
      const old = btn.textContent;
      btn.textContent = 'Copied';
      setTimeout(()=> btn.textContent = old || 'Copy code', 1000);
    });
  }
  document.addEventListener('click', (e)=>{
    if(e.target.matches('.copy-bottom')) copy(e.target);
  });
})();
