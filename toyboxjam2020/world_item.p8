spr_tree = 32
spr_stone = 63
spr_coins = 128
spr_coins2 = 129
spr_stone_dmg = 204
spr_rail_h = 37
spr_rail_v = 36
spr_entrepot = 190
spr_hammer = 28
spr_rail_corner = 39
spr_clock = 171
spr_house = 22
spr_column = 55
spr_gare_left = 119
spr_gare_right = 121
spr_loco_h = 40
spr_loco_v = 41
spr_wagon_h = 42
spr_wagon_v = 43
spr_limit = 88

function create_item(infos)
    item = infos

    if item.type != nil then
        item.dmg = 0
        function item:damage()
            self.dmg += 2
            if self.dmg >= 100 then
                self.dmg = 100
                -- remove from world
                world.items[self.x][self.y] = create_item({x=item.x, y=item.y})
            end
        end
        function item:get_damage_state()
            return self.dmg \ 20
        end
    end

    function item:is_collidable()
        return self.type == "stone" or self.type == "tree" or
            self.type == "citypart" or self.type == "house" or
            self.type == "gare_left" or self.type == "gare_right" or self.type == "gare_col" or
            self.type == "entrepot" or self.limit
    end

    function item:is_breakable()
        return self.type == "stone" or self.type == "tree"
    end

    function item:draw(debug)
        --, xc * 8 - self.origin.x, yc * 8 - self.origin.y)
        dx = self.x * 8 - world.origin.x
        dy = self.y * 8 - world.origin.y
        if self.limit then
            palt(0,false)
            spr(spr_limit, dx, dy)
            palt(0,true)
        elseif self.type == "stone" then
            spr(spr_stone, dx, dy)
            palt(6, true)
            dmg = self:get_damage_state()
            if dmg == 0 then
            else
                x = (spr_stone_dmg % 16) * 8
                y = (spr_stone_dmg \ 16) * 8
                w, h = 8, 8
                if dmg == 1 then
                    x+=2
                    y+=2
                    w-=4
                    h-=6
                    dx+=2
                    dy+=2
                elseif dmg == 2 then
                    x+=2
                    y+=2
                    w-=4
                    h-=4
                    dx+=2
                    dy+=2
                elseif dmg == 3 then
                    x+=1
                    y+=1
                    w-=2
                    h-=3
                    dx+=1
                    dy+=1
                elseif dmg == 4 then
                    x+=1
                    y+=1
                    w-=2
                    h-=2
                    dx+=1
                    dy+=1
                end
                sspr(x, y, w, h, dx, dy)
            end
            palt(6, false)
        elseif self.type == "tree" then
            dmg = self:get_damage_state()

            -- v1
            x = (spr_tree % 16) * 8
            y = (spr_tree \ 16) * 8
            sspr(x, y+dmg, 8, 8-dmg, dx, dy+dmg)

            -- v2
            --spr(spr_tree, dx, dy)
            --if dmg != 0 then
            --    if dy % 2 == 0 then
            --        if dmg == 1 then fillp(0b0111110111111101.1) end
            --        if dmg == 2 then fillp(0b0101011011101101.1) end
            --        if dmg == 3 then fillp(0b1010010110100101.1) end
            --        if dmg == 4 then fillp(0b1000010010100101.1) end
            --    else
            --        if dmg == 1 then fillp(0b0111110111111101.1) end
            --        if dmg == 2 then fillp(0b0101011011101101.1) end
            --        if dmg == 3 then fillp(0b1010010110100101.1) end
            --        if dmg == 4 then fillp(0b1000010010100101.1) end
            --    rectfill(dx, dy, dx+7, dy+7, 0, 0)
            --    fillp()
            --end
        elseif self.type == "rail" then
            flipx, flipy=false
            s = spr_rail_h
            if self:top():is_rail() then
                if self:left():is_rail() then
                    s = spr_rail_corner
                    flipx, flipy = true, true
                elseif self:right():is_rail() then
                    s = spr_rail_corner
                    flipx, flipy = false, true
                else
                    s = spr_rail_v
                end
            elseif self:bottom():is_rail() then
                if self:left():is_rail() then
                    s = spr_rail_corner
                    flipx, flipy = true, false
                elseif self:right():is_rail() then
                    s = spr_rail_corner
                    flipx, flipy = false, false
                else
                    s = spr_rail_v
                end
            else
                s = spr_rail_h
            end
            spr(s, dx, dy, 1, 1, flipx, flipy)
        elseif self.type == "entrepot_hammer" then
            spr(spr_hammer, dx, dy)
        elseif self.type == "entrepot" then
            spr(spr_rail_v, dx, dy)
            spr(spr_entrepot, dx, dy)
        elseif self.type == "house" then
            spr(spr_house, dx, dy)
        elseif self.type == "gare_col" then
            spr(spr_column, dx, dy)
        elseif self.type == "gare_left" then
            spr(spr_gare_left, dx, dy)
        elseif self.type == "gare_right" then
            spr(spr_gare_right, dx, dy)
        elseif self.type == "coins" then
            s = flr(time()*8) % 2 + spr_coins
            flipx = flr(time()*8)%4 < 2
            spr(s, dx, dy, 1, 1, flipx)
        end
        if debug then
            spr(196, dx, dy)
            print(self.x..self.y, dx+1, dy+2, 1)
        end
    end

    function item:valid(x,y)
        return x >= 0 and y >= 0 and x < world.w and y < world.h
    end

    function item:right()
        if self:valid(self.x+1, self.y) then
            return world.items[self.x+1][self.y]
        else
            return create_item({x=self.x+1,y=self.y})
        end
    end

    function item:left()
        if self:valid(self.x-1,self.y) then
            return world.items[self.x-1][self.y]
        else
            return create_item({x=self.x-1,y=self.y})
        end
    end

    function item:top()
        if self:valid(self.x, self.y-1) then
            return world.items[self.x][self.y-1]
        else
            return create_item({x=self.x,y=self.y-1})
        end
    end

    function item:bottom()
        if self:valid(self.x, self.y+1) then
            return world.items[self.x][self.y+1]
        else
            return create_item({x=self.x,y=self.y+1})
        end
    end

    function item:is_rail()
        return self.type == "rail"
    end
    
    function item:nb_rails_nb()
        _nb = 0
        if self:left():is_rail() then _nb+=1 end
        if self:right():is_rail() then _nb+=1 end
        if self:bottom():is_rail() then _nb+=1 end
        if self:top():is_rail() then _nb+=1 end
        return _nb
    end

    -- returns true/false,true/false
    -- 1st one is true if we are on a proper cell to build
    -- 2nd one is true if we have enough resources
    function item:can_build_rail()
        if not self:is_rail() and not self:is_collidable() then
            -- rail is possible if after placing it, nobody will have 3 nb with rails
            il = self:left():is_rail()
            it = self:top():is_rail()
            ib = self:bottom():is_rail()
            ir = self:right():is_rail()
            l = self:left():nb_rails_nb()
            t = self:top():nb_rails_nb()
            b = self:bottom():nb_rails_nb()
            r = self:right():nb_rails_nb()
            if (l < 2 and t < 2 and b < 2 and r < 2) and
            (ir or il or it or ib) then
                --printh("l"..l.."r"..r.."t"..t.."b"..b)
                return true, ui.stone >= rail_cost_stone and ui.tree >= rail_cost_tree
            end
        end
        return false, false
    end

    function item:set_rail()
        self.type = "rail"
    end

    return item
end