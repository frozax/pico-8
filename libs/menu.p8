function create_menu(mis)

    menu = {}
    menu.menu_items=mis
    menu.button_bg_col = 6
    menu.button_text_col = 0
    menu.menu_selection = 1
    menu.menu_item_border = 2
    menu.menu_item_height = 5 + 2 * menu.menu_item_border

    max_text_width = 0
    for mi in all(menu.menu_items) do
        max_text_width = max(max_text_width, #mi.text)
    end
    menu.menu_item_width = max_text_width * 4 - 1 + 2 * menu.menu_item_border

    function menu:draw(y)
        for i=1,#self.menu_items do
            draw_item(y, self.menu_item_width, self.menu_item_height, self.button_bg_col, self.button_text_col, self.menu_items[i].text, self.menu_selection==i)
            y += self.menu_item_height + 2
        end
    end

    function menu:input()
        if btnp(buttons.down) then
            if self.menu_selection < #self.menu_items then
                self.menu_selection += 1
                sound_menu_move()
            else
                sound_menu_error()
            end
        end
        if btnp(buttons.up) then
            if self.menu_selection > 1 then
                self.menu_selection -= 1
                sound_menu_move()
            else
                sound_menu_error()
            end
        end
        if btnp(buttons.b1) then
            self.menu_items[self.menu_selection].click()
        end
    end

    return menu
end

function draw_item(y, menu_item_width, menu_item_height, button_bg_col, button_text_col, text, selected)
    text_width = #text * 4 - 1
    x = 64 - menu_item_width * 0.5
    rectfill(x, y, x + menu_item_width - 1, y + menu_item_height - 1, button_bg_col)
    c = 0
    if selected then
        if (flr(time() * 5)) % 2 == 0 then
            c = 7
        end
        rect(x, y, x + menu_item_width - 1, y + menu_item_height - 1, c)
    end
    text_height = 5
    print(text, x + (menu_item_width - text_width)/2, y + (menu_item_height - text_height)/2, button_text_col)
end
