mainmenu = {}

function mainmenu:_start_game()
    game_state = "howtoplay1"
end

function mainmenu:update()
    if btnp(buttons.b1) then
        self:_start_game()
    end
end

function mainmenu:draw_battery()
    sspr(48, 0, 5, 40, sox + sw - 5, soy)
end

function mainmenu:draw_network()
    sspr(40, 0, 5, 40, 1 + sox, soy)
end

function mainmenu:draw()
    -- show battery and network
    self:draw_battery()
    self:draw_network()

    -- display time
    _print(stat(93)..":"..stat(94), sox + sw - 31, soy + 1, fg)
end

levelselect = {}

function levelselect:update()
end

function levelselect:draw()
end

options = {}

function options:update()
end

function options:draw()
        _print("Play", sox, soy, fg)
        _print("How to Play", sox, soy+10, fg)
end