-- size
level_number_w, level_number_h = 13, 13

-- 0-based
function draw_level_number(x, y, number)
    --if save:completed(i) TODO
    if is_level_completed(number) then
        c = 3
    else
        c = 5
    end
    rectfill(x, y, x + level_number_w - 1, y + level_number_h - 1, c)

    text = tostr(number + 1)
    x_text_shift = (level_number_w - (#text * 4 - 1)) / 2
    print(text, x_text_shift + x, level_number_h / 2 - 5 / 2 + y, colors.white)
end

function create_level_select(nb_levels)
    level_select = {}
    level_select.nb_levels = nb_levels
    level_select.selection = 0 -- 0-based
    level_per_row = 5
    rows = ceil(nb_levels / level_per_row)
    -- spacing
    level_select.sx, level_select.sy = level_number_w + 4, level_number_h + 4
    level_select.total_width = level_select.sx * (level_per_row - 1) + level_number_w
    level_select.origin_x = (128 - level_select.total_width) / 2

    function level_select:draw(origin_y)
        i = 0
        for y=0,rows-1 do
            for x=0,level_per_row-1 do
                if i == self.selection then
                    c = blink(5, 0, 7)
                    rect(self.origin_x + x * self.sx - 1, origin_y + y * self.sy - 1, self.origin_x + x * self.sx + level_number_w, origin_y + y * self.sx + level_number_h, c)
                end

                draw_level_number(self.origin_x + x * self.sx, origin_y + y * self.sy, i)

                i += 1
            end
        end
    end

    function level_select:input()
        if btnp(buttons.left) then
            if self.selection > 0 then
                self.selection-=1
                sound_menu_move()
            else
                sound_menu_error()
            end
        end
        if btnp(buttons.right) then
            if self.selection < self.nb_levels - 1 then
                self.selection += 1
                sound_menu_move()
            else
                sound_menu_error()
            end
        end
        if btnp(buttons.down) then
            if self.selection + level_per_row < self.nb_levels then
                self.selection += level_per_row
                sound_menu_move()
            else
                sound_menu_error()
            end
        end
        if btnp(buttons.up) then
            if self.selection >= level_per_row then
                self.selection -= level_per_row
                sound_menu_move()
            else
                sound_menu_error()
            end
        end
        if btnp(buttons.b1) then
            --load_level()
            sound_menu_valid()
            level_number = self.selection
            mode = "game"
        end
        if btnp(buttons.b2) then
            sound_menu_back()
            mode = "home"
        end
    end

    return level_select
end