pico-8 cartridge // http://www.pico-8.com
version 29
__lua__

pal({129,1,140,12,7},1)::_::cls(1)function e(x,y,r,d)local d,x,y,r,s,a=d-1,x,y,r,r\2,t()/6if(d%2==0)a=-a
v=(r+s)*1.2local f,g=cos(a)*v,sin(a)*v
if(d>0)e(x+f,y+g,s,d)e(x-f,y-g,s,d)e(x-g,y+f,s,d)e(x+g,y-f,s,d)
circfill(x,y,r,5-d)end
e(64,64,25,5)
?"merry xmas",45,62,7
flip()goto _

-- improvement by @p01
function e(x,y,r,d,a)
if(d<5)for q=0,3do p=r*1.8b=a+q/4e(x-p*cos(b),y+p*sin(b),r/2,d+1,-a)end
circfill(x,y,r,d)end::_::pal({129,1,-4,12,7},1)cls(1)e(64,64,25,1,t()/6)
?"merry xmas",45,62,7
flip()goto _

--c=7
--pal({128+1,1,128+12,12,7},1)
--::_::
--cls(1)
--function draw_rec(x,y,r,d)
--    local d,x,y,r,r2,a=d,x,y,r,r\2,t()/6
--    if(d%2 == 0) then a = -a end
--    local cx,cy=cos(a)*(r+r2)*1.3
--    local cy=sin(a)*(r+r2)*1.3
--    if d > 0 then
--        draw_rec(x+cx,y+cy,r2,d-1)
--        draw_rec(x-cx,y-cy,r2,d-1)
--        draw_rec(x-cy,y+cx,r2,d-1)
--        draw_rec(x+cy,y-cx,r2,d-1)
--    end
--    if depth != 4 then
--        circfill(x,y,r,5-d)
--    end
--end
--draw_rec(64,64,25,4)
--print("merry\nxmas!",55,58,7)
--
--
--flip()
--goto _
--