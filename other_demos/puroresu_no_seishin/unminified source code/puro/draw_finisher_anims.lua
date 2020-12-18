function write_bigfont(string,y)
 
 x,bigfont_charset,bigfont_charmap=0,"abdefghiklmnorstuvwy19","3333333133533333335323"

 function bigfont_setskip()
  return tonum(sub(bigfont_charmap,n,n)*3)
 end
 
 for i=1,#string do
 
  n,nx,ny=1,0,48
  char=sub(string,i,i)
  if char==" " then x+=3 else
   while sub(string,i,i)!=sub(bigfont_charset,n,n) and n<=#bigfont_charset do
    nx+=bigfont_setskip()
    n+=1
    if nx>98 then
     nx,ny=0,63
    end
     
   end
   
   sspr(nx,ny,bigfont_setskip(),15,x,y)
   x+=bigfont_setskip()+3
  end

 end
 
end

function grads(u,d,ym,fmult,palette,grad,dissolve_start,dissolve_end)

 function gradlines(s,e,ymult) 
  for y=s,e do
   color(grad[flr((128+y*ymult-f*fmult)%128)+1])
   rf=f+rnd(30)
   if mid(rf,dissolve_start,dissolve_end)==rf then line(0,y,127,y) end
  end
 end

 str_to_mem_call(0x5f10,palette)
  
 gradlines(0,u,ym)
 
 gradlines(d,127,-ym)
 
 for i=-7,0 do
  for i2=1,i+8 do
   x,x2=rnd(128)-8,rnd(128)-8
   line(x,u+i,x+16,u+i,0)
   line(x2,d-i,x2+16,d-i,0)
  end
 end

end

palshift_table=parse_table("0_0_0_0_0_-3_0_5_0|")
function finisher_anim(i,f)

 palshift_amount=palshift_table[scn]
  if f>=i*176-36 and f<i*176+176 then
  for s in all(anim[i+1][mid(1,5,ceil((f-i*176)/11))]) do
   pal(7,s[1]-palshift_amount)
   if f>10 then poke(0x5f1f,2) end
   camera(-1.18^(i*176-f)+1.2^(f-i*176-126))
   if f%176>44 and f%176<=72 then
    camera(5-rnd(10))
    poke(0x5f1f,rnd(16))
   end   
   params=s
   sspr(recursify(2,7))
  end
 end
 camera()
end

function finisher_trail(anim_index,f)
 trailstart,trailend=f,f
 if f>anim_index*176+126 then trailend-=10 end
 if f<anim_index*176 then trailstart+=10 end
 for j=trailend,trailstart,0.5 do
  finisher_anim(anim_index,j,palshift)
 end
end

function draw_finisher_anims()

 fillp()
 pal() 
 
 if f>textrefresh then
  for k,v in pairs(texts[textnum]) do
   write_bigfont(tostr(v),63+15*k)
  end
  textrefresh+=176
  textnum+=1
  memcpy(4992,29568,2880)
  cls()
 end

 poke4(0x5f1c,0x0f01.8180)
 
 for p in all(gradtable) do
  
  p[7],p[8],p[17],p[18]="00818202",fg_red_gradient,"00018c0c0f",fg_blue_gradient
  params=p
  if f>p[1] and f<=p[2] then grads(recursify(3,10)) end
  if f>p[11] and f<p[12] then grads(recursify(13,20)) end
 end
 
 fillp()

 for anim_index=0,3 do
  finisher_trail(anim_index,f)
 end
 
 function bigfont_overlay(startf,ready,width,writey)
  palt(14,true)
  ftext=f-startf
  if ftext>44 and ftext<119 then
   lean=0.0052*ftext-0.1768
   for y=0,14 do
    if ftext>104 and chance100(44) then camera(8-rnd(16),3-rnd(6)) end
    if ftext<=104 or chance100(40) then
     for i=0,1 do
      lcol=8
      if chance100(10) then lcol=9 end
      if ftext<50 then lcol=7 end
      if i==0 then lcol=1 end
      pal(15,lcol)
      sspr(0,ready+y,width,1,64-0.5*width-lean*(y-7)+i,writey+y)
     end
    end
    camera()
   end
  end
 end
 
 for overlay in all(overlay_params) do
  params=overlay
  bigfont_overlay(recursify(1,4))
 end

 str_to_mem_call(0x5f1c,"80858d")
  
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------