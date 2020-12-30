pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
-- https://twitter.com/kometbomb/status/1116959535531548672

fillp(0x5a5a)
::_::
cls()
c={0,1,2,4,8,9,10,7}
for r=1,8,.5 do
for i=0,1,.01 do
circfill(64+cos(i)*36,64+sin(i)*36,
12-r*3*(cos(i+t()/4)+cos(t()/4-i*4)*.2+1),c[flr(r)]+16*c[flr(r+.5)])
end
end
flip()
goto _