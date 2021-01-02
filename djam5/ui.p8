ui = {}
STT_SELECT_MUTATION = "sel_mut"
STT_SELECT_INSERTION = "sel_ins"
STT_SELECT_INSERTION2 = "sel_ins2"
STT_SELECT_DELETION = "sel_del"
STT_SELECT_SUBSTITUTION = "sel_sub"
STT_SELECT_SUBSTITUTION2 = "sel_sub2"
ui.state = ""
ui.mutation = 1
ui.selection = 1
mutation_names = {[MUT_INSERT]="insertion", [MUT_DELETE]="deletion",[MUT_SUBSTITUTE]="substitution"}

function ui:init(level)
    self:set_sel_mut()
    self.level = level
    self.used = {[MUT_INSERT]=0, [MUT_DELETE]=0,[MUT_SUBSTITUTE]=0}
end

function ui:set_sel_mut()
    self.text1 = "choose a mutation"
    self.text2 = ""
    self.state = STT_SELECT_MUTATION
    self.selection = self.mutation
    self.max_sel = 3
    self.action_poss = 1
end

function ui:set_sel_insertion(_location)
    self.state = STT_SELECT_INSERTION
    self.selection = _location or 1
    self.max_sel = cur_dna:size() + 1
    self.text1 = "select the location"
    self.text2 = "of the insertion"
end

function ui:set_sel_deletion()
    self.state = STT_SELECT_DELETION
    self.selection = 1
    self.max_sel = cur_dna:size()
    self.text1 = "select the element"
    self.text2 = "to delete"
end

function ui:set_sel_substitution(_location)
    self.state = STT_SELECT_SUBSTITUTION
    self.selection = _location or 1
    self.max_sel = cur_dna:size()
    self.text1 = "select the element"
    self.text2 = "to change"
end

function ui:set_sel_substitution2(_location)
    self.action_location = _location
    self.action_poss = {}
    for i=0,3 do
        if cur_dna.sequence[self.action_location] != i then
            add(self.action_poss, i)
        end
    end
    self.state = STT_SELECT_SUBSTITUTION2
    self.selection = 1
    self.max_sel = #self.action_poss
    self.text1 = "select the new element"
    self.text2 = ""
end

function ui:set_sel_insertion2(_location)
    self.action_location = _location
    self.action_poss = {}
    for i=0,3 do
        add(self.action_poss, i)
    end
    self.state = STT_SELECT_INSERTION2
    self.selection = 1
    self.max_sel = #self.action_poss
    self.text1 = "select the new element"
    self.text2 = ""
end

function ui:update()
    if btnp(buttons.down) or btnp(buttons.right) then
        self.selection += 1
        if self.selection > self.max_sel then
            self.selection = self.max_sel
        end
    elseif btnp(buttons.up) or btnp(buttons.left) then
        self.selection -= 1
        if self.selection <= 0 then
            self.selection = 1
            sound_menu_error()
        end
    elseif btnp(buttons.b1) then
        if self.state == STT_SELECT_MUTATION then
            self.mutation = self.selection
            if self.selection == 1 then
                if self:remaining(MUT_INSERT) > 0 then
                    self:set_sel_insertion()
                else
                    help:show_error("no insertion remaining")
                end
            elseif self.selection == 2 then
                if self:remaining(MUT_DELETE) > 0 then
                    self:set_sel_deletion()
                else
                    help:show_error("no deletion remaining")
                end
            elseif self.selection == 3 then
                if self:remaining(MUT_SUBSTITUTE) > 0 then
                    self:set_sel_substitution()
                else
                    help:show_error("no substitution remaining")
                end
            end
        elseif self.state == STT_SELECT_SUBSTITUTION then
            self:set_sel_substitution2(self.selection)
        elseif self.state == STT_SELECT_INSERTION then
            self:set_sel_insertion2(self.selection)
        elseif self.state == STT_SELECT_INSERTION2 then
            mutate(cur_dna.sequence, MUT_INSERT, self.action_location, self.action_poss[self.selection])
            self.used[MUT_INSERT] += 1
            self:set_sel_mut()
        elseif self.state == STT_SELECT_SUBSTITUTION2 then
            mutate(cur_dna.sequence, MUT_SUBSTITUTE, self.action_location, self.action_poss[self.selection])
            self.used[MUT_SUBSTITUTE] += 1
            self:set_sel_mut()
        elseif self.state == STT_SELECT_DELETION then
            mutate(cur_dna.sequence, MUT_DELETE, self.selection)
            self.used[MUT_DELETE] += 1
            self:set_sel_mut()
        end
    elseif btnp(buttons.b2) then
        if self.state == STT_SELECT_SUBSTITUTION or self.state == STT_SELECT_INSERTION or self.state == STT_SELECT_DELETION then
            self:set_sel_mut()
        elseif self.state == STT_SELECT_SUBSTITUTION2 then
            self:set_sel_substitution(self.action_location)
        elseif self.state == STT_SELECT_INSERTION2 then
            self:set_sel_insertion(self.action_location)
        elseif self.state == STT_SELECT_MUTATION then
            help:show()
        end
    end
