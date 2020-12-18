function create_level_select(nb_levels)
    level_select = {}
    level_select.nb_levels = nb_levels
    level_select.selection = 0 -- 0-based
    level_per_row = 5
    rows = ceil(nb_levels / level_per_row)
    -- size
    level_select.w, level_select.h = 13, 13
    -- spacing
    level_select.sx, level_select.sy = level_select.w + 4, level_select.h + 4
    level_select.total_width = level_select.sx * (level_per_row - 1) + level_select.w
    level_select.origin_x = (128 - level_select.total_width) / 2

    function level_select:draw(origin_y)
        cls(bg_col)
        i = 0
        for y=0,rows-1 do
            for x=0,level_per_row-1 do
                if i == self.selection then
                    c = blink(5, 0, 7)
                    rect(self.origin_x + x * self.sx - 1, origin_y + y * self.sy - 1, self.origin_x + x * self.sx + self.w, origin_y + y * self.sx + self.h, c)
                end
                --if save:completed(i) TODO
                if i == 4 then
                    c = 3
                else
                    c = 5
                end
                rectfill(self.origin_x + x * self.sx, origin_y + y * self.sy, self.origin_x + x * self.sx + self.w - 1, origin_y + y * self.sx + self.h - 1, c)

                text = tostr(i + 1)
                x_text_shift = (self.w - (#text * 4 - 1)) / 2
                print(i + 1, x_text_shift + self.origin_x + x * self.sx, self.h / 2 - 5 / 2 + origin_y + y * self.sy, colors.white)

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
            self.items[self.selection].click()
        end
    end

    return level_select
end