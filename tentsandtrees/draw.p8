origin = vec2(30, 30)

function draw_grid()
    x0, y0 = origin.x, origin.y
    x1 = x0 + level.size * cell_size
    y1 = y0 + level.size * cell_size

    for i=0, level.size do
        x = origin.x + i * cell_size
        y = origin.y + i * cell_size
        line(x, y0, x, y1, grid_col)
        line(x0, y, x1, y, grid_col)
    end
end

function draw_numbers()
    for i=0, level.size-1 do
        -- rows
        print(level.rows[i+1].nb, origin.x - cell_size/2, origin.y + (i + 0.5) * cell_size - 2, numbers_wip_col)
        -- cols
        print(level.cols[i+1].nb, origin.x + (i + 0.5) * cell_size - 1, origin.y - cell_size * 0.5, numbers_wip_col)
    end
end

function draw_cell_bgs()
    ys = origin.y + 1
    size = cell_inner_size - 1 -- because it's final pixel, not size of rect
    for y=1, level.size do
        xs = origin.x + 1
        for x=1, level.size do
            c = level:get_cell_bg_color(x, y)
            rectfill(xs, ys, xs + size, ys + size, c)
            xs += cell_size
        end
        ys += cell_size
    end
end

function draw_cell_sprites()
    ys = origin.y + 1
    size = cell_inner_size - 1 -- because it's final pixel, not size of rect
    for y=1, level.size do
        xs = origin.x + 1
        for x=1, level.size do
            stt = level:get_cell_state(x, y)
            if stt == TE then
                sspr(0, 0, cell_inner_size, cell_inner_size, xs, ys)
            elseif stt == TR then
                sspr(0, 11, cell_inner_size, tree_height, xs, ys + cell_inner_size - tree_height - 1)
            end
            xs += cell_size
        end
        ys += cell_size
    end
end