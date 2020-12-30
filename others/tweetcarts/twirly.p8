pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
-- https://twitter.com/von_rostock/status/1135198206160228355

r,o,s,t,c,k={5,6,7,15,14,8,2,4,9,10,11,3,12},128,63,0,{},{}for i=0,o*o do
u,v=i%o-s,i/o-s
a=.02+atan2(u,v)d=.9*sqrt(u*u+v*v)c[i],k[i]=s+d*cos(a),s+d*sin(a)
end
::_::
t+=1
circfill(s,s,t%7,r[flr(t/9)%#r+1])memcpy(0,24576,8192)for i=t%3,o*o,3 do
pset(i%o,i/o,sget(c[i],k[i]))end
goto _
