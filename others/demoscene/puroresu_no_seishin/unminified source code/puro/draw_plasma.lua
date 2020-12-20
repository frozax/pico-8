function plasma(plasma_f)

 mod2=0.7*sin(plasma_f*0.003)
 
 
 for i in all(plasmaedgetimer) do
  if plasma_f<i[1] then rightedge=i[2] end
 end
 
 if plasma_f<0 then rectfill(0,30,10+8*rightedge,96,0) end

 for x=0,rightedge do

  shadefade,mod1,mod3=10*round(mid(0,10,-5*(sin((mid(0,10,x-17*(sin(plasma_f*0.0038+0.9))+2)/2+7.5)/10)-1))),0.2*cos(x*0.05-plasma_f*0.0013),0.07*cos(x*0.05-plasma_f*0.0088)
  
  for y=0,7 do
   v=mid(0,9,6+4*cos(y*0.03+plasma_f*0.007+mod1)+2*cos(y*0.03+mod2+mod3))+shadefade
   if plasma_f>=616 then v=max(0,5+rnd(10)-(plasma_f-616)/5)+100*flr(rnd(2)) end
   spr(144+v,x*8,32+y*8)
  end
  
 end
 
end

function draw_plasma()
 
 y2,picnum=32,flr(f/176)
 plasma(f2)
 
 if f<616+rnd(80) then
  linelength=1.08^min(f,65)-2
  line(-1,31,linelength,31,7)
  line(128-linelength,97,128,97,7)
 end
 
 if f>176 and f<616 then
  
  if f%176>=22 and f%176<88 then
  
   if (f%176<36) camera(-20+rnd(40),0)
   
   for y=0,64 do
    if chance100(100-50*0.5^(f%176-26)) then
     memset(0x5f00,0,16)
     poke4(0x5f00,0x0000.1000)
     sspr(0,y,128,1,0.07*(f%176-22),32+y)
     pal()
     poke4(0x5f00,0x0302.1000)
     sspr(0,y,128,1,0,32+y)
    end
   end
   
   camera()
   
   if f%176<26 then    
    if picture_inited<picnum then
     str_to_mem_call(0,spr_plasma_picture[picnum]..spr_plasma_text[picnum])
     picture_inited=picnum
    end
    memset(0x6800,119,4096)
   end
   
   sspr(0,65,128,5,0,99)
   
  end
   
  if f%176>=88 and f%176<100 then
  
   poke4(0x5f00,0x0302.1000)
   poke4(0x5f20,0x6180.2100)
   
   while y2<97 do
	h=min(flr(rnd(6))+2,97-y2)
	sspr(0,y2-32,128,h,6-rnd(12),y2+6-rnd(12))
	y2+=h
   end
   
  end
 
 end 
 
 if f>=616 then
 
  pal()
  
  poke4(0x5f00,0x0302.1000)
  if flashimage==4 then
   for j=1,7 do
    pal(j-0,mandpals[1][j])
   end
   camera(0,1)
  end
  
  if (chance100(40)) memset(0x5f02,7,14)
  if (chance100(75)) sspr(0,0,128,65,32-rnd(64),32)

  
  for i=flashimage,4 do
   if f>=newsprites[i] then
   
    memset(0x6800,119,4096)
    flip()
   
    memstr={0,spr_plasma_picture[flashimage]}
    cor2=cocreate(str_to_mem)
    flashimage=i+1

   end
  end
  
  if chance100(30) then
  
   l=rnd(8191)
   memcpy(0x6000+rnd(0x1fff-l),0x6000+rnd(0x1fff-l),l)
   
  end
  
 end
 
 camera()

end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------