function create_menu(mis, shadow)

    menu = {}
    menu.items=mis
    menu.hspacing = 3
    menu.button_bg_col = 6
    menu.button_shadow_col = shadow
    menu.button_text_col = 0
    menu.selection = 1
    menu.item_border_x = 4
    menu.item_border_y = 2
    menu.item_height = 5 + 2 * menu.item_border_y

    max_text_width = 0
    for mi in all(menu.items) do
        max_text_width = max(max_text_width, #mi.text+5)
    end
    menu.item_width = max_text_width * 4 - 1 + 2 * menu.item_border_x

    function menu:draw(y)
        for i=1,#self.items do
            self:draw_item(y, self.items[i].text, self.selection==i)
            y += self.item_height + self.hspacing
        end
    end

    function menu:input()
        if btnp(buttons.down) then
            if self.selection < #self.items then
                self.selection += 1
                sound_menu_move()
            else
                sound_menu_error()
            end
        end
        if btnp(buttons.up) then
            if self.selection > 1 then
                self.selection -= 1
                sound_menu_move()
            else
                sound_menu_error()
            end
        end
        if btnp(buttons.b1) then
            sound_menu_valid()
            self.items[self.selection]:click()
        end
    end

    function menu:draw_item(y, _text, selected)
        local text=_text
        local x = 64 - self.item_width * 0.5
        local y=y

        local shad_col = self.button_shadow_col
        local text_col = self.button_text_col
        local text_width = #text * 4 - 1
        if selected then
            x+=1
            y+=1
            shad_col = nil
                --text_col=9
            --end
            --text="\x8f "..text.." \x8f"
            --if (flr(time() * 5)) % 2 == 0 then
                text="\x8f "..text.." \x8f"
                text_width += 8*2+4*2
            --end
        end

        if shad_col then
            rectfill(x+1, y+1, x + self.item_width, y + self.item_height, shad_col)
        end
        rectfill(x, y, x + self.item_width - 1, y + self.item_height - 1, self.button_bg_col)
        c = 0
        --if selected then
        --        c = 9
        --        rect(x-1, y-1, x + self.item_width, y + self.item_height, c)
        --end
        text_height = 5
        print(text, x + (self.item_width - text_width)/2, y + (self.item_height - text_height)/2, text_col)
    end

    return menu
end
