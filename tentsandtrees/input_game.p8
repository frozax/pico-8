function init_input()
    input = {}
    input.pos = vec2(0, 0) -- lua: 0-based
end

function input_game(level)
    if btnp(0) then
        if input.pos.x > 0 then
            input.pos.x -= 1
            sound_move()
        else
            sound_move_error()
        end
    end
    if btnp(1) then
        if input.pos.x < level.size - 1 then
            input.pos.x += 1
            sound_move()
        else
            sound_move_error()
        end
    end
    if btnp(2) then
        if input.pos.y > 0 then
            input.pos.y -= 1
            sound_move()
        else
            sound_move_error()
        end
    end
    if btnp(3) then
        if input.pos.y < level.size - 1 then
            input.pos.y += 1
            sound_move()
        else
            sound_move_error()
        end
    end
    if btnp(buttons.b1) then
        if level:cycle_cell(input.pos.x + 1, input.pos.y + 1) then
            sound_toggle()
        else
            sound_toggle_error()
        end
    end
    if btnp(buttons.b2) then
        sound_menu_back()
        pause_menu.selection = 1
        pause = true
    end
end

function draw_input()
    top_left = vec2(game_level.origin.x + input.pos.x * cell_size,
        game_level.origin.y + input.pos.y * cell_size)
    size = cell_size-1

    if (flr(time() * 3.0) % 2) == 0 then
        c = 0
    else
        c = 7
        --rect(top_left.x, top_left.y, top_left.x + size, top_left.y + size, c)
    end
    rect(top_left.x+1, top_left.y+1, top_left.x + size, top_left.y + size, c)
end