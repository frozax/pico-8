function draw_opening_text()
 
 pal()

 memcpy(0x6a00,0,2136*ceil(f/352))
 
 if f%11<4 and f%88>10 then
 
  a=0x6840
  
  while a<0x7240 do
   c=flr(2+rnd(1.15))
   while chance100(99.5) do
    a+=1
    poke(a,peek(a)*c)
   end
   a+=64
  end
  end
  
  for a=0x6800,0x76c0 do
   if f<rnd(50) or f>685-rnd(50) then
    poke(a,0)
   end
  end
 
 poke4(0x5f11,0x0409.0208)
 
end
-----------------------------------------------------------------------------