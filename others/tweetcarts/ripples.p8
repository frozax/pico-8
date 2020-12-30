pico-8 cartridge // http://www.pico-8.com
version 29
__lua__

-- https://twitter.com/brubsby/status/1220013753913225220

::_::
for i=0,20 do
    if(i<7)pal(i,({1,12})[1+i]or-4,1)
    y=rnd(128)
    z=y-64
    x=rnd(128)
    a=atan2(x-64,z*3)
    r=z/sin(a)
    pset(x,y,(r/2-t()*4)%7)
    --print("tt")
end
goto _