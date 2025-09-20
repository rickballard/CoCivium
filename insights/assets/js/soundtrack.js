/* insights/assets/js/soundtrack.js */
(function(){
  let audio, started = false;
  function start(src, opts){
    if (started) return;
    started = true;
    audio = new Audio(src);
    audio.loop = !!(opts && opts.loop);
    audio.volume = (opts && opts.volume!=null) ? opts.volume : 0.35;
    audio.play().catch(()=>{}); // some browsers need explicit user click; we re-attempt on next interaction
    document.addEventListener('click', () => audio.play().catch(()=>{}), {once:false});
    document.addEventListener('keydown', () => audio.play().catch(()=>{}), {once:false});
  }
  window.initSoundtrack = start;
})();
