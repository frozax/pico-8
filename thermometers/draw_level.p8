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
    for i=0, level.h-1 do
        if band(level.def.hide_rows_nbs, 1 << i) == 0 then
            -- rows
            ri = level:compute_row_infos(i)
            sspr(cell_size*4, level:rc_spr_y(ri), cell_size, cell_size, level.origin.x - cell_size, level.origin.y+(cell_size-1)*i + 1)
            print(ri.expected, level.origin.x - cell_size/2 + 1, level.origin.y + (i + 0.5) * (cell_size-1) - 1, level:rc_num_color(ri))
        end
    end
    for i=0, level.w-1 do
        if band(level.def.hide_cols_nbs, 1 << i) == 0 then
            -- cols
            ri = level:compute_col_infos(i)
            sspr(cell_size*4, level:rc_spr_y(ri), cell_size, cell_size, level.origin.x + (cell_size-1) * i - 1, level.origin.y - cell_size + 2)
            print(ri.expected, level.origin.x + (i + 0.5) * (cell_size-1), level.origin.y - cell_size*0.5 + 0, level:rc_num_color(ri))
        end
    end
end

function draw_cell_bgs(level)
    ys = level.origin.y + 1
    for y=0, level.h-1 do
        xs = level.origin.x+ 1
        for x=0, level.w-1 do
            c = level:get_cell_bg_color(x, y)
            sspr(0, 0, cell_size, cell_size, xs, ys)
            if y != 0 and x != 0 then
                -- place pix top left
                pset(xs, ys, med_blue)
            end
            xs += cell_size - 1 -- because overlap
        end
        ys += cell_size - 1 -- because overlap
    end
end

function draw_cell_sprites(level)
    ys = level.origin.y + 1
    size = cell_size - 1 -- because it's final pixel, not size of rect
    for y=0, level.h-1 do
        xs = level.origin.x + 1
        for x=0, level.w-1 do
            cell = level.cells[x][y]
            spr_x = 17
            if (cell.state == EMPTY) spr_x += 17
            if (cell.state == FILLED) spr_x += 17 * 2
            spr_y = 0
            if (cell.extremity == MIDDLE) spr_y += 17
            if (cell.extremity == END) spr_y += 17 * 2
            
            if cell.dir == DOWN then
                rotate(spr_x, spr_y, 0, xs, ys, cell_size-1, cell_size-1)
            elseif cell.dir == UP then
                rotate(spr_x, spr_y, 1, xs, ys, cell_size-1, cell_size-1)
            else
                flipx = cell.dir == LEFT
                sspr(spr_x, spr_y, cell_size, cell_size, xs, ys, cell_size, cell_size, flipx)
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
            xs += cell_size - 1
        end
        ys += cell_size - 1
    end
end