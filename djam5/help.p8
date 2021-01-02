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
        self.error_start = -1
    end
end

function help:draw()
    if self.error_start >= 0 and time() < self.error_start + HELP_ON_SCREEN_DURATION then
        draw_win(10, 60, 128-20, 8, 0, 6)
        printc(self.error_text, 62, 6)
    end
end

function help:show_error(_text)
    self.error_text = _text
    self.error_start = time()
end
