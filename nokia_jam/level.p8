diff = {
    {
        diff = "easy",
        nb_switches = 3,
        nb_light_per_switch_chances = {0.6, 0.3, 0.0}
    },
    {
        diff = "medium",
        nb_switches = 5,
        nb_light_per_switch_chances = {0.6, 0.3, 0.1, 0.0}
    },
    {
        diff = "hard",
        nb_switches = 8,
        nb_light_per_switch_chances = {0.6, 0.3, 0.1, 0.0, 0.0, 0.0}
    }
}

function gen_level()

    l1 = {1, 2, 3}
    l2 = {1, 2, 3}

    -- gen level
    level = {selection=1}

    d = diff[3]

    level.nb_switches = d.nb_switches
    -- percentages of chances that each switch impact X lights
    nb_light_per_switch_chances = d.nb_light_per_switch_chances

    level.lights = {}
    for il=1, #nb_light_per_switch_chances do
        add(level.lights, {state=false})
    end

    level.switches = {}
    while #level.switches != level.nb_switches do
        -- gen switch
        r = rnd()
        for ichances=1,#nb_light_per_switch_chances do
            if r <= nb_light_per_switch_chances[ichances] then
                nbl = ichances
                break
            end
            r -= nb_light_per_switch_chances[ichances]
        end
        lights_list = {}
        for i = 1, #level.lights do
            add(lights_list, i)
        end
        shuffle(lights_list)
        while #lights_list > nbl do
            deli(lights_list, 1)
        end
        sort(lights_list)
        -- don't add if another switch has the same
        can_add = true
        for s in all(level.switches) do
            if #s.lights == #lights_list then
                -- same length
                equal = true
                for i=1, #s.lights do
                    if s.lights[i] != lights_list[i] then
                        equal = false
                    end
                end
                if equal then
                    can_add = false
                end
            end
            if not can_add then
                break
            end
        end
        if can_add then
            add(level.switches, {state=false, lights=lights_list, anim=0})
        end
    end

    function level:_compute_light_state()
        for il=1, #self.lights do
            -- default to off
            state = false
            -- go through switches to light up
            for switch in all(self.switches) do
                if switch.state then
                    for switch_light in all(switch.lights) do
                        if switch_light == il then
                            state = not state
                        end
                    end
                end
            end
            self.lights[il].state = state
        end
    end

    function level:update()
        if btnp(buttons.left) then
            self.selection -= 1
            if self.selection == 0 then
                self.selection = #self.switches
                sfx_change_sel()
            end
        end
        if btnp(buttons.right) then
            self.selection += 1
            if self.selection > #self.switches then
                self.selection = 1
                sfx_change_sel()
            end
        end
        for is = 1, #self.switches do
            if self.switches[is].anim != 0 then
                self.switches[is].anim -= 1
            end
            if self.selection == is then
                if btnp(buttons.b1) or btnp(buttons.up) or btnp(buttons.down) then
                    self.switches[is].state = not self.switches[is].state
                    self.switches[is].anim = 2
                    sfx_change_switch()
                end
            end
        end
        self:_compute_light_state()
    end


    function level:draw()

        -- show switches
        y = 29

        sprite_x_inside = 0
        sprite_x_outside = 0
        sprite_w_outside = 6
        sprite_h_outside = 9
        sprite_w_inside = 2
        sprite_h_inside = 2
        sprite_y_outside = 22
        sprite_y_inside = 32

        -- new sprite
        sprite_x_inside = 16
        sprite_x_outside = 7
        sprite_w_outside = 8
        sprite_h_outside = 15
        sprite_w_inside = 4
        sprite_h_inside = 6
        sprite_y_outside = 22
        sprite_y_inside = 22

        spacing = 2

        total_width = #self.switches * (sprite_w_outside + spacing) - 1
        x_start = (sw - total_width) \ 2
        for is = 1, #self.switches do
            x = x_start + (is - 1) * (sprite_w_outside + spacing)
            sspr(sprite_x_outside, sprite_y_outside, sprite_w_outside, sprite_h_outside, sox + x, soy + y)

            y_inner = y + 2
            if self.switches[is].anim > 0 then
                y_inner += 3
            elseif not self.switches[is].state then
                y_inner += 5
            end
            sspr(sprite_x_inside, sprite_y_inside, sprite_w_inside, sprite_h_inside, sox + x + 2, soy + y_inner)

            if is == self.selection then
                sspr(0, 35, 6, 3, sox + x + 1, soy + y + 15)
            end
        end

        -- show light bulbs
        sprite_w = 13
        total_width = #self.lights * (sprite_w + 1) - 1
        x_start = (sw - total_width) \ 2
        y = 1
        for il = 1, #self.lights do
            x = x_start + (il - 1) * (sprite_w + 1)
            spr_x = 0
            if self.lights[il].state == true then
                spr_x = spr_x + 14
            end
            sspr(spr_x, 0, sprite_w, 21, sox + x, soy + y)
        end
    end

    return level
end
