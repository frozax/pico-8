function str_to_mem()
 local i=1
 while i<#memstr[2] do
  poke(memstr[1],hex_to_dec(memstr[2],i,1))
  i+=2
  memstr[1]+=1
 end
end
----------------