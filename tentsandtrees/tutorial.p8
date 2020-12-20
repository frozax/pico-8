function draw_tutorial(page)
    cls(bg_col)

    text_color = 5
    color(0)
    print("\x8b  instructions "..page.."/3  \x91", 13, 2)

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
        tuto_level = load_level(l)
        tuto_level.origin.y += 8
        ti = flr(time()*2) % 10
        if ti > 1 then
            tuto_level.state[3][2] = GR
            tuto_level.state[3][3] = GR
            tuto_level.state[3][4] = GR
        end
        if ti > 2 then
            tuto_level.state[2][4] = GR
            tuto_level.state[4][4] = GR
        end
        if ti > 3 then
            tuto_level.state[4][1] = TE
            tuto_level.state[4][3] = TE
        end
        if ti > 4 then
            tuto_level.state[1][1] = GR
            tuto_level.state[2][3] = GR
        end
        if ti > 5 then
            tuto_level.state[2][2] = TE
            tuto_level.state[2][3] = GR
        end
        if ti > 6 then
            tuto_level.state[1][2] = GR
            tuto_level.state[1][4] = TE
        end
        tuto_level:draw()
        color(text_color)
        print("trees are placed in a grid.", left, top)
        top += height
        print("you have to place a tent next\nto each tree.", left, top)
        top = 100
        print("the numbers around the grid\ntell you the number of tents\nin the corresponding row or\ncolumn.", left, top)
    elseif page == 2 then
        color(text_color)
        top += 5
        print("each tent must be in one of\nthe four adjacent cells of its\nassociated tree (horizontally\nor vertically but not\ndiagonally).", left, top)
        l = {
            {GR,GR,GR},
            {GR,TR,GR},
            {GR,GR,GR},
        }
        tuto_level = load_level(l, false)
        tuto_level.origin.x -= 4
        tuto_level.origin.y += 17
        tuto_level.show_numbers = false
        ti = flr(time()*2) % 4
        if ti == 0 then
            tuto_level.state[2][1] = TE
        end
        if ti == 1 then
            tuto_level.state[3][2] = TE
        end
        if ti == 2 then
            tuto_level.state[2][3] = TE
        end
        if ti == 3 then
            tuto_level.state[1][2] = TE
        end
        tuto_level:draw()
        top += height * 3
    elseif page == 3 then
        top += height * 5
        print("tent cannot touch each other,\nnot even diagonally", left, top)
    end
end

function input_tutorial()
    if btnp(buttons.b1) or btnp(buttons.b2) or btnp(buttons.right) then
        tutorial = (tutorial + 1) % 4
    end
    if btnp(buttons.left) and tutorial != 1 then
        tutorial = tutorial - 1
    end
end