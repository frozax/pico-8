pico-8 cartridge // http://www.pico-8.com
version 29
__lua__

#include ../libs/tostring.p8

l=2
k={}
-- level loop
::_::
for i=1,l do
add(k,rnd({1,2,3,4}))
end
printh(tostring(k))
f=1
-- game loop
::game::
cls(1)print(k[f\20],10,10)
f+=1
a=0
l+=1
flip()
goto game

goto _