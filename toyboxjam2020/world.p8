world = {}

-- sprites stuff
spr_grass = {10, 11, 12}
spr_scenery = {194, 195, 220}
spr_tree = 32
spr_stone = 63

-- colors stuff
bg_green = 1 -- slot where we put the new green
old_green = 3
hidden_pal_green = 128+11 -- 128+10,128+11

-- we replace the green, change it for the sprites with a new one
pal(new_green, old_green, 1)
pal(old_green, hidden_pal_green, 1)

-- gen world
world.w = 32
world.h = 32

-- items on specific cells with collisions
world.items = {}        
for x=1,world.w do
    r = {}
    for y=1,world.h do
        r = flr(rnd(100))
        if r < 10 then
            item = "tree"
        elseif r < 20 then
            item = "rock"
        else
            item = nil
        end
        add(r, item)
    end
    add (world.items, r)
end

-- scenery, can be placed anywhere, no collision

function world:update()
end

function world:draw()
    --pal()

    cls(new_green)
    spr(spr_grass[1], 10, 10)
    spr(spr_grass[2], 18, 10)
    spr(spr_grass[3], 40, 10)
    spr(spr_scenery[1], 20, 40)
    spr(spr_scenery[2], 30, 40)
    spr(spr_scenery[3], 40, 40)
    spr(spr_tree, 40, 60)

    spr(63, 10, 80)
    spr(80, 20, 80)
    spr(85, 30, 80)
    spr(114, 40, 80)
    spr(188, 50, 80)
    spr(203, 60, 80)
    spr(204, 70, 80)
    spr(205, 80, 80)
    spr(227, 90, 80)

    spr(63, 10, 90)
    palt(6, true)
    spr(204, 10, 90)
    palt(6, false)

    spr(spr_stone, 20, 90)
    palt(6, true)
    if anims.sixframe == 0 then
    else
        f = 204
        x = (f % 16) * 8
        y = (f \ 16) * 8
        w, h = 8, 8
        dx, dy = 20, 90
        if anims.sixframe == 1 then
            x+=2
            y+=2
            w-=4
            h-=6
            dx+=2
            dy+=2
        elseif anims.sixframe == 2 then
            x+=2
            y+=2
            w-=4
            h-=4
            dx+=2
            dy+=2
        elseif anims.sixframe == 3 then
            x+=1
            y+=1
            w-=2
            h-=3
            dx+=1
            dy+=1
        elseif anims.sixframe == 4 then
            x+=1
            y+=1
            w-=2
            h-=2
            dx+=1
            dy+=1
        else
        end
        sspr(x, y, w, h, dx, dy)
    end
    palt(6, false)

    spr(spr_tree, 30, 90)


    --pal()
end