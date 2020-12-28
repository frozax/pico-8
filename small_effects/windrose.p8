pico-8 cartridge // http://www.pico-8.com
version 29
__lua__

#include ../libs/draw_poly.p8
#include ../libs/vec2.p8
#include ../libs/colors.p8
#include ../libs/fps.p8
#include ../libs/easings.p8

function draw_windrose(a, c1, c2, c3, scale)
    ca,sa=cos(a),sin(a)
    c=vec2(63,63)

    size=10
    p1 = vec2(c.x,0+63*(1-scale))
    p2 = vec2(c.x+size,c.y-size)
    p3 = vec2(c.x-size,p2.y)

    ps=rotate_2d_multi({p1,p2,p3},c,a)
    p1=ps[1]
    p2=ps[2]
    p3=ps[3]

    -- branch1
    draw_poly({c.x,c.y,p1.x,p1.y,p2.x,p2.y}, c1,c3)
    draw_poly({c.x,c.y,p1.x,p1.y,p3.x,p3.y}, c2,c3)
    
    -- branch2
    draw_poly({c.x,c.y,127-p1.x,127-p1.y,127-p2.x,127-p2.y}, c1,c3)
    draw_poly({c.x,c.y,127-p1.x,127-p1.y,127-p3.x,127-p3.y}, c2,c3)

    -- branch3
    draw_poly({c.y,c.x,127-p1.y,p1.x,127-p2.y,p2.x},c1,c3)
    draw_poly({c.y,c.x,127-p1.y,p1.x,127-p3.y,p3.x},c2,c3)

    -- branch4
    draw_poly({c.y,c.x,p1.y,127-p1.x,p2.y,127-p2.x},c1,c3)
    draw_poly({c.y,c.x,p1.y,127-p1.x,p3.y,127-p3.x},c2,c3)


    --line(cx, cy, p1x, p1y, c3)
    --line(p2x, p2y, p1x, p1y, c3)
    --line(p3x, p3y, p1x, p1y, c3)
end



pal(6, 128+8,1)
pal(11, 128+11,1)
pal(12, 128+12,1)

::★::
cls(7)

-- randomly clear scren
for x=0,127 do
    for y=0,127 do
        --if rnd() < 0.01 then
            --pset(x, y, 7)
        --end
    end
end

main_a = 0 --ease(2, ease_in_out_quad, 10, 2, ease_in_out_quad, 10, 2)

start_show_blue = 0.5
start_show_others = start_show_blue + 0.5
start_rotation = start_show_others + 0.5
show_duration = 0.5
rotation_duration = 2
hide_all_duration = 1.0
hide_all_end_margin = 0.3   -- hide before the full end of rotation
-- DEBUG
--start_show_blue=1
--start_show_others=0
--start_rotation = 2
-- ENDDEBUG
end_rotation = start_rotation + rotation_duration
time_end = end_rotation

printh("End time: "..time_end)

--main_a = ease(show_others + 1, ease_in_out_, 5, 100, ease_in_out_quad, 0, 0)
main_a = ease(start_rotation, ease_in_out_cubic, rotation_duration,
    0, ease_in_out_quad, 0, 0) * (-2)
printh("main_a"..(start_rotation+rotation_duration))

a_2 = ease(start_show_blue, ease_out_back, show_duration,
    time_end-hide_all_duration-hide_all_end_margin-show_duration-start_show_blue,
    ease_out_quad, hide_all_duration, hide_all_end_margin)*0.125

a_3 = ease(start_show_others, ease_out_back, show_duration,
    time_end-hide_all_duration-hide_all_end_margin-show_duration-start_show_others,
    ease_out_quad, hide_all_duration, hide_all_end_margin)*0.125/2

draw_windrose(main_a-a_3, 3, 11, 2, 0.8) -- green
draw_windrose(main_a-a_2-a_3, 10, 9, 2, 0.8) -- yellow

draw_windrose(main_a-a_2, 1, 12, 2, 1) -- blue

draw_windrose(main_a, 8, 6, 2, 1) -- red
showpct(7)

--printc(a_2)

flip()

goto ★
