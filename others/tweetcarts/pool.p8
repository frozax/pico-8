pico-8 cartridge // http://www.pico-8.com
version 29
__lua__

-- https://twitter.com/von_rostock/status/1203861572126420995

f,s=flr,sin
function m(u,v,k)
    return(f(u/k)+f(v/k))%3-2*((s(u/19/k+s(v/9/k))+s(v/16/k-t()/4+s(u/6/k)))/2)^8
end

::_::
--for x=0,127 do
--for y=0,127 do
x=f(rnd(128))
y=rnd(128)
pal(x%16+1,({-15,1,-4,12,6,7})[x%16+1],1)
j=sgn(63-x)
c=m(x,y+x/2*j,16)+j%3
if(x+y*2>192 and y*2>x+64)c=m(x-y*2,y*2+x,32)+3
pset(x,y,c)
--end
--end
--flip()
goto _