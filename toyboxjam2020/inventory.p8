inventory = {}
inventory.tree = 0
inventory.stone = 0
inventory.coins = 0

function getspr(spr)
    x = (spr % 16) * 8
    y = (spr \ 16) * 8
    return x, y
end

function inventory:update()
end

function inventory:draw()
    scale = 5
    draw_win(-1, -1, 58, 8, 1, 2)

    dx = 1
    dy = 1
    x, y = getspr(spr_tree)
    sspr(x, y, 8, 8, dx, dy, scale, scale)
    print(self.tree, dx + scale + 1, dy, 7)

    dx += scale + 2 + 3*4
    x, y = getspr(spr_stone)
    sspr(x, y, 8, 8, dx, dy, scale, scale)
    print(self.stone, dx + scale + 1, dy, 7)

    dx += scale + 2 + 3*4
    x, y = getspr(spr_coins)
    sspr(x, y, 8, 8, dx, dy, scale, scale)
    print(self.coins, dx + scale + 1, dy, 7)

end

function inventory:get_resource(type, count)
    if type == "tree" then self.tree += count
    elseif type == "stone" then self.stone += count
    elseif type == "coins" then self.coins += count
    else
        assert(false, "unknown resource "..type)
    end
end