function init_input()
    input = {}
    input.pos = vec2(0, 0) -- lua: 0-based
    input.last_tap = vec2(-1,-1)
    input.new_type = FILLED
end

function input_game(level)
    if btnp(0) then
        input.pos.x -= 1
        if input.pos.x < 0 then
            input.pos.x = level.w - 1
        end
        sound_move()
    end
    if btnp(1) then
        input.pos.x += 1
        if input.pos.x >= level.w then
            input.pos.x = 0
        end
        sound_move()
    end
    if btnp(2) then
        input.pos.y -= 1
        if input.pos.y < 0 then
            input.pos.y = level.h - 1
        end
        sound_move()
    end
    if btnp(3) then
        input.pos.y += 1
        if input.pos.y >= level.h then
            input.pos.y = 0
        end
        sound_move()
    end
    if btn(buttons.b1) then
        if input.pos.x != input.last_tap.x or input.pos.y != input.last_tap.y then
            was_none = input.last_tap.x == -1
            printh("b1"..tostring(input.pos).." "..tostring(input.last_tap).."was_none"..tostring(was_none))
            input.last_tap.x = input.pos.x
            input.last_tap.y = input.pos.y
            if was_none then
                level:cycle_cell(input.pos.x, input.pos.y)
                input.new_type = level.cells[input.pos.x][input.pos.y].state
                printh("new_type"..input.new_type)
            else
                level.cells[input.pos.x][input.pos.y].state = input.new_type
            end
            sound_toggle()
        end
    else
        input.last_tap.x = -1
        input.last_tap.y = -1
    end
    if btnp(buttons.b2) then
        sound_menu_back()
        pause_menu.selection = 1
        pause = true
    end
end

function draw_input()
    input_size = cell_size - 1
    top_left = vec2(game_level.origin.x + input.pos.x * input_size,
        game_level.origin.y + input.pos.y * input_size)
    size = input_size + 1

    if (flr(time() * 8.0) % 4) == 0 then
        c = 0
    else
        c = 7
        sspr(0, cell_size, cell_size, cell_size, top_left.x+1, top_left.y+1)
    end
end