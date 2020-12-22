world = {}

-- sprites stuff
spr_grass = {10, 11, 12}
spr_scenery = {194, 195, 220, 10, 11, 12}

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
world.origin = vec2(0, 0) -- origin for draw
world.min_origin = vec2(0, 0)
world.max_origin = vec2(world.w * 8 - 128, world.h * 8 - 128)
world.border = 40

-- items on specific cells with collisions
world.items = {}        
for x=0,world.w-1 do
    col = {}
    for y=0,world.h-1 do
        r = flr(rnd(100))
        -- TODO REMOVE
        --r = 100
        --if x < 4 and (y > 2 and y < 10) then r = 9 end
        --if x > 8 and (y > 2 and y < 10) then r = 4 end
        --if x == 6 and y == 4 then r = 4 end
        if r < 5 then
            item = create_item({type="tree",x=x,y=y})
        elseif r < 10 then
            item = create_item({type="stone",x=x,y=y})
        else
            item = create_item({x=x,y=y})
        end
        col[y]=item
    end
    world.items[x]=col
end

-- scenery, can be placed anywhere, no collision
world.scenery = {}
for s=1,(world.w*world.h)/10 do
    add(world.scenery, {spr=rnd(spr_scenery), x=rnd(world.w*8), y=rnd(world.h*8)})
end

world.cities = {}
for c=1,5 do
    city = create_city()
    add(world.cities, city)
    for x=0,city_w-1 do
        for y=0,-(city_h-1),-1 do
            item = city:gen_item(vec2(x,y))
            printh(tostring(item))
            world.items[item.x][item.y] = item
        end
    end
end

function world:update()
    -- if player is outside center square, shift the origin
    pp = player.p - vec2(player.size*0.5, player.size*0.5)
    cur_pos = pp - self.origin 
    if cur_pos.x < self.border then
        self.origin.x = pp.x - self.border
        if self.origin.x < self.min_origin.x then self.origin.x = self.min_origin.x end
    end
    if cur_pos.x > 128 - self.border then
        self.origin.x = pp.x - (128 - self.border)
        if self.origin.x > self.max_origin.x then self.origin.x = self.max_origin.x end
    end
    if cur_pos.y < self.border then
        self.origin.y = pp.y - self.border
        if self.origin.y < self.min_origin.y then self.origin.y = self.min_origin.y end
    end
    if cur_pos.y > 128 - self.border then
        self.origin.y = pp.y - (128 - self.border)
        if self.origin.y > self.max_origin.y then self.origin.y = self.max_origin.y end
    end

    self.origin.x = flr(self.origin.x)
    self.origin.y = flr(self.origin.y)
end

function world:draw()
    --pal()

    cls(new_green)

    start_x = flr(self.origin.x/8)
    start_y = flr(self.origin.y/8)

    self:draw_scenery()
    self:draw_items()
    self:draw_cities()
    --draw_test()
end

function world:debug()
    color(1)
    for i=0,world.w-1 do
        line(-self.origin.x + i*8, 0, -self.origin.x + i*8, 127)
        line(-self.origin.x + i*8+7, 0, -self.origin.x + i*8+7, 127)
        line(0, -self.origin.y + i*8, 127, -self.origin.y + i*8)
        line(0, -self.origin.y + i*8+7, 127, -self.origin.y + i*8+7)
    end

end

function world:draw_scenery()
    for scenery in all(self.scenery) do
        spr(scenery.spr, scenery.x-self.origin.x, scenery.y - self.origin.y)
    end
end

function world:draw_items()
    for xc=start_x,start_x+128/8 do
        if xc <= self.w then
            for yc=start_y,start_y+128/8 do
                item = self.items[xc][yc]
                item:draw()
            end
        end
    end
end

function world:draw_cities()
    for city in all(self.cities)do
        city:draw()
    end
end
