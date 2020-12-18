function draw_burning_ring()

 if f>1346 then
  for i=1,350 do
   rndx,rndy=rnd(128),rnd(54)
   if sget(rndx,rndy)==15 then sset(rndx,rndy,14) end
  end
 end
 
 circdim,yrotsinq,yrotcosq,zrotsinq,zrotcosq,modamt=8,sin(f*0.001),cos(f*0.001),sin(0.04),cos(0.04),max(0,40/f-1)
 if f>=1408 then circdim=1 end
 
 for c in all(circles) do
  if c.r>0.1 then
   circfill(c.x,c.y,c.r,circdim)
   
  end
 end

 for k,c in pairs(circles) do
  if c.r>0.1 then
   circfill(c.x,c.y+1,c.r-1,circdim+1)
   c.r*=0.95
   c.y-=0.1
   c.x+=0.2*(1-rnd(2))
  end
  if c.r<=0.1 and c.r>0 then
   c.r=-1
   add(circles_free, k)
  end
 end

 camera(0,20)
 
 for i=1,36 do
  
  p3d={}
  for k=1,2 do
   newcoord={}
   for l=1,3 do
    add(newcoord,lines[i][k][l]+modamt*linemods[i][l])
   end
   add(p3d,newcoord)
  end

  p2d={}
  for j in all(p3d) do
   j[1],j[2],j[3]=dot3d_rotate(j[1],j[2],j[3],yrotsinq,yrotcosq,"y")
   j[1],j[2],j[3]=dot3d_rotate(j[1],j[2],j[3],zrotsinq,zrotcosq,"x")
   add(p2d,flatten_point(j[1],j[2]+0.8,j[3]-4.5))
  end
  
  line(p2d[1][1],p2d[1][2],p2d[2][1],p2d[2][2],14)
  
 end
  
 camera()
 
 i=1
 while #circles_free>0 and i<50 do
  x,y=rnd(128),rnd(128)
  if pget(x,y)==14 then
   n=circles_free[1]
   circles[n]={x=x,y=y,r=2+rnd(max(0,f/200-1.5))}
   del(circles_free, n)
  end
  i+=1
 end
 
 if f>1408 then
  memcpy(0x6000,0x6004,4092)
  memcpy(0x7004,0x7000,4092)
  
  for i=1,30 do
   c,y=rnd(128),63+rnd(2)
   line(c-7,y,c+7,y,0)
  end
  
 end
  
 for lp in all(logoparams) do
  params=lp
  pal(15,params[1])
  pal(14,params[2])
  sspr(recursify(3,8))
 end

 pal()

 textexit=669
 if f>704 then textexit=639 end
 df=f%704
 disp=max(0,100/df-3)
 if df>textexit then disp-=1.15^min(35,df-textexit)-1 end

 palt(0,false)

 for txt in all(scn2_texts) do
  if f>txt[1] and f<txt[2] then
   sspr(0,txt[3],txt[4],7,txt[5]+txt[6]*disp,txt[7])
  end
 end

 palt(0,true)
 
 if f>=1408 then
  sspr(16,110,96,5,16,100)
 end
 
 if f>=1406 and f<=1418 then
  cls()
  if f>=1412 and f<=1416 then
   cls(7)

  end
  if f>1414 then
   pal(1,0)
   pal(2,0)
   pal(8,0)
   sspr(0,0,112,54,9,37) 
   for i=1,5 do
    memcpy(0x6800+rnd(0x1000),0x6000+rnd(0x1000),64+rnd(200))
   end
  end
  str_to_mem_call(7040,spr_logo_subtitle)
 end
 
 if f>=1500 and f%5.5<3 then
  cls(7)
 end
 
 poke(0x5f1e,7)
 if f>=1408 then poke(0x5f1e,2) end
 
 poke(0x5f1f,7)
 
end
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------