function plasmaprep()
  
 str_to_mem_call(4608,spr_plasma_yellow)
 str_to_mem_call(7680,spr_plasma_green)
 
 cor2=cocreate(cor_plasmaprep)
 
end

function cor_plasmaprep()
 
 setpix_table=parse_table("1_0|2_1|3_1|8_2|11_3|9_8|10_9|")
 for i=1,10 do
  for j=0,9 do
   for x=0,7 do
    for y=0,7 do
     getx,gety,darker,comp=j*8+x,72+y,0,(i+1)/0.55+x+y
     setx,sety=getx+i*80,gety
     if comp>17 then
      getx+=32
      gety+=48
     end
     if comp<19 and comp>16 then
      darker=1
      if comp<18 and comp>17 then darker=2 end
     end
     while setx>127 do
      setx-=128
      sety+=8
     end
       setpix=sget(getx,gety)
     while darker>0 do
        for spx in all(setpix_table) do
         if setpix==spx[1] then setpix=spx[2] end
        end
      darker-=1
     end
     sset(setx,sety,setpix)
    end
   end
  end
 end
end

function draw_flower()
 
 lagcheck=true
 
 pixnum=flr(f/176)+1
 if flowerpix_set[pixnum]==true then
  sspr(64,0,34,34,64,0)
 else

  str_to_mem_call(0,spr_flowerpix)
  sspr(32*pixnum-32,0,32,32,65,1)
  rect(64,0,97,33,5)
  flowerpix_set[pixnum]=true
  
  if (pixnum==2) plasmaprep()
 
 end 
 
 for ring=1,35 do
  z=35+(f+3.1*ring)%108.5
  zflat=1.03^z
  for seg=1,5 do   

   if z<f+70 and z>f-550 and zflat<24 then
    q=seg/5+0.22*(sin(f*0.003+z*0.01))+ring/35
    x,y=satellite_2d(zflat,q)
    color(flower_grad[mid(1,128,flr(110-z+min(0,f-90)))])
    circfill(32+x,32+y,z*0.07)
    fillp()
   end
  end
 end
 
 memcpy(0,0x6000,4096)
 cls()
 
 memset(0x6840,255,0x1000)
 for i=1,min(12,(704-f)*0.5) do
  y=rnd(128)
  color(0)
  if y<32 or y>96 then color(15) end
  line(0,y,127,y)
 end
 for i=1,3 do
  q=i/3+f*0.0043
  --x,y=13*cos(q),13*sin(q)
  x,y=satellite_2d(13,q)
  sspr(0,0,64,64,32+x,32+y)
 end
 
 for i=0,24,8 do
 
  disp=-1
  if i%16<8 then disp=1 end
 
  function flower_calc(n)
   return 48+32*sin((f+i)*n)
  end
  
  y,x=flower_calc(pix_speeds[pixnum][1]),flower_calc(pix_speeds[pixnum][2])+disp*1.1^max(0,f-585)
 
  memcpy(2176,0x6000+flr(y)*64,2240)
 

  str_to_mem_call(0x5f00,"10010203140e050608090a0b0c0d0e00")   
  sspr(x,34,35,35,x,y)   
  
  str_to_mem_call(0x5f00,"100102031400000008090a0b0c0d0e00")
  sspr(64,0,34,34,x+2,y+2)
    
  str_to_mem_call(0x5f00,"100102031405060708090a0b0c0d0e0f")  
  sspr(64,0,34,34,x,y)
    
 end
 
 str_to_mem_call(0x5f10,"0001020304888e0a08090a0b0c0d8280")
 
 if f%176<rnd(15) and f<700 then
  str_to_mem_call(0x5f10,"8e010203048e0a0708090a0b0c0d8207")  
  memcpy(0x6000+rnd(6192),0x6000+rnd(6192),2000)
 end
 
 if f>627 then plasma(f2) end
 
 for i=1,4 do
  if f>=plasma_flashes[i] and f<plasma_flashes[i]+3 then rectfill(32*i-32,32,32*i-1,96,10) end
 end

end
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------