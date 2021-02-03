game = {}

substate = "play"

function game:update()
    if substate == "play" then
        --if level:completed() then
        if true then
            substate = "pre_eol"
            frames_until_eol = 10
        end
    elseif substate == "pre_eol" then
        frames_until_eol -= 1
        if frames_until_eol == 0 then
            substate = "eol"
            eol_y_top = animate(soy - 12, soy + 18, 25, ease_out_quad)
            eol_y_bottom = animate(soy + 60, soy + 30, 25, ease_out_quad)
        end
    end
end

function game:draw()
    if substate == "eol" then
        set_pal_inv()
        sspr(0, 40, 84, 12, sox + 0, eol_y_top.value)
        sspr(0, 52, 84, 12, sox + 0, eol_y_bottom.value)
        --rectfill(sox, soy, sox + sw, eol_y_top.value - 1, bg)
        rectfill(sox, eol_y_bottom.value + 10, sox + sw, soy + sh, bg)
        --_print("Level completed", sox + 2, eol_y_top.value - 10, fg)
        _print("Press SPACE", sox + 10, eol_y_bottom.value + 10, fg)
    end
end