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
    if btnp(4) or btnp(5) then
        if level:cycle_cell(input.pos.x + 1, input.pos.y + 1) then
            sound_toggle()
        else
            sound_toggle_error()
        end
    end
end

function draw_input()
    top_left = vec2(game_level.origin.x + input.pos.x * cell_size,
        game_level.origin.y + input.pos.y * cell_size)
    size = cell_size

    if (flr(time() * 3.0) % 2) == 0 then
        c = 0
    else
        c = 7
    end

    rect(top_left.x, top_left.y, top_left.x + size, top_left.y + size, c)
end