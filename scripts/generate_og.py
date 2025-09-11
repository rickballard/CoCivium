#!/usr/bin/env python3
# Generates assets/og-autogen.png (1200x630) with colorful starfield + nebula filaments.
from PIL import Image, ImageDraw, ImageFilter, ImageFont
import random, math
W,H=1200,630
def gradient_bg():
    img=Image.new("RGB",(W,H),(0,0,0)); d=ImageDraw.Draw(img)
    cols=[(10,5,30),(20,10,60),(60,10,90),(120,25,120),(25,120,160),(15,180,160),(10,60,150),(15,20,60)]
    for i in range(W):
        t=i/(W-1); i1=int(t*(len(cols)-1)); i2=min(i1+1,len(cols)-1); u=(t*(len(cols)-1))%1.0
        r=int(cols[i1][0]*(1-u)+cols[i2][0]*u); g=int(cols[i1][1]*(1-u)+cols[i2][1]*u); b=int(cols[i1][2]*(1-u)+cols[i2][2]*u)
        d.line([(i,0),(i,H)],fill=(r,g,b))
    return img
def vignette(img,s=0.6):
    ov=Image.new("L",(W,H),0); d=ImageDraw.Draw(ov); cx,cy=W/2,H/2; mr=(cx**2+cy**2)**0.5
    for y in range(H):
        for x in range(W):
            v=int(255*max(0,min((( ( ( (x-cx)**2+(y-cy)**2 )**0.5 )/mr - (1-s))/s),1)))
            ov.putpixel((x,y),v)
    return Image.composite(img, Image.new("RGB",(W,H),(0,0,0)), ov)
def starfield(n=900):
    L=Image.new("RGBA",(W,H),(0,0,0,0)); d=ImageDraw.Draw(L,"RGBA")
    for _ in range(n):
        x=random.randrange(W); y=random.randrange(H); r=random.choice([1,1,1,2,2,3])
        hue=random.random()
        if hue<0.15: col=(255,220,220,240)
        elif hue<0.30: col=(220,240,255,240)
        elif hue<0.45: col=(220,255,235,240)
        else: col=(255,255,255,240)
        d.ellipse((x-r,y-r,x+r,y+r), fill=col)
        if r>=2:
            g=Image.new("RGBA",(r*8,r*8),(0,0,0,0))
            ImageDraw.Draw(g).ellipse((0,0,r*8,r*8), fill=(255,255,255,50))
            g=g.filter(ImageFilter.GaussianBlur(radius=r*1.5))
            L.alpha_composite(g,(x-r*4,y-r*4))
    return L
def nebula(fils=26):
    L=Image.new("RGBA",(W,H),(0,0,0,0))
    for _ in range(fils):
        path=[]; cx,cy=random.randint(100,W-100),random.randint(80,H-80)
        ang=random.random()*6.28318; length=random.randint(200,900); wig=random.randint(40,160); steps=random.randint(60,140)
        for i in range(steps):
            t=i/steps; rr=t*length
            x=cx+math.cos(ang)*rr+math.sin(t*12)*wig*0.6+random.uniform(-3,3)
            y=cy+math.sin(ang)*rr+math.cos(t*10)*wig*0.6+random.uniform(-3,3)
            path.append((x,y))
        c1=random.choice([(255,120,180),(180,120,255),(120,220,255),(255,190,120),(120,255,200)])
        c2=random.choice([(255,80,140),(140,80,255),(80,200,255),(255,160,90),(90,255,180)])
        T=Image.new("RGBA",(W,H),(0,0,0,0)); d=ImageDraw.Draw(T,"RGBA")
        for i in range(len(path)-1):
            t=i/(len(path)-1)
            r=int(c1[0]*(1-t)+c2[0]*t); g=int(c1[1]*(1-t)+c2[1]*t); b=int(c1[2]*(1-t)+c2[2]*t)
            w=int(16*(1-abs(2*t-1)*0.7))+6
            d.line([path[i],path[i+1]], fill=(r,g,b,60), width=w)
        T=T.filter(ImageFilter.GaussianBlur(radius= random.uniform(4,10)))
        d2=ImageDraw.Draw(T,"RGBA")
        for i in range(0,len(path)-1,3):
            t=i/(len(path)-1)
            r=int(c1[0]*(1-t)+c2[0]*t); g=int(c1[1]*(1-t)+c2[1]*t); b=int(c1[2]*(1-t)+c2[2]*t)
            d2.line([path[i],path[i+1]], fill=(r,g,b,90), width=4)
        L=Image.alpha_composite(L,T)
    return L.filter(ImageFilter.GaussianBlur(radius=2.5))
bg=vignette(gradient_bg(),0.6).convert("RGBA")
img=Image.alpha_composite(bg, nebula())
img=Image.alpha_composite(img, starfield())
img=img.convert("RGB")
import os; os.makedirs("assets", exist_ok=True)
img.save("assets/og-autogen.png", "PNG", optimize=True)
print("Wrote assets/og-autogen.png")

# ci: nudge
