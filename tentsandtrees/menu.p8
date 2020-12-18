function init_menu(mis)
    menu_items = mis

    button_bg_col = 6
    button_text_col = 0
    menu_selection = 1
    menu_item_border = 2
    menu_item_height = 5 + 2 * menu_item_border
    max_text_width = 0
    for mi in all(menu_items) do
        max_text_width = max(max_text_width, #mi.text)
    end
    menu_item_width = max_text_width * 4 - 1 + 2 * menu_item_border
end

function draw_title()
    rectfill(1, 1, 126, 40, 8)
end

function draw_item(y, item, selected)
    text_width = #item.text * 4 - 1
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
    print(item.text, x + (menu_item_width - text_width)/2, y + (menu_item_height - text_height)/2, button_text_col)
end

function draw_mainmenu(y)
    for i=1,#menu_items do
        draw_item(y, menu_items[i], menu_selection==i)
        y += menu_item_height + 2
    end
end

function input_menu()
    if btnp(buttons.down) then
        if menu_selection < #menu_items then
            menu_selection += 1
            sound_menu_move()
        else
            sound_menu_error()
        end
    end
    if btnp(buttons.up) then
        if menu_selection > 1 then
            menu_selection -= 1
            sound_menu_move()
        else
            sound_menu_error()
        end
    end
    if btnp(buttons.b1) then
        menu_items[menu_selection].click()
    end
end