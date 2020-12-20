function create_menu(mis)

    menu = {}
    menu.items=mis
    menu.button_bg_col = 6
    menu.button_text_col = 0
    menu.selection = 1
    menu.item_border_x = 4
    menu.item_border_y = 2
    menu.item_height = 5 + 2 * menu.item_border_y

    max_text_width = 0
    for mi in all(menu.items) do
        max_text_width = max(max_text_width, #mi.text)
    end
    menu.item_width = max_text_width * 4 - 1 + 2 * menu.item_border_x

    function menu:draw(y)
        for i=1,#self.items do
            draw_item(y, self.item_width, self.item_height, self.button_bg_col, self.button_text_col, self.items[i].text, self.selection==i)
            y += self.item_height + 2
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
            self.items[self.selection].click()
        end
    end

    return menu
end

function draw_item(y, item_width, item_height, button_bg_col, button_text_col, text, selected)
    text_width = #text * 4 - 1
    x = 64 - item_width * 0.5
    rectfill(x, y, x + item_width - 1, y + item_height - 1, button_bg_col)
    c = 0
    if selected then
        if (flr(time() * 5)) % 2 == 0 then
            c = 7
        end
        rect(x, y, x + item_width - 1, y + item_height - 1, c)
    end
    text_height = 5
    print(text, x + (item_width - text_width)/2, y + (item_height - text_height)/2, button_text_col)
end
