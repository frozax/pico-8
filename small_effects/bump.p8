pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
-- bump 2021
-- by frozax

-- @frozax

#include ../libs/fps.p8
#include ../libs/vec2.p8
#include ../libs/change_interval.p8

screen = 0x6000

function _update()
    a = time()/2
    light_p = vec2(cos(a) * 50 + 64,
        sin(a) * 40 + 64)
end

function _fx(x,y)
    -- testheight map
    --return height_map[x+y*128]
    -- bump map
    -- comput ecolinearoty of bump map and light vec
    lv = light_p - vec2(x, y)
    bm = bump_map[x+y*128]
    coli = abs(lv.x/10+bm.x) + abs(lv.y/10 + bm.y)
    return coli
end

function _pset()
    for y=0,127 do
        for x=0,127 do
            --p(x,y)
            --pset(x, y, p(x,y))
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

function draw_light()
    circfill(light_p.x, light_p.y, 4, 7)
end

function _draw()
    --cls(1)

    for p=1,999 do
        x=flr(rnd(128))
        y=flr(rnd(128))
        pset(x, y, _fx(x, y))
    end

    draw_light()

    showpct()
end

function _init()
    generate_bump_map()
    print("done")
end

function generate_bump_map()
    -- 1D but all 128x128 pixels of heights (0-max_height)
    max_height = 5
    height_map = {}
    -- create pyramids
    print("gen height map")
    c1 = vec2(10,10)
    c2 = vec2(70, 100)
    c3 = vec2(90, 50)
    for x=0,127 do
        for y=0,127 do
            p = vec2(x,y)
            h1 = change_interval(#(c1-p), 1, 150, 1, 0, false)
            h2 = change_interval(#(c2-p), 0, 50, 1, 0, false)
            h3 = change_interval(#(c3-p), 0, 20, 1, 0, false)
            h = change_interval(h1+h2+h3, 0, 1.5, 0, 255, false)
            height_map[x+y*128] = h
        end
    end
    bump_map = {}
    print("gen bump map")
    for x=0,127 do
        for y=0,127 do
            if x != 127 and y != 127 then
                xd = height_map[x+y*128+1] - height_map[x+y*128]
                yd = height_map[x+(y+1)*128] - height_map[x+y*128]
            end
            bump_map[x+y*128] = vec2(xd, yd)
        end
    end
end


__gfx__