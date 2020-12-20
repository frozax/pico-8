function mandelbrot_zoom(zf)

 poke4(0x5f20,0x5e80.4000)
  
 zoom_mod,zoomx1,zoomx2,zoomy={zf%21+21,zf%21},{},{},{}
  
 for i=1,2 do
  add(zoomx1,zoomseg-(zoomseg/21)*zoom_mod[i])
  add(zoomx2,103+1.1905*zoom_mod[i])
  add(zoomy,26+0.2857*zoom_mod[i])
  sspr(0,32*i-32,128,32,zoomx1[i],64,zoomx2[i],zoomy[i])
 end
  
 for x=0,127 do
  for y=1,3 do
   pset(x,90+y,max(0,pget(x,90+y)-y))
  end
 end
 
 clip()
end

function draw_mandeltwister()

cls()
pal()

 if f<661 then
 
  palt(0,false)

  coresume(cor_mand_prep)
  
  if f>=nextprepframe then
  
   nextprepframe+=21
 
   memcpy(0,0x0800,2048)
   memcpy(0x0800,0x4300,2048)
   
   zoomseg=mand_path[n][3]
   
   n+=1
   if n>35 then n=1 end
    
   cor_mand_prep=cocreate(mand_prep_next_frame)

  end
  
  mandelbrot_zoom(f)
 
  clip()
  
  for y=1,29 do
   memcpy(0x7000-y*64,0x7000+y*64,64)
  end
  
  memcpy(0x1000,0x6800,4096)
  
  c=0
  if strobepattern[f%352+1]==true then c=8 end
  cls(c)
  
  if chance100(44) then
  
  memset(0x6000+flr(rnd(128))*64,136,64)

  x=rnd(128)
  line(x,rnd(128),x,rnd(128),8)
  
  end
  
  phase,phase_shade={},{}
  for x=1,128 do
   phase[x]=(0.5+0.5*sin(mid(0.25,0.75,(f-270)*0.003+0.25)))*sin(x*0.0004+f*0.001)
   phase_shade[x]=flr((phase[x]%1)*32+1)
  end  
  
  for i=1,4 do
   oldshade=100 
   for x=1,128 do
    if x%4==1 then newshade=shadetab[i][phase_shade[x]] end
    if newshade==nil then newshade=oldshade end
       
    if (phase[x]+i*0.25)%1<0.5 then
    
     if newshade!=oldshade then
      for j=1,7 do

       pal(j-0,mandpals[i][mid(1,7,j+newshade+mand_flashes[f%352+1])])
       end
     oldshade=newshade
     end
     
     function yval(n)
      return flr(64+45*sin(phase[x]+n+i*0.25))
     end
     
     y1,y2=yval(0.125),yval(0.375)
     
     sspr(x-1,64,1,64,x-1,y1,1,y2-y1)
    end
   end
   
  end
  
 else
 
  if mand_text_prepped==false then
   draw_procedural(proc_mandtext)
   mand_text_prepped=true
  end
  
  for i in all(mandtext) do
   if f>=i[1]+0 then
    if f<i[1]+3 then
     poke(0x5f17,0)
     poke(0x5f10,7)
    end
    l=i[2]
   end
  end    
     
  memcpy(0x6000,0,l)
  
 end
 
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------