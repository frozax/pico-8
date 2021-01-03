game = {}
game.state = ""
GS_MAINMENU = "mainmenu"
GS_SELECT_DIFF = "select_diff"
GS_GAME = "game"
GS_EOL = "eol"
GS_GAMEOVER = "gameover"

SAVE_ALREADY_PLAYED = 0

shadow_col=1

difficulties = {
    {text="very easy", length={4}, mutations={2}},
    {text="easy", length={5}, mutations={3,4}},
    {text="medium", length={6}, mutations={5,6}},
    {text="hard", length={7,8}, mutations={7,8}},
    {text="very hard", length={9}, mutations={9,10}},
    {text="extreme", length={10,11}, mutations={11,12}},
}

function game:init()
    self.credits = false
    self.how_to_play = false
    bplay = {text="play"}
    function bplay:click()
        game:set_state(GS_SELECT_DIFF)
    end
    bhtp = {text="how to play"}
    function bhtp:click()
        game.how_to_play = true
    end
    bc = {text="credits"}
    function bc:click()
        game.credits = true
    end
    --self.mainmenu_menu = create_menu({bplay, bc}, shadow_col)

    brestart={text="retry"}
    bmenu={text="main menu"}
    function brestart:click()
        game:set_state(GS_GAME)
        gen_level_precise(level.dna_length, level.mutations, level.srand)
        game:setup_level()
    end
    function bmenu:click()
        game:set_state(GS_MAINMENU)
    end
    self.game_over_menu = create_menu({brestart, bmenu}, shadow_col)

    bhelp={text="how to play"}
    function bhelp:click()
        help:show()
        game.pause_menu_on=false
    end
    bcontinue={text="resume"}
    function bcontinue:click()
        game.pause_menu_on = false
    end
    self.pause_menu = create_menu({bcontinue, bhelp, brestart, bmenu}, shadow_col)

    -- diff menu
    diff = {}
    for d=1,#difficulties do
        di = difficulties[d]
        b = {text=di.text,di=di}
        b.mutations=di.mutations[1]
        if #di.mutations > 1 then
            b.mutations ..="-"..di.mutations[2]
        end
        b.dna_length = di.length[1]
        if #di.length > 1 then
            b.dna_length ..="-"..di.length[2]
        end
        function b:click()
            game:set_state(GS_GAME, self.di)
        end
        add(diff, b)
    end
    self.diff_menu = create_menu(diff, shadow_col)
    self.diff_menu.forced_x = 50
end

function game:update()
    if self.state == GS_MAINMENU then
        menu_dna:update()
        if self.credits or self.how_to_play then
            if btnp(buttons.b1) or btnp(buttons.b2) then
                sound_menu_back()
                self.credits = false
                self.how_to_play = false
            end
        else
            if btnp(buttons.b1) then
                game:set_state(GS_SELECT_DIFF)
            end
        end
    elseif self.state == GS_SELECT_DIFF then
        menu_dna:update()
        if btnp(buttons.b2) then
            self:set_state(GS_MAINMENU)
        end
        self.diff_menu:input()
    elseif self.state == GS_GAME then
        -- before to detect buttons before using them
        help_was_on = help.show_help
        help:update()
        cur_dna:update()
        dst_dna:update()
        if self.pause_menu_on then
            self.pause_menu:input()
            if btnp(buttons.b2) then
                self.pause_menu_on = false
            end
        elseif help_was_on then
        else
            if btnp(buttons.b2) and ui.state == STT_SELECT_MUTATION then
                self.pause_menu_on = true
                self.pause_menu.selection = 1
            end
            ui:update()
            if array_equals(cur_dna.sequence, dst_dna.sequence) then
                particles:start()
                cur_dna:speed_up()
                dst_dna:speed_up()
                self:set_state(GS_EOL)
            else
                -- check game over
                if ui:all_remaining() == 0 then
                    cur_dna:stop()
                    dst_dna:stop()
                    self.game_over_menu.selection = 1
                    self:set_state(GS_GAMEOVER)
                end
            end
        end
    elseif self.state == GS_GAMEOVER then
        cur_dna:update()
        dst_dna:update()
        self.game_over_menu:input()
    elseif self.state == GS_EOL then
        cur_dna:update()
        dst_dna:update()
        particles:update()
        if time() - self.state_time > 3 or btnp(buttons.b1) or btnp(buttons.b2) then
            self:set_state(GS_SELECT_DIFF)
        end
    end
end

function game:draw()
    cls(1)

    if self.state == GS_MAINMENU or self.state == GS_SELECT_DIFF then
        menu_dna:draw()
        printc("dna", 10, 7)
        printc("mutations", 16, 7)
    end
    if self.state == GS_MAINMENU then
        if flr((time()*5)) % 4 != 0 then
            print("press c/\x8e to start", 47, 85, 7)
        end
        print("code/design/gfx: @frozax", 40, 118, 6)
        print("sfx: @frozax", 100, 108, 6)
    elseif self.state == GS_SELECT_DIFF then
        self.diff_menu:draw(57)
        item = self.diff_menu.items[self.diff_menu.selection]
        y = 40
        print("dna length:", 28+30, y, 6)
        print("mutations:", 28+34, y+6)
        print(item.dna_length, 28+79, y, 7)
        print(item.mutations, 28+79, y+6)
    elseif self.state == GS_GAME then
        cur_dna:draw()
        dst_dna:draw()
        ui:draw()
        help:draw()
        if self.pause_menu_on then
            fillp(0b0101101001011010.1)
            rectfill(0, 0, 127, 127, 0)
            fillp()
            local pmx, pmy=18, 36
            draw_rwin(pmx+1, pmy+1, 127-pmx*2, 127-pmy*2, 0, 0)
            draw_rwin(pmx, pmy, 127-pmx*2, 127-pmy*2, 1, 2)
            self.pause_menu:draw(40)
        end
    elseif self.state == GS_EOL then
        particles:draw()
        cur_dna:draw()
        dst_dna:draw()
        printc("congratulations!", 3, 7)
    elseif self.state == GS_GAMEOVER then
        cur_dna:draw()
        dst_dna:draw()
        printc("game over!", 6, 7)
        printc("no moves left", 16, ui_col)
        self.game_over_menu:draw(30)
    end
end

function game:set_state(stt, diff)
    self.state = stt
    self.state_time = time()
    self.selection = 1
    self.pause_menu_on = false
    if stt == GS_GAME and diff then
        mutations = rnd(diff.mutations)
        dna_length = rnd(diff.length)
        gen_level_precise(dna_length, mutations)
        self:setup_level()
        local ap = dget(SAVE_ALREADY_PLAYED)
        printh("ap"..ap)
        if ap != 1 then
            dset(SAVE_ALREADY_PLAYED, 1)
            help:show()
        end
    end
end

function game:setup_level()
    cur_dna = create_dna(level.src, 20, 93, "r")
    dst_dna = create_dna(level.dst, 128-20, 93, "l")
    cur_dna:start()
    dst_dna:start()
    ui:init(level)
end