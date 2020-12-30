world = {}

-- always same city for now
srand(14)

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
world.area_size = 30
world.nb_area_w = 4
world.nb_area_h = 1
world.areas_unlocked = 1
world.w = world.area_size * world.nb_area_w
world.h = world.area_size * world.nb_area_h
world.origin = vec2(0, 0) -- origin for draw
world.min_origin = vec2(0, 0)
world.max_origin = vec2(world.w * 8 - 128, world.h * 8 - 128)
world.border = 40

function world:init()
    -- items on specific cells with collisions
    world.items = {}        
    for x=0,world.w-1 do
        col = {}
        for y=0,world.h-1 do
            r = flr(rnd(100))
            col[y]=create_item({x=x,y=y})
        end
        world.items[x]=col
    end

    -- create quarry and forests
    nbs = 16
    for i=1,nbs*2 do
        if i % 2 == 0 then t = "tree" else t = "stone" end
        rshape = (i \ 2) % nbs
        if rshape == 0 then
            shape = {{1, 1, 1},{1,1,1}}
        elseif rshape == 1 then
            shape = {{1, 0, 1, 1},{1, 1, 1, 0}, {0, 1, 1, 0}}
        elseif rshape == 2 then
            shape = {{0, 1, 1, 1, 0}, {1, 1, 1, 1, 0}, {1, 1, 1, 1, 1}, {0, 1, 1, 1, 1}, {1, 1, 1, 0, 0}}
        elseif rshape == 3 then
            shape = {{0, 1, 1}, {1, 1, 1}, {0, 1, 1}}
        elseif rshape == 4 then
            shape = {{0, 1, 1, 0}, {0, 1, 1, 1}, {1, 1, 1, 1}, {1, 1, 0, 0}}
        end
        xw = flr(rnd(world.w))
        yw = flr(rnd(world.h))
        for y=1,#shape do
            for x=1,#shape[y] do
                ix = x+xw-1
                iy = y+yw-1
                if ix >= 0 and ix < world.w and iy >= 0 and iy < world.h and
                    shape[y][x] == 1 then
                    world.items[ix][iy] = create_item({type=t,x=ix,y=iy})
                end
            end
        end
    end

    -- scenery, can be placed anywhere, no collision
    world.scenery = {}
    for s=1,(world.w*world.h)/10 do
        add(world.scenery, {spr=rnd(spr_scenery), x=rnd(world.w*8), y=rnd(world.h*8)})
    end

    world.cities = {}
    fc = cities_pos[1]
    for c=1,6 do
        city = create_city({x=cities_pos[c][1], y=cities_pos[c][2]})
        add(world.cities, city)
        for x=0,city_w-1 do
            for y=0,-(city_h-1),-1 do
                item = city:gen_item(vec2(x,y))
                world.items[item.x][item.y] = item
            end
        end
    end

    -- place rails
    world.items[fc[1]-1][fc[2]]:set_rail()
    world.items[fc[1]-2][fc[2]]:set_rail()
    world.items[fc[1]-2][fc[2]-1]:set_rail()
    world.items[fc[1]-2][fc[2]-2]:set_rail()
    world.items[fc[1]-2][fc[2]-3]:set_rail()
    world.items[fc[1]-2][fc[2]-3].type = "entrepot"
    self.rail_start=vec2(fc[1]-2, fc[2]-3)
    --world.items[fc[1]-2][fc[2]-4].type = "entrepot_hammer"
    world:refresh_connections()
end

function world:update()
    if title_screen then
        -- animated origin
        self.origin.x = sin(time()/60) * self.w*8*0.95/2 + self.w*8/2
        self.origin.y = sin(time()/18.3) * self.h*8*0.3/2 + self.h*8/2-64
    else
        -- if player is outside center square, shift the origin
        pp = player.p - vec2(player.hsize, player.hsize)
        cur_pos = pp - self.origin 
        if cur_pos.x < self.border then
            self.origin.x = pp.x - self.border
        end
        if cur_pos.x > 128 - self.border then
            self.origin.x = pp.x - (128 - self.border)
        end
        if cur_pos.y < self.border then
            self.origin.y = pp.y - self.border
        end
        if cur_pos.y > 128 - self.border then
            self.origin.y = pp.y - (128 - self.border)
        end
    end

    if self.origin.x < self.min_origin.x then self.origin.x = self.min_origin.x end
    if self.origin.x > self.max_origin.x then self.origin.x = self.max_origin.x end
    if self.origin.y < self.min_origin.y then self.origin.y = self.min_origin.y end
    if self.origin.y > self.max_origin.y then self.origin.y = self.max_origin.y end
    self.origin.x = flr(self.origin.x)
    self.origin.y = flr(self.origin.y)

    -- refresh area limit
    area_x_limit = self.areas_unlocked * self.area_size
    for x=0,self.w-1 do
        for y=0,self.h-1 do
            self.items[x][y].limit = x == area_x_limit
        end
    end
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
        if xc < self.w then
            for yc=start_y,start_y+128/8 do
                if yc < self.h then
                    item = self.items[xc][yc]
                    item:draw()
                end
            end
        end
    end
end

function world:draw_cities()
    for city in all(self.cities)do
        city:draw()
    end
end

function world:get_rail_start_cell()
    return self.items[self.rail_start.x][self.rail_start.y]
end

function world:refresh_connections()
    self.connected_cities = {}
    c = self:get_rail_start_cell()
    nbcells = 0
    last_c = {}
    while(true) do
        if c:top():is_rail() and c:top() != last_c then
            last_c = c
            c = c:top()
        elseif c:bottom():is_rail() and c:bottom() != last_c then
            last_c = c
            c = c:bottom()
        elseif c:left():is_rail() and c:left() != last_c then
            last_c = c
            c = c:left()
        elseif c:right():is_rail() and c:right() != last_c then
            last_c = c
            c = c:right()
        else
            break
        end
        -- write linked list
        c.prev_rail = last_c
        last_c.next_rail = c
        nbcells += 1
        if c.city then
            -- add if not inside
            if not array_contains(self.connected_cities, c.city.name) then
                add(self.connected_cities, c.city.name)
            end
        end
    end
    train.max_pp = 8*nbcells
end

function world:next_area_cost()
    costs = {100, 250, 500, 1000, 2000, 5000, 5000}
    return costs[self.areas_unlocked]
end

-- returns two bools:
-- 1st returns true if proper cell
-- 2nd return true if enough moneu
function world:can_buy_area(cur_cell)
    if cur_cell:right().limit then
        return true, ui.coins >= self:next_area_cost()
    else
        return false, false
    end
end

function world:buy_area()
    self.areas_unlocked+=1
end