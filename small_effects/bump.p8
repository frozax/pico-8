pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
-- bump 2021
-- by frozax

-- @frozax

#include ../libs/fps.p8

screen = 0x6000

function _update()
end

function _pset()
    for y=0,127 do
        for x=0,127 do
            pset(x, y, (x%2) + 1 + (y%3))
        end
    end
end

function _poke()
    for y=0,127 do
        for x=0,63 do
            poke(screen + y*64 + x, 16*7+6)
        end
    end
end

function _poke2()
    for y=0,127 do
        for x=0,31 do
            poke(screen + y*64 + x, 16*7+6)
        end
    end
end

function _draw()
    cls(1)

    --_pset()
    _poke2()
    showpct()
end

function _init()
end


__gfx__