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

function p(x,y)
    return (x%2) + 1 + (y%3)
end

function _pset()
    for y=0,127 do
        for x=0,127 do
            pset(x, y, p(x,y))
        end
    end
end

function _poke()
    addr = screen
    for y=0,127 do
        for x=0,63 do
            poke(addr, p(x*2,y)*16+p(x*2+1,y))
            addr += 1
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
    _poke()
    --_poke2()
    showpct()
end

function _init()
end


__gfx__