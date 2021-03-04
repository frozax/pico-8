function draw_level_number_ingame()
    if (level_number <= 1) return -- tuto
    if game_level.h < 9 then
        draw_level_number(127 - level_number_w-1, 1, level_number)
    end
end

function get_level_origin()
    pix_size = level.w * (cell_size)
    origin = vec2((128 - pix_size)/2, (128 - pix_size)/2 + 2)
    if (level_number == 0) origin.y = 100
    if (level_number == 3) origin.y = 60
    return origin
end

function draw_tutorial()
    if level_number == 0 then
        printc("the goal of the game is to fill", 2, 6)
        printc("the thermometers with mercury.")
        ongoing_y += 20
        for type=0, 2 do
            spr_x = (type+1) * 17
            if type == 0 then
                xs = 8
            else
                xs = (2-type+1) * 40 + 8
            end

            for piece=0,1 do
                spr_y = piece * 17 * 2
                sspr(spr_x, spr_y, cell_size, cell_size, xs+piece*16, 17, cell_size, cell_size, flipx)
            end
        end
        printc("unknown   filled    empty ")
        ongoing_y += 5
        printc("numbers show the quantity of")
        printc("cells with mercury in the")
        printc("corresponding row or column.")
        ongoing_y += 3
        printc("go ahead and put mercury in")
        printc("the first 3 cells")
        ongoing_y += 8
        printc("\x8b\x91\x94\x83: select a cell")
        printc("c/\x8e: change cell state")
    elseif level_number == 1 then
        printc("thermometers must be filled", 2, 6)
        printc("from the base up.")
        ongoing_y += 3
        printc("fill the thermometers")
        printc("accordingly")
    elseif level_number == 2 then
        printc("when there is mercury in the", 16, 6)
        printc("tip of a thermometer, you can")
        printc("be sure there is also mercury")
        printc("down to the base.")
    elseif level_number == 3 then
        printc("you can mark a cell as empty", 16, 6)
        printc("by pressing \x8e twice.")
        ongoing_y += 3
        printc("this can be useful when")
        printc("solving complex levels.")
    end
end

function draw_commands()
    if game_level.h <= 6 then
        -- draw input
        --printc("v/\x97: display menu", 117, text_col)





    end
end

function draw_instructions()
    draw_level_number_ingame()
    draw_tutorial()
    draw_commands()
end
