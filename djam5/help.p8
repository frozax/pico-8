help = {}
help.show_help = false
help.error_start = -1
help.error_text = "todo"
HELP_ON_SCREEN_DURATION = 2

function help:show()
    self.show_help = true
end

function help:update()
    if btnp(buttons.b1) or btnp(buttons.b2) or btnp(buttons.left) or btnp(buttons.right) or btnp(buttons.up) or btnp(buttons.down) then
        self.show_help = false
        self.error_start = -1
    end
end

function help:draw()
    if self.show_help then
        draw_rwin(0+1, 0+1, 126, 77, 0, 0)
        draw_rwin(0, 0, 126, 77, 1, 2)
        printc("how to play", 3, 7)
        local y=9
        local l=6
        local p=2
        local c=6
        printc("you need to modify the source", y+l*0+p, c)
        printc("dna (left) to match the target", y+l*1+p, c)
        printc("(right).", y+l*2+p, c)
        printc("you have a limited number of", y+l*3+p*2, c)
        printc("mutations that you can apply", y+l*4+p*2, c)
        printc("in any order.", y+l*5+p*2, c)
        printc("   insertion: adds a line   ", y+l*6+p*3, c)
        printc("    deletion: removes a line", y+l*7+p*3, c)
        printc("substitution: changes a line", y+l*8+p*3, c)
        printc("press c/\x8e to close", y+l*9+p*4, 7)

--you need to apply
--mutations to the
--left dna so that
--it matches the right
--dna.
--you have a limited
--number of mutations
--available.

    end
    if self.error_start >= 0 and time() < self.error_start + HELP_ON_SCREEN_DURATION then
        draw_win(10, 60, 128-20, 8, 0, 6)
        printc(self.error_text, 62, 6)
    end
end

function help:show_error(_text)
    sound_menu_error()
    self.error_text = _text
    self.error_start = time()
end
