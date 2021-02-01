pico-8 cartridge // http://www.pico-8.com
version 29
__lua__

--[[

inspiration: https://preview.redd.it/itgboh8yexc61.gif?format=mp4&s=84ebdc852b4e32e0a52f1dd0aa6da90ba521cf31

- un rond avec 16 "passages"
- 8 billes qui passent en ligne en sinus

--]]

#include ../libs/fps.p8

::_::

bg=7
r = 41

cls(bg)

showfps()

cx, cy=64,64

circfill(cx, cy, r, 1)
line(0,0,127,127,bg)
line(127,0,0,127,bg)

flip()

goto _

__gfx__
