function create_menu(mis)
    menu = {}
    menu.items=mis
    menu.selection = 1
    menu.top_item = 1   -- case of scrolling

    function menu:update()
        if btnp(buttons.down) then
            menu.selection += 1
            if menu.selection > #menu.items then
                menu.selection = 1
                menu.top_item = 1
            end
        end
        if btnp(buttons.up) then
            menu.selection -= 1
            if menu.selection == 0 then
                menu.selection = #menu.items
                menu.top_item = menu.selection - 4
                if menu.top_item <= 0 then
                    menu.top_item = 1
                end
            end
        end
        if btnp(buttons.b1) then
            menu.items[menu.selection]:click()
        end
    end

    function menu:draw()
        y = soy + 2
        for imi=menu.top_item, menu.top_item+3 do
            text_col = fg
            if imi == menu.selection then
                rectfill(sox + 1, y - 1, sox + 84-9, y + 8, fg)
                text_col = bg
            end
            _print(menu.items[imi].text, sox + 2, y, text_col)
            y += 12
        end
        pct = (menu.selection-1) / (#menu.items-1)
        scroll_bar_min = soy + 1
        scroll_bar_max = soy + sh - 1 - 7
        scroll_bar_size = scroll_bar_max - scroll_bar_min
        top_sb = scroll_bar_min + scroll_bar_size * pct
        bottom_sb = top_sb + 6
        x = sox + sw - 4
        set_pal()
        sspr(54, 1, 4, 7, x, top_sb)
        line(x, soy + 1, x, top_sb)
        line(x, bottom_sb, x, soy + sh - 2)
    end

    return menu
end

mainmenu = {}

function mainmenu:_start_game()
    set_state("options")
    options.menu.selection = 1
end

function mainmenu:update()
    if btnp(buttons.b1) then
        self:_start_game()
    end
end

function mainmenu:draw_battery()
    set_pal()
    sspr(48, 0, 5, 40, sox + sw - 5, soy)
end

function mainmenu:draw_network()
    set_pal()
    sspr(40, 0, 5, 40, 1 + sox, soy)
end

function mainmenu:draw()
    -- show battery and network
    self:draw_battery()
    self:draw_network()

    -- draw logo
    if logo_y.value != soy + 10 or not rnd_erase then
        sspr(62, 0, 65, 40, sox + 10, logo_y.value)
    end

    -- display time
    minutes = tostring(stat(94))
    if #minutes == 1 then
        minutes = "0"..minutes
    end
    _print(stat(93)..":"..minutes, sox + sw - 31, soy + 1, fg)
end

levelselect = {}

function levelselect:update()
end

function levelselect:draw()
end

options = {}
mi_ng = {text="New Game"}
function mi_ng:click()
    set_state("game")
end
mi_htp = {text="How to Play"}
function mi_htp:click()
    set_state("howtoplay1")
end
mi_sl = {text="Select Level"}
function mi_sl:click()
end
mi_b = {text="Back"}
function mi_b:click()
    set_state("mainmenu")
end
options.menu = create_menu({mi_ng, mi_htp, mi_sl, mi_b})

function options:update()
    self.menu:update()
end

function options:draw()
    self.menu:draw()
end