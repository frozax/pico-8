function draw_grid(level)
    x0, y0 = level.origin.x, level.origin.y
    x1 = x0 + level.size * cell_size
    y1 = y0 + level.size * cell_size

    for i=0, level.size do
        x = level.origin.x + i * cell_size
        y = level.origin.y + i * cell_size
        line(x, y0, x, y1, grid_col)
        line(x0, y, x1, y, grid_col)
    end
end

function draw_numbers(level)
    srand(0)
    for i=0, level.size-1 do
        -- rows
        row = level:compute_row_infos(i+1)
        if (10) < level.anim-20 or level.no_anims then
            print(row.nb, level.origin.x - cell_size/2, level.origin.y + (i + 0.5) * cell_size - 2, row.color)
        end
        -- cols
        col = level:compute_col_infos(i+1)
        if (10) < level.anim-20 or level.no_anims then
            print(col.nb, level.origin.x + (i + 0.5) * cell_size - 1, level.origin.y - cell_size * 0.5, col.color)
        end
    end
end

function draw_cell_bgs(level)
    srand(1)
    ys = level.origin.y + 1
    size = cell_inner_size - 1 -- because it's final pixel, not size of rect
    for y=1, level.size do
        xs = level.origin.x + 1
        for x=1, level.size do
            this_size = (level.anim - rnd(10))*2
            this_size = min(this_size, size)
            this_size = max(this_size, -1)
            if level.no_anims then
                this_size = size
            end
            if this_size >= 0 then
                shft = (size-this_size)/2
                c = level:get_cell_bg_color(x, y)
                rectfill(xs+shft, ys+shft, xs + shft + this_size, ys + shft + this_size, c)
            end
            xs += cell_size
        end
        ys += cell_size
    end
end

function draw_cell_sprites(level)
    ys = level.origin.y + 1
    size = cell_inner_size - 1 -- because it's final pixel, not size of rect
    for y=1, level.size do
        xs = level.origin.x + 1
        for x=1, level.size do
            stt = level:get_cell_state(x, y)
            anm = level:get_anim(x,y)
            if anm != nil and anm.frames then
                if anm.cur_frame < (#anm.frames*2) then
                    anm.cur_frame += 1
                end
                if level.no_anims then
                    anm.cur_frame = 2*#anm.frames
                end
                if anm.cur_frame > 1 then
                    anm.frame = anm.frames[anm.cur_frame \ 2]
                    anm:draw(vec2(xs, ys))
                end
            end
            --if stt != UN then
            --    if stt == TE then
            --        anim = tent_show
            --        tent_show.frame = tent_show.frames[4]
            --    elseif stt == TR then
            --        anim = tree_show
            --        tree_show.frame = tree_show.frames[4]
            --    end
            --    anim:draw(vec2(xs, ys))
            --end
            xs += cell_size
        end
        ys += cell_size
    end
end