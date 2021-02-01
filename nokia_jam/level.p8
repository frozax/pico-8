function gen_level()

    l1 = {1, 2, 3}
    l2 = {1, 2, 3}

    -- gen level
    level = {selection=1}

    level.nb_switches = 8
    -- percentages of chances that each switch impact X lights
    nb_light_per_switch_chances = {0.4, 0.4, 0.1, 0.1, 0.0}

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

    function level:update()
        for is = 1, #self.switches do
            if self.switches[is].anim != 0 then
                self.switches[is].anim -= 1
            end
            printh("selection"..self.selection)
            if self.selection == is then
                if btnp(buttons.b1) or btnp(buttons.up) or btnp(buttons.down) then
                    self.switches[is].state = not self.switches[is].state
                    self.switches[is].anim = 2
                end
            end
        end
    end


    function level:draw()
        y = 34
        sprite_w = 6
        for is = 1, #self.switches do
            x = (is - 1) * (sprite_w + 1) + 1
            sspr(0, 22, sprite_w, 9, sox + x, soy + y)

            y_inner = y + 2
            if self.switches[is].anim > 0 then
                y_inner += 2
            elseif not self.switches[is].state then
                y_inner += 3
            end
            sspr(0, 32, 2, 2, sox + x + 2, soy + y_inner)

        end
    end

    return level
end
