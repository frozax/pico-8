player = {}

player.p = vec2(64, 64)
player.speed = 2.2    -- pix / frame
player.size = 8
player.idle_down = create_anim({238, 239})
player.idle_up = create_anim({253, 254})
player.idle_left = create_anim({246, 247}, {true, true})
player.idle_right = create_anim({246, 247})
player.walk_down = create_anim({240, 240}, {true, false})
player.walk_up = create_anim({255, 255}, {true, false})
player.walk_left = create_anim({248, 249}, {true, true})
player.walk_right = create_anim({248, 249})
player.idle = player.idle_down

function player:update()
    dir = vec2(0, 0)
    if btn(buttons.left) then
        dir.x = -1
        self.anim = self.walk_left
        self.idle = self.idle_left
    end
    if btn(buttons.right) then
        dir.x = 1
        self.anim = self.walk_right
        self.idle = self.idle_right
    end
    if btn(buttons.up) then
        dir.y = -1
        self.anim = self.walk_up
        self.idle = self.idle_up
    end
    if btn(buttons.down) then
        dir.y = 1
        self.anim = self.walk_down
        self.idle = self.idle_down
    end
    if #dir == 0 then
        self.anim = self.idle
    else
        dir = (self.speed / #dir) * dir
        self.p = self.p + dir
    end
end

function player:draw()
    self.anim:update()
    self.anim:draw(self.p - vec2(player.size * 0.5, player.size * 0.5))
end