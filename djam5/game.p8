game = {}
game.state = ""
GS_MAINMENU = "mainmenu"
GS_GAME = "game"
GS_EOL = "eol"
GS_GAMEOVER = "gameover"

function game:init()
    self.credits = false
    self.how_to_play = false
    bplay = {text="play"}
    function bplay:click()
        game:set_state(GS_GAME)
    end
    bhtp = {text="how to play"}
    function bhtp:click()
        game.how_to_play = true
    end
    bc = {text="credits"}
    function bc:click()
        game.credits = true
    end
    self.mainmenu_menu = create_menu({bplay, bhtp, bc}, shadow_col)
end

function game:update()
    if self.state == GS_MAINMENU then
        if self.credits or self.how_to_play then
            if btnp(buttons.b1) or btnp(buttons.b2) then
                sound_menu_back()
                self.credits = false
                self.how_to_play = false
            end
        else
            self.mainmenu_menu:input()
        end
    elseif self.state == GS_GAME then
        -- before to detect buttons before using them
        help:update()
        if (cur_dna) cur_dna:update()
        if (dst_dna) dst_dna:update()
        ui:update()
    end
end

function game:draw()
    cls(1)

    if self.state == GS_MAINMENU then
        self.mainmenu_menu:draw(60)
        printc("dna", 10, 7)
        printc("mutations", 16, 7)
        if self.credits then
            y = 44
            draw_rwin(8+1, y+1, 127-16, 127-48, shadow_col, shadow_col)
            draw_rwin(8, y, 127-16, 127-48, bg_col, 0)
            y += 9
            c = 7
            printc("code, art, design:", y, c)
            printc("@frozax", y+7, c)
            printc("sound:", y+50, c)
            printc("@gruber_music", y+57, c)
        elseif self.how_to_play then
            y = 44
            draw_rwin(8+1, y+1, 127-16, 127-48, shadow_col, shadow_col)
            draw_rwin(8, y, 127-16, 127-48, bg_col, 0)
            y += 9
            c = 7
            printc("todo", y, c)
        end
    elseif self.state == GS_GAME then
        cur_dna:draw()
        dst_dna:draw()
        ui:draw()
        help:draw()
    end
end

function game:set_state(stt)
    self.state = stt
end