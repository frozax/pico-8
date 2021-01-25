pico-8 cartridge // http://www.pico-8.com
version 29
__lua__


#include ../libs/tostring.p8

-- show a group of icons
-- one is displayed twice
-- we need to find which one by using arrows and button

--[[

c=cells
i=cur char
e=result
x,y=coords
s=selected
d=color
m=stat (used for mouse)
a,z=mouseX,mouseY
n=rnd
f=flr
u=sub
p=pts

--]]

-- init: 43 --> 30
-- genstring and pick letter:48 --> 40
-- shuffle: 59 --> 62
-- loop (display and compare): 124 --> 111
-- mouse and loop: 27 --> 27


---- V4 - use numbers
poke(24365,1)p=0::_::m,f,r=stat,flr,rnd
e=f(r(8))c={0,1,2,3,4,5,6,7,e}for n=0,9do
a,b=f(1+r(9)),f(1+r(9))c[a],c[b]=c[b],c[a]end::G::cls(1)a,z=m(32),m(33)for j=1,9do
?c[j],j*6,1,9
?"score:"..p,9,9,7
if(m(34)>0 and a\6==j and z<7 and c[j]==e)p+=1goto _
end
?"^",a-2,z-2
flip()goto G












---- V3 - less features
--poke(24365,1)::_::m,u=stat,sub
--c="abcefghi"e=flr(rnd(9))+1e=u(c,e,e)c=c..e
--for n=0,9do
--z=flr(rnd(8)+1)c=u(c,z,z)..u(c,z+1)..u(c,1,z-1)end
--::G::cls(1)a,z=m(32),m(33)j=1for x=1,3do
--for y=1,3do
--i=u(c,j,j)
--printh(x.." "..y.." "..i.." "..c.." "..j.." "..e)
--?i,x*6,y*8
--if(m(34)>0 and a\6==x and z\8==y and i==e)goto _
--j+=1end
--end
--?"^",a-2,z-2,7
--flip()goto G

---- V2
--poke(0x5f2d,1)::_::m,u=stat,sub
--c="abcefghi"e=(rnd(9))+1e=u(c,e,e)c=c..e
--for n=0,9do
--z=rnd(9)c=u(c,z,z)..u(c,z+1)..u(c,1,z-1)end
--::G::cls(1)a,z=m(32),m(33)j=1for x=1,3do
--for y=1,3do
--s=a\6==x and z\8==y
--i=u(c,j,j)
--?i,x*6,y*8,s and 7or 8
--if(m(34)>0 and s and i==e)goto _
--j+=1end
--end
--?"^",a-2,z-2,7
--flip()goto G


---- V1
--poke(0x5f2d,1)::_::m,r,f=stat,rnd,flr
--d=d==8 and 10 or 8c={"a","b","c","e","f","g","h","i","j","k","l","m","n","o","p"}e=c[f(r(#c))+1]add(c,e)for n=1,#c*2do
--a,b=f(1+r(#c)),f(1+r(#c))c[a],c[b]=c[b],c[a]end::G::cls(1)a,z=m(32),m(33)for x=1,4do
--for y=1,4do
--s=(a\6==x)and(z\8==y)i=c[x+y*4-4]
--?i,x*6,y*8,s and 7 or d
--if (m(34)!=0 and s and i==e)goto _
--end
--end
--?"^",a-2,z-3,7
--flip()goto G
--