train = {}

-- design: le joueur rentre dans la loco qu'il veut.
-- il appuye sur le bouton pour avancer
-- position du train est défini par la case de la loco principale et le
-- decalage (en 1D)
-- la direction depend de la loco active (state)

function train:init()
    train.city=""
    train.state = "stop"    -- stop, drive_start, drive_end
    self.wagons=1
    --self.pos=first_city
    --self.pos.x+=2
    -- much easier: pos is the pix pos from start
    -- pp for pixxel pos
    self.pp = 8*7
    self.speed=0
    -- shift from cell center
    self.incell = 0
end

function train:update()
    self.speed *= 0.85
    if abs(self.speed) <= 0.01 then
        self.speed = 0
    else
        -- advance!
        self.pp += self.speed
        if self.pp < 0 then self.pp = 0 end
        if self.pp > self.max_pp then self.pp = self.max_pp end
    end

    c = world:get_rail_start_cell()
    pp = self.pp
    while(true) do
        if pp >= 8 then
            pp -= 8
            c = c.next_rail
        else
            break
        end
    end
    self.start_loco_cell = c
    self.inner_pp = pp

    if c.city != nil then
        cur_city = c.city.name
        if cur_city != self.city then
            if self.city != "" then
                -- yay! travel!
                c.city:spawn_coins()
            end
            self.city = cur_city
        end
    end

    if self:is_player_in_loco() then
        c = self:get_start_loco_cell()
        if self.state == "drive_end" then
            c = self:get_end_loco_cell()
        end
        addx,addy = self:compute_addxy()
        player.p = vec2(c.x*8+player.hsize+addx, c.y*8+player.hsize+addy)
    end
end

function train:compute_addxy()
    addx,addy=0,0
    if cell.next_rail == cell:top() then addy-=self.inner_pp
    elseif cell.next_rail == cell:bottom() then addy+=self.inner_pp
    elseif cell.next_rail == cell:left() then addx-=self.inner_pp
    elseif cell.next_rail == cell:right() then addx+=self.inner_pp end
    return addx,addy
end

function train:draw()
    cell = self:get_start_loco_cell()
    for i=1,self.wagons+2 do
        --printh(tostring(self.pos))
        flipx,flipy=false,false
        if cell:left():is_rail() or cell:right():is_rail() then
            if i ==1 or i == self.wagons + 2 then
                if i != 1 then flipx=true end
                s = spr_loco_h
            else
                s = spr_wagon_h
            end
        else
            flipx=true
            if i ==1 or i == self.wagons + 2 then
                if i==1 then flipy=true end
                s = spr_loco_v
            else
                s = spr_wagon_v
            end
        end
        addx,addy=self:compute_addxy()
        spr(s, cell.x*8-world.origin.x+addx, cell.y*8-world.origin.y+addy,1,1,flipx,flipy)
        --printh(cell.prev_rail)
        if not cell.prev_rail then
            break
        end
        cell = cell.prev_rail
    end
end

function train:get_start_loco_cell()
    return self.start_loco_cell
end

function train:get_end_loco_cell()
    c = self:get_start_loco_cell()
    for i=1,2+self.wagons-1 do
        c = c.prev_rail
    end
    return c
end

function train:can_enter_loco(cell)
    if self:is_player_in_loco() then
        return false
    end
    if cell == self:get_start_loco_cell() or
        cell == self:get_end_loco_cell() then
        return true
    end
    return false
end

function train:can_leave_loco(cell)
    return self:is_player_in_loco()
end

function train:leave_loco()
    self.state = "stop"
end

function train:enter_loco(cell)
    if cell == self:get_start_loco_cell() then
        self.state = "drive_start"
    elseif cell == self:get_end_loco_cell() then
        self.state = "drive_end"
    end
end

function train:advance()
    if self.state == "drive_start" then
        self.speed += 1
    else
        self.speed -= 1
    end
    printh("speed"..self.speed)
end

function train:is_player_in_loco()
    return self.state != "stop"
end
