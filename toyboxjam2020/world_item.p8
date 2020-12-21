spr_tree = 32
spr_stone = 63
spr_coins = 48
spr_stone_dmg = 204

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

    function item:draw()
        --, xc * 8 - self.origin.x, yc * 8 - self.origin.y)
        dx = self.x * 8 - world.origin.x
        dy = self.y * 8 - world.origin.y
        if self.type == "stone" then
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
            x = (spr_tree % 16) * 8
            y = (spr_tree \ 16) * 8
            sspr(x, y+dmg, 8, 8-dmg, dx, dy+dmg)
        elseif self.type == "debug" then
            spr(196, dx, dy)
            print(self.x..self.y, dx+2, dy+2, 1)
        end
    end

    return item
end