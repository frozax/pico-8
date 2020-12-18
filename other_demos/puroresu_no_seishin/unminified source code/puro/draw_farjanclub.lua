function flip_to_mem()
 memcpy(0,0x6000,8192)
end

function trifill_no_table(x1,y1,x2,y2,x3,y3)
 trifill({{x1,y1},{x2,y2},{x3,y3}})
end

drawproc_skiptable,drawproc_steptable,drawproc_cmds=parse_table("3_9_7_13_9_19_9_1|"),parse_table("1_4_3_6_4_10_4_1|"),{color,rectfill,circfill,trifill_no_table,line,sspr,clip,flip_to_mem}

function recursify(step,end_step)

 if step<=end_step then return params[step],recursify(step+1,end_step)end
 
end


function draw_procedural(str)
 i=1
 
 while i<=#str do
 
  mode,params=sub(str,i,i)+0,{}

  for i3=i+1,i+15,2 do
   --add(params,tonum("0x"..sub(str,i3,i3+1)))
   add(params,hex_to_dec(str,i3,1))
  end
  
  for i2=9,10 do
   i3,params[i2]=i+8+i2,false
   if sub(str,i3,i3)=="1" then params[i2]=true end
  end
  
  drawproc_cmds[mode](recursify(1,drawproc_steptable[mode]))
  
  i+=drawproc_skiptable[mode]

 end
 
end

function draw_farjanclub()

 poke4(0x5f10,0x0302.0700)
 
 draw_procedural(proc_ssp8)
 proc_ssp8=""
 
 if f>=44 then
  draw_procedural(proc_farjanclub)
  proc_farjanclub=""
 end

 memcpy(0x6000,0,8192)
 
 if f<44 then rectfill(0,32+ceil(f/11)*16,127,127,0) end
 
 if f%11<6 and f<55 then
  poke4(0x5f10,0x0302.0007)
 end
 
 if f>1000 then f=1000 end

end

--------------------------------------------------------------------------------------------------------------------------------------------------------------