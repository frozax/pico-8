function draw_titlescroll()

 if f<979 then
  
  for y=0,127 do
   if (chance100(25)) str_to_mem_call(0x5f00,"1000010204040506")
   palt(4,true)
   sspr(0,y,128,1,0,y)
   pal()
  end  
 
  if snapshots_drawn then else snapshots_drawn,scrollparams=0,parse_table("0.8_0|1_140|") end
  
  for i,v in pairs(titlescroll_lines) do
  
  camera(f*scrollparams[i][1]-scrollparams[i][2],1-rnd(3))
   
   for l in all(v) do
    params={}
    for c in all(l) do
     add(params,c)
     if (chance100(3)) params[#params]+=4-rnd(8)
    end
    color(titlepatterns[mid(1,128,flr(rnd(200)))]+4*i-4)  
    line(recursify(1,4))
   end
   
  end
  
  flip_to_mem()
 
  camera()
 
  str_to_mem_call(0x5f10,"0001028900818c0c")
  
 else
   
  for k,v in pairs(snapshot_display_timer) do
   if f>v and snapshots_drawn<k then
    repeat
	 current_snapshot=ceil(rnd(#snapshots))
	until snapshot_drawn[current_snapshot]==false	
    snapflash_counter,memstr,snapshots_drawn,vertblink,snapshot_drawn[current_snapshot]=150+rnd(150),{0x0400,snapshots[current_snapshot][1]},k,64,true    
    cor=cocreate(str_to_mem)
   end
  end
  
  if costatus(cor)=="dead" and snapshots_drawn>0 then
   str_to_mem_call(0x5f10,snapshots[current_snapshot][2])

   
   horzblink,a=min(64,vertblink*4),0x6000

   while a<0x7fff do
    l=min(ceil(rnd(200)),0x7fff-a)
    if (chance100(vertblink/4)) memset(a,rnd(256),l)
    a+=l
   end

   if (chance100(vertblink*3)) sspr(0,16,128,112,64-horzblink,64-vertblink,horzblink*2,(vertblink*2)-2)

   vertblink-=1
   if (vertblink<59) vertblink/=1.2

  end
  
 end

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------