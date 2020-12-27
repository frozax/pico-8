pico-8 cartridge // http://www.pico-8.com
version 29
__lua__

#include ../libs/draw_poly.p8

::★::

cls(0)

draw_poly({1, 1,10, 20,20, 12}, 7)
flip()

goto ★

--255,241,232