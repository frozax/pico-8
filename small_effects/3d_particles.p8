pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
-- 3d particles
-- by frozax

-- use at your own risk
-- have fun
#include ../libs/colors.p8
#include ../libs/vec3.p8
#include ../libs/vec2.p8
#include ../libs/fps.p8
#include ../libs/tostring.p8
#include ../libs/change_interval.p8
#include ../libs/benchmark.p8

cols = {
    [0]={
        [0]={7, 6},
        [1]={10, 9},
        [2]={9, 4},
        [3]={4, 2},
        [4]={2, 5},
    },
    [1]={
        [0]={7, 6},
        [1]={10, 9},
        [2]={11, 3},
        [3]={3, 5},
        [4]={5, 0},
    }
}
col_index1 = 0
col_index2 = 1
nb_col_index = 2

-- c between 0..4
function set3dcol(i, c)
    pal(7, cols[i][c][1])
    pal(6, cols[i][c][2])
end

function rotate_2d(p, center, angle)
  s = sin(angle);
  c = cos(angle);

  -- translate point back to origin:
  p.x -= center.x;
  p.y -= center.y;

  -- rotate point
  return vec2(p.x * c - p.y * s, p.x * s + p.y * c);

end

transf = {}

-- pitch is vertical rotation
-- roll is horizontal rotation
-- yaw is z (depth axis)
function compute_rotation_matrix(pitch, roll, yaw)
    cosa = cos(yaw);
    sina = sin(yaw);

    cosb = cos(pitch);
    sinb = sin(pitch);

    cosc = cos(roll);
    sinc = sin(roll);

    Axx = cosa*cosb;
    Axy = cosa*sinb*sinc - sina*cosc;
    Axz = cosa*sinb*cosc + sina*sinc;

    Ayx = sina*cosb;
    Ayy = sina*sinb*sinc + cosa*cosc;
    Ayz = sina*sinb*cosc - cosa*sinc;

    Azx = -sinb;
    Azy = cosb*sinc;
    Azz = cosb*cosc;

    return {Axx=Axx, Axy=Axy, Axz=Axz,
        Ayx=Ayx, Ayy=Ayy, Ayz=Ayz,
        Azx=Azx, Azy=Azy, Azz=Azz}
end

function draw_obj(a1, a2, a3, world_pos, obj, col_index)
    mat = compute_rotation_matrix(a1, a2, a3)
    for part in all(obj.parts) do
        -- scale
        --scale = 0.7
        --p = vec3(part.p.x * scale, part.p.y * scale, part.p.z * scale)
        p = part.p

        -- rotate
        rotp = vec3(
            mat.Axx*p.x + mat.Axy*p.y + mat.Axz*p.z,
            mat.Ayx*p.x + mat.Ayy*p.y + mat.Ayz*p.z,
            mat.Azx*p.x + mat.Azy*p.y + mat.Azz*p.z)

        -- translate (z)
        rotp.x += world_pos.x
        rotp.y += world_pos.y
        rotp.z += world_pos.z + cam_z;

        -- persp
        -- z = 0: far away, 1: close
        z = change_interval(rotp.z, 2.5, 6.5, 1, 0)
        trsf = vec3(rotp.x * persp_scale / rotp.z, rotp.y * persp_scale / rotp.z, z)

        -- to screen
        trsf.x += 64
        trsf.y += 64

        --if trsf.x >= 0 and trsf.y >= 0 and trsf.x < 128 and trsf.y < 128 then
            add(transf, {p=trsf, c={col_index, part.c}})
        --end
    end
end

function _update()
    bm:reset()

    if btnp(4) then
        col_index1 = (col_index1 + 1) % nb_col_index
    end
    if btnp(5) then
        col_index2 = (col_index2 + 1) % nb_col_index
    end

    transf = {}
    cam_z = 4.8
    persp_scale = 100

    ti = time()/2
    -- transform points in 3D and project

    wp1 = vec3(sin(-ti/2) * 2, cos(ti/2)*2, sin(ti/4) * 0.65)
    wp2 = vec3(-sin(ti/4) * 2, -cos(ti/2 + 0.1)*2, sin(ti + 0.12) * 0.75)

    bm("draw_obj")
    draw_obj(ti/4, ti/2, ti/8, wp1, objs[1], col_index1)
    draw_obj(ti/4, -ti, ti/8, wp2, objs[2], col_index2)
    bm()
end

function _draw()
    cls(1)

    bm("draw")
    color(colors.white)
    for part in all(transf) do
        --printh(part.z)
        ispr = 0
        if part.p.z > 0.75 then
            ispr = 3
        elseif part.p.z > 0.5 then
            ispr = 2
        elseif part.p.z > 0.25 then
            ispr = 1
        end
        set3dcol(part.c[1], part.c[2])
        spr(ispr, part.p.x - 4, part.p.y - 4)
    end
    bm()

    --showfps()

    bm:draw()
end

function _init()
    objs = {}

    cube = {}
    step = 0.75
    s = 0.6
    for x=-2,2,step do
        for y=-2,2,step do
            for z=-2,2,step do
                add(cube, {p=vec3(x*s+0.5, y*s+0.5, z*s), c=flr(y+2)})
            end
        end
    end
    add(objs, {parts=cube})

    torus = {}
    large_radius = 2.3
    small_radius = 1.0
    center = vec2(0, 0)
    s = 0.4

    for small_angle=0,1,0.08 do
        currentradius = large_radius + (small_radius * cos(small_angle));
        zval = small_radius * sin(small_angle);

        for large_angle=0,1,0.04 do
            p = vec3(currentradius * cos(large_angle), currentradius*sin(large_angle), zval)
            p = vec3(p.x*s, p.y*s, p.z*s)
            add(torus, {p=p,c=flr(large_angle*3.5 + 0.5)})
        end
    end

    add(objs, {parts=torus})

    bm:toggle()

end


__gfx__
00000000000000000000000000070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000006000000676000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000600000067600006777600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00070000006760000677760077777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000600000067600006777600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000006000000676000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
