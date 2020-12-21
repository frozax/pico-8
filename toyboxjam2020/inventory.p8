inventory = {}
inventory.tree = 0
inventory.stone = 0
inventory.coins = 0

function inventory:update()
end

function inventory:draw()
    draw_rwin(0, -10, 127, 20, 1, 2)
    spr(spr_tree, 8, 1)
    print(self.tree, 18, 3, 7)
    spr(spr_stone, 38, 1)
    print(self.stone, 48, 3, 7)
    spr(spr_coins, 68, 1)
    print(self.coins, 78, 3, 7)
end

function inventory:get_resource(type, count)
    if type == "tree" then self.tree += count
    elseif type == "stone" then self.stone += count
    elseif type == "coins" then self.coins += count
    else
        assert(false, "unknown resource "..type)
    end
end