end

function ui:draw_button(mut_type, ypos, selected)
    rw_col1=selected and 8 or 9
    rw_col2=selected and 9 or 8
    c = 64
    hw = 53
    h = 14
    draw_rwin(c-hw, ypos, hw*2, h, rw_col1, rw_col2)
    local text = mutation_names[mut_type]
    local text2 = "available:"
    if self.level.mut_count[mut_type]==0 then
        text2 ..= "0"
    else
        text2 ..= self:remaining(mut_type).."/"..self.level.mut_count[mut_type]
    end
    print(text, 20, ypos+2, 7)
    print(text2, 20, ypos+8, 7)
end

function ui:remaining(_mut_type)
    return self.level.mut_count[_mut_type] - self.used[_mut_type]
end

function ui:draw_ctag(text, xpos, selected)
    local rw_col1=selected and 8 or 9
    local rw_col2=selected and 9 or 8
    c = 64 + xpos
    hw = 7
    h = hw*2
    ypos = 35
    draw_rwin(c-hw, ypos, hw*2, h, rw_col1, rw_col2)
    print(text, c-1, ypos+5, 7)
end

function ui:draw()
    local y=1
    local ui_col=7
    printc(self.text1, y, ui_col)
    printc(self.text2, y+6, ui_col)
    if self.state == STT_SELECT_MUTATION then
        y+=6

        for i=1,#mutation_names do
            self:draw_button(i, y+16*(i-1), self.selection==i)
        end
    elseif self.state == STT_SELECT_DELETION or self.state == STT_SELECT_SUBSTITUTION then
        mn = self.state == STT_SELECT_DELETION and MUT_DELETE or MUT_SUBSTITUTE
        self:draw_button(mn, y+14, true)
        local xc, yc = cur_dna:draw_char(self.selection, 7)
        spr(spr_arrow, xc+5, yc-4)
    elseif self.state == STT_SELECT_INSERTION then
        self:draw_button(MUT_INSERT, y+14, true)
        local xc, yc = cur_dna:draw_char(self.selection-1, 7)
        cur_dna:draw_char(self.selection, 7)
        spr(spr_arrow, xc+5, yc)
    elseif self.state == STT_SELECT_SUBSTITUTION2 then
        self:draw_button(MUT_SUBSTITUTE, y+14, true)
        local xc, yc = cur_dna:draw_char(self.action_location, 7)
        spr(spr_arrow, xc+5, yc-4)
        x = -20
        for i=1,#self.action_poss do
            self:draw_ctag(names[self.action_poss[i]], x, self.selection == i)
            x+= 20
        end
    elseif self.state == STT_SELECT_INSERTION2 then
        self:draw_button(MUT_INSERT, y+14, true)
        local xc, yc = cur_dna:draw_char(self.action_location-1, 7)
        cur_dna:draw_char(self.action_location, 7)
        spr(spr_arrow, xc+5, yc)
        x = -30
        for i=1,#self.action_poss do
            self:draw_ctag(names[self.action_poss[i]], x, self.selection == i)
            x+= 20
        end
    end
end
