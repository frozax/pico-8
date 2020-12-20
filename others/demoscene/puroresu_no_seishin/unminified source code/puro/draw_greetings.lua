function draw_greetings()

 cls(15)
 
 curving=0
 
 for i in all(greetings_curvemods) do
  curving+=sin(f*i[1])*(0.5+0.5*sin(f*i[2]))
 end
 
 if f<1300 then
 
  newobj=copy(obj_belt_prerot[f%150+1])
  rotate(newobj,curving*0.1,"y")
  translate(newobj,3*curving,4.2+0.4*sin(f*0.002),-17)
  send_to_queue(newobj)
  render_queue()  
  
  memcpy(0,0x7000,0x0800)
  
 end
 
 memset(0x7100,255,320)  
 
 for i=1,5 do
  if lasers[i].value<1 and f<1309 then
   q=rnd(0.5)
   lasers[i]={
      value=64,
      fade=10+rnd(20),
      p2=20+rnd(30),
      p1=3+rnd(10),
      cosq=cos(q),
      sinq=sin(q),
      p2spd=40,
      p1spd=5
   }
   if f>704 and f%44>22 and f%44<33 then
    lasers[i].value=128
   lasers[i].fade=5+rnd(5)
   lasers[i].p2spd=5
   lasers[i].p1spd=1
   end
  end
 
  lsr=lasers[i]
  
  if lsr.value>1 then
   color(laserpatterns[flr(lsr.value)])
   line(64+lsr.p1*lsr.cosq-3*curving,68+lsr.p1*lsr.sinq,64+lsr.p2*lsr.cosq-3*curving,68+lsr.p2*lsr.sinq)
  end
  
  lasers[i].value-=lsr.fade
  lasers[i].p2+=lsr.p2spd
  lasers[i].p1+=lsr.p1spd
 
 end
 
 sspr(0,48,100,5,14,10-0.25*max(0,f-1316))
 
 if f%176<154 then
 
  if f%176>132 then
   
   memset(3392+rnd(640),255,32)
   memcpy(3392+rnd(640),3392+rnd(640),32)
   
  end
 
  poke4(0x5f20,0x437f.0000)
  
  sspr(64,53,60,10,34,67-(f%176)*0.29)
  sspr(0,53,39,5,45,77-(f%176)*0.265)
  
  clip()
 
 end
 
 palt(15,true)
 
 if anim2_prepped==false then
  if f>1298 then
   for i=1,20 do memset(2048+rnd(1020),255,4) end
  end
  sspr(23,32,105,16,13-4*curving,52)
 end
 
 for _pal in all(roadpals) do
  for i=1,4 do
   pal((i-f)%4+_pal[1],_pal[i+1])
  end
 end  
 
 fillp()

 palt(15,false)
 for y=71+1.03^max(0,f-1250),127 do
  
  if y>75 or y%2==1 then
   sspr(0,y-2,128,1,curving*204.8/(y-64),y)
  else
   line(0,y,127,y,15)
  end
 end
 palt(15,true)
 
 
 if f<1320 then
 
  liftoff=1.03^max(0,(f-1150))-1
  poke4(0x5f00,0x0302.0100)
  poke4(0x5f04,0x0706.0504)
  
  sspr(19,2,96,29,19,69-liftoff)
  memset(0x5f00,15,8)
  sspr(19,2,96,29,19-liftoff,102+liftoff*0.5,96+2.18*liftoff,13,false,true)
 end
 
 palt(0,true)
 
 for i=0,15 do
  pal(i,i)
 end

 if f>greets_refresh*176 then

  greets_refresh+=1
  memstr={3392,spr_greets[greets_refresh]}
  cor=cocreate(str_to_mem)

 end
 
 if f>1342 and anim2_prepped==false then
  anim2_prepped=true
  memstr={0,spr_finishers_2}
  cor=cocreate(str_to_mem)
 end
 
 if f>1372 then
  
  poke4(0x5f12,0x0605.0807)
 
  finisher_trail(0,f-1408)
 end

end
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------