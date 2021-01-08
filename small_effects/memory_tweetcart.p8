pico-8 cartridge // http://www.pico-8.com
version 29
__lua__




-- new idea: with colors
b=btnp
l={"a","c","c","b","a","b"}d={0,0,0,0,0,0}i,s,t=1,0,0::_::cls(1)
if(b(0)and i>1)i=i-1
if(b(1)and i<6)i=i+1
if b(4) then
if(s==0)then s=i
elseif t==0 then
t=i
if(l[t]==l[s])d[s],d[t],s,t=1,1,0,0
else s,t=0,0end
end
for r=1,6do
c='?'o=7
if(d[r]==1)c,o=l[r],3
if(r==s or r==t)c,o=l[r],9
if(r==i)o=4
?c,r*9,2,o
end
flip()goto _


---- final optim:
--b=btnp
--l={"a","c","c","b","a","b"}d={0,0,0,0,0,0}i,s,t=1,0,0::_::cls(1)
--if(b(0)and i>1)i=i-1
--if(b(1)and i<6)i=i+1
--if b(4) then
--if(s==0)then s=i
--elseif t==0 then
--t=i
--if(l[t]==l[s])d[s],d[t],s,t=1,1,0,0
--else s,t=0,0end
--end
--for r=1,8 do
--c='?'o=7
--if(d[r]==1)c,o=l[r],3
--if(r==s or r==t)c,o=l[r],9
--if(r==i)o=4
--?c,r*9,2,o
--end
--flip()goto _

-- before optim
--[[q=8
b=btnp
x,y=0,0l={"a","c","c","b","d","a","b","d"}d={0,0,0,0,0,0,0,0}
i=1
s,t=0,0 -- selection
::_::
cls(1)
if(b(0)and i>1)i=i-1
if(b(1)and i<q)i=i+1
if b(4) then
    if s==0then
        s=i
    elseif t==0 then
        t=i
        if l[t] == l[s] then
            d[s]=1
            d[t]=1
            s=0
            t=0
        end
    else
        s=0
        t=0
    end
end
for r=1,q do
    c='?'
    o=7
    if d[r]==1 then
        c=l[r]
        o=3
    elseif r==s or r==t then
        c=l[r]
        o=9
    end
    if r==i then
        o = 4
    end
    ?c,r*10,20,o
end
flip()
goto _
]]--