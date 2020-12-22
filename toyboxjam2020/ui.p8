ui = {}
ui.tree = 0
ui.stone = 0
ui.coins = 0

rail_cost_stone = 2
rail_cost_tree = 3

function getspr(spr)
    __x = (spr % 16) * 8
    __y = (spr \ 16) * 8
    return __x, __y
end

function ui:refresh_objective()
    self.objective = "connect paris to tokyo"
end

function ui:update()
    self:refresh_objective()
end

ui_col1 = 1
ui_col2 = 2
ui_text_col=7

function draw_small_icon(icon, dx, dy)
    _x, _y = getspr(icon)
    sspr(_x, _y, 8, 8, dx, dy, scale, scale)
end

function ui:draw()
    -- inventory
    scale = 5
    draw_win(-1, -1, 58, 8, ui_col1, ui_col2)

    dx = 1
    dy = 1
    draw_small_icon(spr_tree, dx, dy)
    print(self.tree, dx + scale + 1, dy, ui_text_col)

    dx += scale + 2 + 3*4
    draw_small_icon(spr_stone, dx, dy)
    print(self.stone, dx + scale + 1, dy, ui_text_col)

    dx += scale + 2 + 3*4
    draw_small_icon(spr_coins, dx, dy)
    print(self.coins, dx + scale + 1, dy, ui_text_col)

    -- objective
    --draw_win(64, -1, 58, 8, 1, 2)
    --print(self.objective, 65, 1, 7)
end

function ui:draw_build_rail(has_rsc)
    enough_col = ui_text_col
    not_enough_col = colors.red
    y = 7
    draw_win(-1, y, 36, 14, ui_col1, ui_col2)
    print("\x8ebuild", 1, y+2, ui_text_col)
    draw_small_icon(spr_rail_h, 1, y+8)
    draw_small_icon(spr_rail_h, 5, y+8)
    print(":", 10, y+8)
    x=14
    draw_small_icon(spr_tree, x, y+8)
    if rail_cost_tree <= self.tree then c = enough_col else c = not_enough_col end
    print(rail_cost_tree, x+6, y+8, c)
    x+=11
    draw_small_icon(spr_stone, x, y+8)
    if rail_cost_stone <= self.stone then c = enough_col else c = not_enough_col end
    print(rail_cost_stone, x+6, y+8, c)
end

function ui:add_resource(type, count)
    if type == "tree" then self.tree += count
    elseif type == "stone" then self.stone += count
    elseif type == "coins" then self.coins += count
    else
        assert(false, "unknown resource "..type)
    end
end

function ui:spend_resource(type, count)
    if type == "tree" then self.tree -= count
    elseif type == "stone" then self.stone -= count
    elseif type == "coins" then self.coins -= count
    else
        assert(false, "unknown resource "..type)
    end
end