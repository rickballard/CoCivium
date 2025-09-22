/* insights/assets/js/soundtrack.js */
(function(){
  let audio, started=false;
  function start(src,opts){
    if(started) return; started=true;
    audio = new Audio(src);
    audio.loop = !!(opts && opts.loop);
    audio.volume = (opts && opts.volume!=null) ? opts.volume : 0.35;
    const tryPlay = ()=> audio.play().catch(()=>{});
    tryPlay(); document.addEventListener('click', tryPlay, {once:false});
    document.addEventListener('keydown', tryPlay, {once:false});
    window.__snd = audio;
  }
  window.initSoundtrack = start;
})();
