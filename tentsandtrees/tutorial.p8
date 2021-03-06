function draw_tutorial(page)
    cls(bg_col)

    color(0)
    printc("\x8b  instructions "..page.."/3  \x91", 2)

    height = 7
    top = 17
    left = 4
    if page == 1 then
        l = {
            {GR,GR,TR,TE},
            {TR,TE,GR,GR},
            {TR,GR,GR,GR},
            {TE,TR,TE,GR}
        }
        tuto_level = load_level_from_def(l)
        tuto_level.origin.y += 6
        tuto_level.no_anims=true
        ti = flr(time()*2) % 10
        if ti > 1 then
            tuto_level:set_cell_state(2,3,GR)
            tuto_level:set_cell_state(3,3,GR)
            tuto_level:set_cell_state(4,3,GR)
        end
        if ti > 2 then
            tuto_level:set_cell_state(4,2,GR)
            tuto_level:set_cell_state(4,4,GR)
        end
        if ti > 3 then
            tuto_level:set_cell_state(1,4,TE)
            tuto_level:set_cell_state(3,4,TE)
        end
        if ti > 4 then
            tuto_level:set_cell_state(1,1,GR)
            tuto_level:set_cell_state(3,2,GR)
        end
        if ti > 5 then
            tuto_level:set_cell_state(2,2,TE)
            tuto_level:set_cell_state(3,2,GR)
        end
        if ti > 6 then
            tuto_level:set_cell_state(2,1,GR)
            tuto_level:set_cell_state(4,1,TE)
        end
        tuto_level:draw()
        color(text_col)
        print("trees are placed in a grid.", left, top)
        top += height
        print("you have to place a tent next\nto each tree.", left, top)
        top = 100
        print("the numbers around the grid\ntell you the number of tents\nin the corresponding row or\ncolumn.", left, top)
    elseif page == 2 then
        color(text_col)
        top += 5
        print("each tent must be in one of\nthe four adjacent cells of its\nassociated tree (horizontally\nor vertically but not\ndiagonally).", left, top)
        l = {
            {GR,GR,GR},
            {GR,TR,GR},
            {GR,GR,GR},
        }
        tuto_level = load_level_from_def(l, false)
        tuto_level.no_anims=true
        tuto_level.origin.x -= 4
        tuto_level.origin.y += 15
        tuto_level.show_numbers = false
        ti = flr(time()*2) % 4
        if ti == 0 then
            tuto_level:set_cell_state(1,2,TE)
        end
        if ti == 1 then
            tuto_level:set_cell_state(2,3,TE)
        end
        if ti == 2 then
            tuto_level:set_cell_state(3,2,TE)
        end
        if ti == 3 then
            tuto_level:set_cell_state(2,1,TE)
        end
        tuto_level:draw()
    elseif page == 3 then
        top += 5
        print("tent cannot touch each other,\nnot even diagonally", left, top, text_col)
        l = {
            {GR,GR,TR,TE},
            {TR,TE,GR,TE},
            {TE,GR,GR,TR},
            {TR,GR,GR,GR},
        }
        tuto_level = load_level_from_def(l, false)
        tuto_level.origin.x -= 4
        tuto_level.origin.y += 8
        tuto_level.show_numbers = false
        tuto_level.no_anims=true
        tuto_level:draw()
        ti = flr(time() * 3)
        if ti % 2 == 0 then
            sx, sy, sw, sh = 11, 0, 11, 11
            sspr(sx, sy, sw, sh, tuto_level.origin.x + 3 * 12 + 1, tuto_level.origin.y + 1)
            sspr(sx, sy, sw, sh, tuto_level.origin.x + 1 * 12 + 1, tuto_level.origin.y + 1 * 12 + 1)
        end
    end
end

function input_tutorial()
    if btnp(buttons.b1) or btnp(buttons.b2) or btnp(buttons.right) then
        sound_menu_valid()
        tutorial = (tutorial + 1) % 4
    end
    if btnp(buttons.left) and tutorial != 1 then
        sound_menu_valid()
        tutorial = tutorial - 1
    end
end