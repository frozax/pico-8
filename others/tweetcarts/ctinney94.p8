pico-8 cartridge // http://www.pico-8.com
version 29
__lua__

x=64
y=64

::★::

o=1+sin(t()/15)/2
i=24576+rnd(8192)

poke(i,peek(i)/8)
j=ceil(rnd(3))/3+t()/9
x=x+o*((64+sin(j)*32)-x)
y=y+o*((64-cos(j)*32)-y)
pset(x,y,10)

goto ★