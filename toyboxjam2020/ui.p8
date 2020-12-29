ui = {}
ui.tree = 0
ui.stone = 0
ui.coins = 0

obj_count = 15
coins_count=100
o1={icon=spr_tree,t1="gather "..obj_count,t2="trees"}
o2={icon=spr_stone,t1="gather "..obj_count,t2="stones"}
o3={icon=spr_rail_h,t1="connect paris",t2="to tokyo"}
o4={icon=spr_loco_h,t1="drive the",t2="train to tokyo"}
o5={icon=spr_coins,t1="earn "..coins_count.. " coins",t2=""}
o6={icon=spr_coins,t1="unlock a new",t2="area"}
function o1:completed()
    return ui.tree >= obj_count
end
function o2:completed()
    return ui.stone >= obj_count
end
function o3:completed()
    return array_contains(world.connected_cities, "tokyo")
end
function o4:completed()
    return train.city == "tokyo"
end
function o5:completed()
    return ui.coins >= coins_count
end
function o6:completed()
    return world.areas_unlocked > 1
end
ui.objectives = {o1, o2, o3, o4, o5, o6}

rail_cost_stone = 2
rail_cost_tree = 3

function getspr(spr)
    __x = (spr % 16) * 8
    __y = (spr \ 16) * 8
    return __x, __y
end

function ui:refresh_objective()
    self.objective = nil
    for i=1,#self.objectives do
        if not self.objectives[i].done then
            if self.objectives[i].completed() then
                self.objectives[i].done = true
            else
                self.objective = self.objectives[i]
                break
            end
        end
    end
end

function ui:update()
    self:refresh_objective()
end

ui_col1 = 13
ui_col2 = 1
ui_text_col=7
ui_text_col2=13

function draw_small_icon(__icon, __dx, __dy)
    _x, _y = getspr(__icon)
    sspr(_x, _y, 8, 8, __dx, __dy, scale, scale)
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
    if self.objective then
        xo = 60
        ho = 14
        if #self.objective.t2 == 0 then
            ho = 8
        end
        draw_win(xo, -1, 128-xo, ho, ui_col1, ui_col2)
        draw_small_icon(self.objective.icon, xo+2, 1)
        print(self.objective.t1, xo+2+6, 1, ui_text_col)
        print(self.objective.t2, xo+2, 7, ui_text_col)
    end

    cba, has_coins = world:can_buy_area(player.below_item)
    cbr, has_rsc = player.below_item:can_build_rail()
    cel = train:can_enter_loco(player.p)
    cll = train:can_leave_loco(player.below_item)
    if cba then
        self:draw_buy_area(has_coins)
    elseif cbr then
        self:draw_build_rail(has_rsc)
    elseif cel then
        self:draw_enter_loco()
    elseif cll then
        self:draw_use_loco()
    end
end

function ui:draw_build_rail(has_rsc)
    enough_col = ui_text_col
    not_enough_col = 8
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

function ui:draw_buy_area(has_coins)
    enough_col = ui_text_col
    not_enough_col = 8
    y = 7
    draw_win(-1, y, 41, 14, ui_col1, ui_col2)
    print("\x8ebuy area", 1, y+2, ui_text_col)
    x=1
    draw_small_icon(spr_coins, x, y+8)
    if world:next_area_cost() <= self.coins then c = enough_col else c = not_enough_col end
    print(world:next_area_cost(), x+6, y+8, c)
end

function ui:draw_enter_loco()
    y = 7
    draw_win(-1, y, 30, 14, ui_col1, ui_col2)
    print("\x8eenter", 1, y+2, ui_text_col)
    draw_small_icon(spr_loco_h, 21, y+8)
    print("train", 1, y+8)
end

function ui:draw_use_loco()
    y = 7
    draw_win(-1, y, 42, 14, ui_col1, ui_col2)
    print("\x8espeed up", 1, y+2, ui_text_col)
    print("\x97leave", 1, y+8, ui_text_col)
    --draw_small_icon(spr_loco_h, 21, y+8)
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

function ui:draw_title()

    c1=nil
    c2=nil
    c3=8
    y=5
    draw_rwin(32, y*8-24, 128-64-4, 4*8+28, 1, 7)
    palt(5,true) -- remove backgnd
    palt(6,true) -- remove lines
    palt(0,false) -- shadow draws
    pal(0,13)
    sprintc("the", y, c1, c2, c3)
    sprintc("tiny", y+1, c1, c2, c3)
    sprintc("train", y+2, c1, c2, c3)
    sprintc("driver", y+3, c1, c2, c3)
    palt(5,false)
    palt(6,false)
    pal(0,0)
    palt(0,true)

    if flr(time()*4) % 10 < 7 then
        sx, sy = 112,112
    else
        sx, sy = 40,120
    end
    sspr(sx, sy, 8, 8, 32+16+8-1, 21, 16, 16)

    if flr(time()*8) % 4 > 0 then
        printco("press \x8e to start", 90, ui_col2, ui_text_col)
    end
end