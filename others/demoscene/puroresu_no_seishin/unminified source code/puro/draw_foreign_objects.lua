function draw_foreign_objects()

 subpart=min(4,ceil(f/176))
 
 if subpart==4 then
  if scene6_transition_inited then else
   str_to_mem_call(0,spr_finishers_1)
   scene6_transition_inited=true
  end
  finisher_trail(0,f-704)
 end
 
 function trigonometric_interpolation(wavelength,phase)
  return sin(0.75+mid(0,wavelength/2,phase)/wavelength)
 end
  
 n,w=trigonometric_interpolation(100,f-630),33*trigonometric_interpolation(40,f-670)

 y1=46-16*n 
 y2=81+17*n
 
 rect(31-w,y1,97+w,y2,14)
 if w>-33 then rectfill(32-w,y1+1,96+w,y2-1,0) end
 
 clip(32-w,y1+1,63+2*w,y2-y1-1)

 for i=1,10 do
  pal()
  if (i<5 or i>6) poke4(0x5f0e,0x0100.0e0d)
  if (f%44<26) poke4(0x5f0e,0x0100.0a0a)
  if (f%44<22 or i<3 or i>8) poke4(0x5f0e,0x0100.0d0c)
  width,spritemap_y=rowwidths[subpart][i%2+1],i%2-2+subpart*2
  for x=0-(f*rowspeed[i-10+subpart*10])%width,127,width do
   sspr(0,64+spritemap_y*5,width-3,5,x,i*6+29)
  end
 end
 
 if subpart<4 then clip() end
 
 pal()

 material=objmat[subpart]
 newobj=copy(obj_foreign[subpart])
 
 
 trans[2]={2+sin(f*0.0075),3*sin(f*0.0035+0.3),-7}
 
 for rot in all(rots) do
  if rot[1]==subpart then
   rotate(newobj,(rot[2]+rot[3]*f+rot[4]*sin(f*0.005))%rot[5],rot[6])
  end
 end
 
 tr=trans[subpart]
 translate(newobj,tr[1],tr[2],tr[3])
  
 send_to_queue(newobj)
   
 render_queue()
 
 clip()
 
 str_to_mem_call(0x5f10,pals[subpart])

end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------