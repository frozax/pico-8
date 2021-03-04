function init_input()
    input = {}
    input.pos = vec2(0, 0) -- lua: 0-based
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
    if btnp(buttons.b1) then
        if level:cycle_cell(input.pos.x, input.pos.y) then
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