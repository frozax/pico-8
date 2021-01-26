pico-8 cartridge // http://www.pico-8.com
version 29
__lua__

--[[

ALGO: plein de traits blanc qui descendent constemment
au bout d'un moment, l'anim fait que le trait blanc monte en faisant du rouge, reste en haut et devient tout blanc, puis se retrecit en mettant du bleu
l'animation demarre dans une forme de cercle

en fait, on dessine des carrés avec anim en t=0,1

anim en 4 parties:
1. degrade de rouge qui monte et rempli le carré vers le haut
2. degrade s'écrase et le blanc prend la place
3. degrade de bleu prend la place par le bas
3. degrade s'écrase par le noir

--]]

#include ../libs/fps.p8

::_::

cls(0)

time_to_go_down = 3.0
time_for_anim = time_to_go_down * 0.3
start_anim = 0.1

white=1
blue1=2
blue2=3
red1=4
red2=5
pal({7,12,12+128,9,8},1)

function draw_3_squares(_x, _y, _height, _c1, _c2, _c3)
    rectfill(_x, _y - 2*_height/3, _x + size - 1, _y - 3*_height/3, _c3)
    rectfill(_x, _y - 1*_height/3, _x + size - 1, _y - 2*_height/3, _c2)
    rectfill(_x, _y - 0*_height/3, _x + size - 1, _y - 1*_height/3, _c1)
    -- hack: end by white
    if _c3 == white then
        rectfill(_x, _y - 2*_height/3, _x + size - 1, _y - 3*_height/3, _c3)
    end
end

function draw_square(x, y, anim)
    -- debug
    --rectfill(ox+x, oy+down_y_shift+y, ox+x+size-1, oy+down_y_shift+y+size-1, 13)
    if anim <= 0 then
        line(ox+x, oy+size-1+down_y_shift+y, ox+x+size-1, oy+size-1+down_y_shift+y, white)
    elseif anim >= 1 then
        line(ox+x, oy+down_y_shift+y, ox+x+size-1, oy+down_y_shift+y, white)
    elseif anim < 0.25 then
        -- increase 3 colors
        total_y = flr(anim * 4 * (size))
        -- draws three square by splitting total
        draw_3_squares(ox+x, oy + y + size - 1 + down_y_shift, total_y, white, red1, red2)
    elseif anim < 0.5 then
        total_y = flr((anim-0.25) * 4 * (size))
        draw_3_squares(ox+x, oy + y + size - 1 + down_y_shift - total_y, size - 1 - total_y, white, red1, red2)
        rectfill(ox+x, oy + y + down_y_shift+size-1-total_y, ox+x+size-1, oy + y + down_y_shift+size-1, white)
    elseif anim < 0.75 then
        total_y = flr(size - (anim-0.5) * 4 * size)
        rectfill(ox+x, oy + y + down_y_shift, ox+x+size-1, oy + y + down_y_shift+total_y, white)
        --rectfill(ox+x, oy + y + down_y_shift+total_y, ox+x+size-1, oy + y + down_y_shift+size-1, blue1)
        draw_3_squares(ox+x, oy + y + down_y_shift+size - 1, size - 1 - total_y, blue2, blue1, white)
        --draw_3_squares(ox+x, oy + y + size - 1 + down_y_shift - total_y, size - 1 - total_y, white, blue1, blue2)
    elseif anim < 1 then
        -- increase 3 colors
        total_y = size - 1 - flr((anim-0.75) * 4 * (size))
        -- draws three square by splitting total
        draw_3_squares(ox+x, oy + y + down_y_shift + total_y, total_y, blue2, blue1, white)
    else
        print("should not happen")
    end
end

size = 9
nbx = 12
nby = nbx
ox = (128 - nbx * (size+1)) \ 2
oy = ox

t = time() 

down_t = ((t - start_anim + time_to_go_down) % time_to_go_down)
down_y_shift = down_t * (size - 1) / time_to_go_down
new_t = down_t

center_x, center_y = (nbx-1)/2, (nby-1)/2

for x=0,nbx-1 do
    for y=0,nby-1 do
        dist_to_center = sqrt( (center_x-x) * (center_x-x) + (center_y-y) * (center_y-y) )
        dist_rework = 2 - dist_to_center/nbx*2.5
        -- map to to animation
        anim = (new_t + dist_rework - 2.0)
        draw_square(x*(size+1), y*(size+1), anim)
    end
end

--showfps()

flip()

goto _

__gfx__
