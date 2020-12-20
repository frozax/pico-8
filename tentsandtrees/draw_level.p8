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
    for i=0, level.size-1 do
        -- rows
        row = level:compute_row_infos(i+1)
        print(row.nb, level.origin.x - cell_size/2, level.origin.y + (i + 0.5) * cell_size - 2, row.color)
        -- cols
        col = level:compute_col_infos(i+1)
        print(col.nb, level.origin.x + (i + 0.5) * cell_size - 1, level.origin.y - cell_size * 0.5, col.color)
    end
end

function draw_cell_bgs(level)
    ys = level.origin.y + 1
    size = cell_inner_size - 1 -- because it's final pixel, not size of rect
    for y=1, level.size do
        xs = level.origin.x + 1
        for x=1, level.size do
            c = level:get_cell_bg_color(x, y)
            rectfill(xs, ys, xs + size, ys + size, c)
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