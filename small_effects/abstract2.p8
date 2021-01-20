pico-8 cartridge // http://www.pico-8.com
version 29
__lua__

--https://twitter.com/concinnus/status/1351937549539926020

--for r=11,1,-1do
--circfill(64,64,(r-t()%2)*10,(r%2)*7)end
--for x=0,63 do for y=0,63 do
--p=7-pget(x,y)pset(x,y,p)pset(128-x,128-y,p)end
--end

::Z::cls(0)function e(h)h=h/9+.25x=cos(h)*51+64y=sin(h)*51+64j=h*2+t()/2circ(x,y,11,7)return cos(j)*11+x,sin(j)*11+y
end
for i=0,8do
u,v=e(i)n=i+3
if(i==4)n=2
if(i==2)n=8
if(i==8)n=5
if(i==5)n=7
a,b=e(n)line(u,v,a,b)end
flip()goto Z

__gfx__
