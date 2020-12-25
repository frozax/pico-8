pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
-- hello pico-8
-- by frozax

-- @frozax
-- use at your own risk
-- have fun

function _update60()
end

-- sprite infos
-- size
source_w = 100
source_h = 68
dest_w = source_w
dest_h = source_h
scale = 1
-- origin (in sprite sheet)
source_x = 8
source_y = 0
-- colors
col1 = 1
col2 = 12

function _draw()
    cls(col1)

    ti = t()

    -- screen pos
    tx = sin(ti / 2) * 7 + 128/2 - source_w*0.5 * scale
    tx = flr(tx)
    ty = cos(ti / 2) * 5 + 128/2 - source_h*0.5 * scale
    ty = flr(ty)

    for y=0,127 do

        -- compute x color change position
        x = 63
        x += sin(y * 0.025 + ti/2) * 8
        x += sin((y-10) * 0.025 + ti/4) * 3.3
        x += sin(ti + (y-60)/128) * 5
        x += sin(ti/8 + (y-90)/64) * 2.3

        x = flr(x)

        line(x, y, 127, y, col2)

        -- check if we have a char here
        if y >= ty and y < ty + dest_h then
            pal(7, col2)
            x_line = sin(ti / 2 + (y - ty) / 64) * 3 + tx
            x_line += cos(ti / 2 + (y - ty - 20) / 32) * 3
            width = x - x_line
            sspr(source_x, source_y + y - ty, width, 1, x_line, y)
            pal(7, col1)
            sspr(source_x + width, source_y + y - ty, source_w - width, 1, x_line + width, y)
            pal()
        end
    end

end

function _init()
end


__gfx__
00000000000000000000000077777000000777770000000000000000000007777700000777770000000000000000000000000000000000000000000000000000
00000000000000000000000077777000000777770000000000000000000007777700000777770000000000000000000000000000000000000000000000000000
00700700000000000000000077777000000777770000000000000000000007777700000777770000000000000000000000000000000000000000000000000000
00077000000000000000000077777000000777770000000000000000000007777700000777770000000000000000000000000000000000000000000000000000
00077000000000000000000077777000000777770000000077777000000007777700000777770000000077777000000000000000000000000000000000000000
00700700000000000000000077777000000777770000007777777770000007777700000777770000007777777770000000000000000000000000000000000000
00000000000000000000000077777777777777770000077777777777000007777700000777770000077777777777000000000000000000000000000000000000
00000000000000000000000077777777777777770000077777077777000007777700000777770000077777077777000000000000000000000000000000000000
00000000000000000000000077777777777777770000777770007777700007777700000777770000777770007777700000000000000000000000000000000000
00000000000000000000000077777777777777770000777770007777700007777700000777770000777770007777700000000000000000000000000000000000
00000000000000000000000077777000000777770000777777777777700007777700000777770000777770007777700000000000000000000000000000000000
00000000000000000000000077777000000777770000777777777777700007777700000777770000777770007777700000000000000000000000000000000000
00000000000000000000000077777000000777770000777770000000000007777700000777770000777770007777700000000000000000000000000000000000
00000000000000000000000077777000000777770000077777007777700007777700000777770000077777077777000000000000000000000000000000000000
00000000000000000000000077777000000777770000077777777777000007777700000777770000077777777777000000000000000000000000000000000000
00000000000000000000000077777000000777770000007777777770000007777700000777770000007777777770000000000000000000000000000000000000
00000000000000000000000077777000000777770000000777777700000007777700000777770000000077777000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000777777777770000000777770000000000777777770000000000007777777700000000000000000000077777700000007777700000000000000000000
00000000777777777777700000777770000000077777777777700000000777777777777000000000000000007777777777000007777700000000000000000000
00000000777777777777700000777770000000777777777777770000007777777777777700000000000000077777777777700007777700000000000000000000
00000000777777777777770000777770000007777777777777770000077777777777777770000000000000077777007777700007777700000000000000000000
00000000777770007777770000777770000007777770000777777000077777700007777770000000000000077777007777700007777700000000000000000000
00000000777770000777770000777770000077777700000077700000777777000000777777000000000000077777007777700007777700000000000000000000
00000000777770000777770000777770000077777000000000000000777770000000077777000000000000007777777777000007777700000000000000000000
00000000777770007777770000777770000077777000000000000000777770000000077777000000000000000777777770000007777700000000000000000000
00000000777777777777770000777770000077777000000000000000777770000000077777000000000000077777777777700000777000000000000000000000
00000000777777777777700000777770000077777000000000000000777770000000077777000777777000077777007777700000777000000000000000000000
00000000777777777777000000777770000077777000000077000000777770000000077777000777777000777770000777770000777000000000000000000000
00000000777777777770000000777770000077777700000777777000777777000000777777000777777000777770000777770000000000000000000000000000
00000000777770000000000000777770000007777700007777777000077777700007777770000777777000777770000777770007777700000000000000000000
00000000777770000000000000777770000007777777777777770000077777777777777770000000000000777777007777770007777700000000000000000000
00000000777770000000000000777770000000777777777777700000007777777777777700000000000000077777777777700007777700000000000000000000
00000000777770000000000000777770000000077777777777000000000777777777777000000000000000007777777777000007777700000000000000000000
00000000777770000000000000777770000000000777777770000000000007777777700000000000000000000777777770000007777700000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000177777000000057777100000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000007777777710000777777770000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000077777777771007777777777000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000077777777777077777777777000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000777777777777777777777777700000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000777777777777777777777777700000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000777777777777777777777777700000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000777777777777777777777777700000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000777777777777777777777777700000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000777777777777777777777777700000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000777777777777777777777777700000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000077777777777777777777777100000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000077777777777777777777777000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000007777777777777777777770000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000077777777777777777700000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000007777777777777770000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000077777777777000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000007777777770000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000777777700000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000077777000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000007770000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000700000000000000000000000000000000000000000000000000000000000000000000000