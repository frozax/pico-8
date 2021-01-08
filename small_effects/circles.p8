pico-8 cartridge // http://www.pico-8.com
version 29
__lua__

::_::for r=11,1,-1do
circfill(64,64,(r-t()%2)*10,(r%2)*7)end
for x=0,63 do for y=0,63 do
p=7-pget(x,y)pset(x,y,p)pset(128-x,128-y,p)end
end
flip()goto _

__gfx__
