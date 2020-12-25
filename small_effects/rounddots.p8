pico-8 cartridge // http://www.pico-8.com
version 29
__lua__

::_::cls(0)d=64
for x=0,128,32do
for y=16,128,32do
circ(x,y,13,7)a=sin(t()/1.5)*d+d-x
b=d-y
l=sqrt(a*a+b*b)a*=9/l
b*=9/l
circfill(a+x,b+y,2,7)end
end
flip()goto _

--::_::
--cls(0)
--cx=sin(t()/2)*64+64
--cy=64
--for ix=0,4 do
--    for iy=0,3 do
--        x=ix*32
--        y=iy*32+16
--        circ(x, y, 13,7)
--        x2=cx-x
--        y2=cy-y
--        l=sqrt(x2*x2+y2*y2)
--        x2 = x2/l * 9
--        y2 = y2/l * 9
--        circfill(x2+x, y2+y, 2,7)
--    end
--end
--flip()
--goto _

--d={30583.5,-17476.5,-8738.5,-4369.5}t=0::_::
--t+=0.5q=circfill
--cls(6)for l=1,8do
--for i=1,4do
--fillp(d[i])q(64,64,32-i*4,0x71)q(64+cos(l/8+i/32)*48,64+sin(l/8+i/32)*48,4)
--end
--end
--fillp()for j=1,31do
--v=j*4-t%256+128rectfill(v,0,v+2,128,1)end
--flip()goto _
