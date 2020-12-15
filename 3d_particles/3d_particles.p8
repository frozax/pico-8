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

function _update()
    transf = {}
    cam_z = 3
    persp_scale = 100

    ti = time()
    mat = compute_rotation_matrix(0,0,ti/4) -- ti, ti/2, ti/4)
    mat = compute_rotation_matrix(0,ti/4,0) -- ti, ti/2, ti/4)
    mat = compute_rotation_matrix(ti/4,0,0) -- ti, ti/2, ti/4)
    mat = compute_rotation_matrix(ti/4,ti/2,ti/8) -- ti, ti/2, ti/4)

    -- transform parts in 3D and project
    for part in all(parts) do
        -- scale
        p = vec3(part.x, part.y, part.z)

        -- rotate
        rotp = vec3(
            mat.Axx*p.x + mat.Axy*p.y + mat.Axz*p.z,
            mat.Ayx*p.x + mat.Ayy*p.y + mat.Ayz*p.z,
            mat.Azx*p.x + mat.Azy*p.y + mat.Azz*p.z)

        -- translate (z)
        rotp.z += cam_z;

        --printh(tostring(p).."->"..tostring(rotp))

        -- persp
        trsf = vec3(rotp.x * persp_scale / rotp.z, rotp.y * persp_scale / rotp.z, rotp.z)

        -- to screen
        trsf.x += 64
        trsf.y += 64

        if trsf.x >= 0 and trsf.y >= 0 and trsf.x < 128 and trsf.y < 128 then
            add(transf, trsf)
        end
    end
end

function _draw()
    cls()

    color(colors.white)
    print(#transf)
    for part in all(transf) do
        printh(part.z)
        --color(flr(part.z))
        pset(part.x, part.y)
    end

    showfps()
end

function _init()
    parts = {}

    for x=-2,2 do
        for y=-2,2 do
            for z=-2,2 do
                add(parts, vec3(x+0.5, y+0.5, z))
            end
        end
    end

end


__gfx__
00000000000000000000000000070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000006000000676000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000600000067600006777600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00070000006760000677760077777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000600000067600006777600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000006000000676000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
