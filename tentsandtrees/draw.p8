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
        print(i, origin.x - cell_size/2, origin.y + (i + 0.5) * cell_size - 2, numbers_wip_col)
        -- cols
        print(i, origin.x + (i + 0.5) * cell_size - 1, origin.y - cell_size * 0.5, numbers_wip_col)
    end
end

function draw_cell_bgs()
end