(()=>{const C=window.CONTACT_CONFIG||{};const END=(window.CONTACT_ENDPOINT||C.endpoint||'').trim();const TO=(C.to||'').trim();const ALLOW=Array.isArray(C.allow)?C.allow:[];const TURN=(C.turnstile_sitekey||'').trim();
const css=.cb-fab{position:fixed;right:18px;bottom:18px;padding:.7rem 1rem;border-radius:999px;background:#2563eb;color:#fff;border:0;box-shadow:0 6px 22px rgba(0,0,0,.25);cursor:pointer;font:600 15px system-ui}
.cb-backdrop{position:fixed;inset:0;background:rgba(0,0,0,.45);display:none;align-items:center;justify-content:center;z-index:9999}
.cb-card{width:min(520px,92vw);background:var(--card,#0f172a);color:var(--fg,#e5e7eb);border:1px solid var(--border,#1e293b);border-radius:14px;box-shadow:0 18px 60px rgba(0,0,0,.4)}
.cb-head{padding:18px 20px;border-bottom:1px solid var(--border,#1e293b);font:600 18px system-ui}
.cb-body{padding:18px 20px}.cb-row{margin:.65rem 0}.cb-row label{display:block;margin-bottom:.3rem;color:#94a3b8;font:500 13px system-ui}
.cb-input,.cb-text{width:100%;padding:.6rem .7rem;border-radius:10px;background:#0b1220;border:1px solid #1f2a44;color:#e5e7eb}.cb-text{min-height:120px;resize:vertical}
.cb-foot{display:flex;gap:.6rem;justify-content:flex-end;padding:16px 20px;border-top:1px solid var(--border,#1e293b)}.cb-btn{padding:.55rem .9rem;border-radius:10px;border:1px solid #1f2a44;background:#0b1220;color:#e5e7eb;cursor:pointer}
.cb-btn.primary{background:#2563eb;border-color:#2563eb;color:#fff}.cb-note{font-size:12px;color:#94a3b8;margin-top:.4rem}.cb-hide{display:none};const s=document.createElement('style');s.textContent=css;document.head.appendChild(s);
const fab=document.createElement('button');fab.className='cb-fab';fab.textContent='Contact';fab.setAttribute('aria-haspopup','dialog');fab.setAttribute('aria-controls','cb-dialog');document.body.appendChild(fab);
const back=document.createElement('div');back.className='cb-backdrop';back.id='cb-dialog';back.innerHTML=<div class="cb-card" role="dialog" aria-modal="true" aria-label="Contact">
  <div class="cb-head">Contact</div>
  <form class="cb-form" novalidate><div class="cb-body">
    <div class="cb-row"><label>Name<input class="cb-input" name="name" required></label></div>
    <div class="cb-row"><label>Email<input class="cb-input" type="email" name="email" required></label></div>
    <div class="cb-row"><label>Subject<input class="cb-input" name="subject" required></label></div>
    <div class="cb-row"><label>Message<textarea class="cb-text" name="message" required></textarea></label></div>
    <input class="cb-hide" name="website" tabindex="-1" autocomplete="off">
    <div class="cb-row"><label><input type="checkbox" name="consent" required> I consent to being contacted.</label><div class="cb-note">No newsletters. No resale.</div></div>
    <div class="cb-row " id="cb-turnstile"></div></div>
    <div class="cb-foot"><button type="button" class="cb-btn" data-act="cancel">Cancel</button><button class="cb-btn primary">Send</button></div></form></div>;
document.body.appendChild(back);
const open=()=>{back.style.display='flex'};const close=()=>{back.style.display='none'};fab.addEventListener('click',open);back.addEventListener('click',e=>{if(e.target===back)close()});back.querySelector('[data-act="cancel"]').addEventListener('click',close);
if(TURN){const t=document.createElement('script');t.src='https://challenges.cloudflare.com/turnstile/v0/api.js';t.async=true;t.defer=true;document.head.appendChild(t);const slot=back.querySelector('#cb-turnstile');const mount=()=>window.turnstile&&window.turnstile.render(slot,{sitekey:TURN,theme:'auto'});t.onload=mount;setTimeout(mount,1500)}
back.querySelector('.cb-form').addEventListener('submit',async ev=>{ev.preventDefault();const fd=new FormData(ev.currentTarget);if(fd.get('website')){close();return}
const payload={to:TO||'',name:String(fd.get('name')||''),email:String(fd.get('email')||''),subject:String(fd.get('subject')||''),message:String(fd.get('message')||''),consent:!!fd.get('consent'),origin:location.origin};
try{const r=await fetch(END,{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify(payload)});if(!r.ok)throw new Error('HTTP '+r.status);alert('Thanks — message sent.');ev.currentTarget.reset();close()}catch(e){console.error(e);alert('Sorry, send failed. Try again later.')}});window.ContactWidget={open,close};})();
