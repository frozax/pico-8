player = {}

player.p = vec2(64, 64) -- p is center of perso
player.speed = 1.0    -- pix / frame
player.size = 8
player.hsize = 4
player.minp = vec2(player.hsize, player.hsize)
player.maxp = vec2(world.w * 8 - player.hsize, world.h * 8 - player.hsize)
player.idle_down = create_anim({238, 238, 238, 239})
player.idle_up = create_anim({253, 253, 253, 254})
player.idle_left = create_anim({246, 246, 246, 247}, {true, true, true, true})
player.idle_right = create_anim({246, 246, 246, 247})
player.walk_down = create_anim({240, 240}, {true, false})
player.walk_up = create_anim({255, 255}, {true, false})
player.walk_left = create_anim({248, 249}, {true, true})
player.walk_right = create_anim({248, 249})
player.destroy_down = create_anim({241, 242})
player.destroy_left = create_anim({250, 251}, {true, true})
player.destroy_right = create_anim({250, 251})
player.destroy_up = create_anim({253, 254})
player.destroy = player.destroy_down
player.idle = player.idle_down

function player:update()
    dir = vec2(0, 0)
    if btn(buttons.left) then
        dir.x = -1
        self.anim = self.walk_left
        self.idle = self.idle_left
        self.destroy = self.destroy_left
    end
    if btn(buttons.right) then
        dir.x = 1
        self.anim = self.walk_right
        self.idle = self.idle_right
        self.destroy = self.destroy_right
    end
    if btn(buttons.up) then
        dir.y = -1
        self.anim = self.walk_up
        self.idle = self.idle_up
        self.destroy = self.destroy_up
    end
    if btn(buttons.down) then
        dir.y = 1
        self.anim = self.walk_down
        self.idle = self.idle_down
        self.destroy = self.destroy_down
    end
    if #dir == 0 then
        self.anim = self.idle
    else
        dir = (self.speed / #dir) * dir
        self.coll_item = nil
        dirx = self:collide(self.p, vec2(dir.x, 0))
        diry = self:collide(self.p, vec2(0, dir.y))
        dir.x = dirx.x
        dir.y = diry.y
        self:move(dir)

        if self.coll_item != nil then
            self.anim = self.destroy
            old_ds = self.coll_item:get_damage_state()
            self.coll_item:damage()
            new_ds = self.coll_item:get_damage_state()
            if old_ds != new_ds then
                --inventory.win_item(self.coll_item.type)
            end
        end
    end
end

function player:move(dir)
    newp = self.p + dir
    self.p = newp

    -- check borders
    if self.p.x < self.minp.x then self.p.x = self.minp.x end
    if self.p.x > self.maxp.x then self.p.x = self.maxp.x end
    if self.p.y < self.minp.y then self.p.y = self.minp.y end
    if self.p.y > self.maxp.y then self.p.y = self.maxp.y end
end

function player:get_bounds_cells(p)
    minx = flr(p.x - self.hsize)\8
    miny = flr(p.y - self.hsize)\8
    maxx = flr(p.x + self.hsize-1)\8
    maxy = flr(p.y + self.hsize-1)\8
    return minx, miny, maxx, maxy
end

function player:get_bounds(p)
    minx = flr(p.x - self.hsize)
    miny = flr(p.y - self.hsize)
    maxx = flr(p.x + self.hsize-1)
    maxy = flr(p.y + self.hsize-1)
    return minx, miny, maxx, maxy
end

function player:get_items_to_check(p, dir)
    minx, miny, maxx, maxy = self:get_bounds_cells(p)
    items = {}
    if dir.x != 0 then
        if dir.x < 0 then xidx = minx else xidx = maxx end
        add(items, world.items[xidx][miny])
        if miny != maxy then
            add(items, world.items[xidx][maxy])
            if self.p.y\8 == items[2].y then
                -- swap to do it in order
                tmp = items[2]
                items[2] = items[1]
                items[1] = tmp
            end
        end
    end
    if dir.y != 0 then
        if dir.y < 0 then yidx = miny else yidx = maxy end
        add(items, world.items[minx][yidx])
        if minx != maxx then
            add(items, world.items[maxx][yidx])
            if self.p.x\8 == items[2].x then
                -- swap to do it in order
                tmp = items[2]
                items[2] = items[1]
                items[1] = tmp
            end
        end
    end
    return items
end

-- returns a new dir that prevents collision
function player:collide(old, dir)
    -- check if any of the four corner is in an item
    new = old + dir
    items = self:get_items_to_check(new, dir)
    minx, miny, maxx, maxy = self:get_bounds(new)
    for item in all(items)do
        if item.type != nil then
            if self.coll_item == nil then
                self.coll_item = item
            end
            if dir.x > 0 and maxx >= item.x*8 then
                maxnewx = (item.x * 8 - self.hsize)
                dir.x = max(maxnewx - old.x, 0)
                new = old + dir
            elseif dir.x < 0 and minx <= (item.x+1)*8 then
                minnewx = (item.x + 1) * 8 + self.hsize
                dir.x = min(minnewx - old.x, 0)
                new = old + dir
            end
            if dir.y > 0 and maxy >= item.y*8 then
                maxnewy = (item.y * 8 - self.hsize)
                dir.y = max(maxnewy - old.y, 0)
                new = old + dir
            elseif dir.y < 0 and miny <= (item.y+1)*8 then
                minnewy = (item.y + 1) * 8 + self.hsize
                dir.y = min(minnewy - old.y, 0)
                new = old + dir
            end
        end
    end
    return dir
end

function player:draw()
    --for item in all(self:get_items_to_check(self.p, vec2(-1,-1))) do
    --    world:draw_item({type="debug",x=item.x, y=item.y})
    --end

    -- DEBUG
    --self.anim = create_anim({218})
    self.anim:update()
    --pal(2, 12)
    --pal(14, 1)
    self.anim:draw(self.p - world.origin - vec2(self.hsize, self.hsize))
    --print(tostring(self.p), 1, 10, 7)
    --print(flr((self.p.x-self.hsize)/8).." "..flr((self.p.y-self.hsize)/8), 1, 20, 7)
    --if self.coll_item != nil then
    --    item = create_item({type="debug",x=self.coll_item.x, y=self.coll_item.y})
    --    item:draw()
    --end

    --minx, miny, maxx, maxy = self:get_bounds(self.p)
    --rect(minx, miny, maxx, maxy, 7)
    --printh(minx..miny..maxx..maxy)
end