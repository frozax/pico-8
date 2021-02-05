function create_menu(mis)
    menu = {}
    menu.items=mis
    menu.selection = 1
    menu.top_item = 1   -- case of scrolling
    items_per_screen = 4

    function menu:update()
        if btnp(buttons.down) then
            self.selection += 1
            if self.selection > #self.items then
                self.selection = 1
                self.top_item = 1
            end
            if self.selection >= self.top_item + items_per_screen then
                self.top_item += 1
            end
            sfx_menu_change_sel()
        end
        if btnp(buttons.up) then
            self.selection -= 1
            if self.selection == 0 then
                self.selection = #self.items
                self.top_item = self.selection - items_per_screen + 1
                if self.top_item <= 0 then
                    self.top_item = 1
                end
            end
            if self.selection < self.top_item then
                self.top_item = self.selection
            end
            sfx_menu_change_sel()
        end
        if btnp(buttons.b1) then
            sfx_menu_valid()
            self.items[self.selection]:click()
        end
    end

    function menu:draw()
        y = soy + 2
        for imi=self.top_item, self.top_item+items_per_screen - 1 do
            if imi > #self.items then
                break
            end
            text_col = fg
            if imi == self.selection then
                rectfill(sox + 1, y - 1, sox + 84-6, y + 8, fg)
                text_col = bg
            end
            _print(self.items[imi].text, sox + 2, y, text_col)
            y += 12
        end
        pct = (self.selection-1) / (#self.items-1)
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
        sfx_valid()
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
    if logo_y.value != soy + 9 or not rnd_erase then
        sspr(62, 0, 65, 40, sox + 9, logo_y.value)
    end
    sspr(0 and rnd_erase or 14, 0, 14, 22, sox+55, logo_y.value+17)

    -- display time
    minutes = tostring(stat(94))
    if #minutes == 1 then
        minutes = "0"..minutes
    end
    _print(stat(93)..":"..minutes, sox + sw - 31, soy + 1, fg)
end

mis = {}
for i=1,#levels do
    l = levels[i]
    mi = {text=i..". ".."sw:"..l.nb_switches.."  lig:"..#l.nb_light_per_switch_chances}
    function mi:click()
        game.level = i
        set_state("game")
    end
    add(mis, mi)
end
btn_b = {text="Back"}
function btn_b:click()
    set_state("options")
end
add(mis, btn_b)
levelselect = {menu=create_menu(mis)}

function levelselect:update()
    self.menu:update()
end

function levelselect:draw()
    self.menu:draw()
end

options = {}
mi_ng = {text="New Game"}
function mi_ng:click()
    game.level = 1
    set_state("game")
end
mi_htp = {text="How to Play"}
function mi_htp:click()
    set_state("howtoplay1")
end
mi_sl = {text="Select Level"}
function mi_sl:click()
    set_state("levelselect")
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
