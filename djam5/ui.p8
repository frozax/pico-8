ui = {}
STT_SELECT_MUTATION = "sel_mut"
STT_SELECT_INSERTION = "sel_ins"
STT_SELECT_DELETION = "sel_del"
STT_SELECT_SUBSTITUTION = "sel_sub"
STT_SELECT_SUBSTITUTION2 = "sel_sub2"
ui.state = ""
ui.mutation = 1
mutation_names = {[MUT_INSERT]="insertion", [MUT_DELETE]="deletion",[MUT_SUBSTITUTE]="substitution"}

function ui:init()
    self:set_sel_mut()
    --self:set_sel_loc1()
end

function ui:set_sel_mut()
    self.text1 = "choose a mutation"
    self.text2 = ""
    self.state = STT_SELECT_MUTATION
    self.selection = self.mutation
    self.max_sel = 3
end

function ui:set_sel_insertion()
    self.state = STT_SELECT_INSERTION
    self.selection = 1
    self.max_sel = cur_dna:size() - 1
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

function ui:set_sel_substitution()
    self.state = STT_SELECT_SUBSTITUTION
    self.selection = 1
    self.max_sel = cur_dna:size()
    self.text1 = "select the element"
    self.text2 = "to change"
end

function ui:update()
    if btnp(buttons.down) then
        self.selection += 1
        if self.selection > self.max_sel then
            self.selection = self.max_sel
        end
    elseif btnp(buttons.up) then
        self.selection -= 1
        if self.selection <= 0 then
            self.selection = 1
            sfx_wrong()
        end
    elseif btnp(buttons.b1) then
        if self.state == STT_SELECT_MUTATION then
            self.mutation = self.selection
            if self.selection == 1 then
                self:set_sel_insertion()
            elseif self.selection == 2 then
                self:set_sel_deletion()
            elseif self.selection == 3 then
                self:set_sel_substitution()
            end
        elseif self.state == STT_SELECT_SUBSTITUTION then
            self:set_sel_substitution2()
        end
    elseif btnp(buttons.b2) then
        if self.state == STT_SELECT_MUTATION or self.state == STT_SELECT_INSERTION or self.state == STT_SELECT_DELETION then
            self:set_sel_mut()
        elseif self.state == STT_SELECT_SUBSTITUTION2 then
            self:set_sel_substitution()
        elseif self.state == STT_SELECT_MUTATION then
            show_help = true
        end
    end
end

function ui:draw_button(text, ypos, selected)
    local rw_col1=selected and 8 or 9
    local rw_col2=selected and 9 or 8
    c = 64
    hw = 53
    h = 14
    draw_rwin(c-hw, ypos, hw*2, h, rw_col1, rw_col2)
    print(text, 10, ypos+5, 7)
end

function ui:draw(y)
    local y=y
    local ui_col=7
    printc(self.text1, y, ui_col)
    printc(self.text2, y+6, ui_col)
    if self.state == STT_SELECT_MUTATION then
        y+=7

        for i=1,#mutation_names do
            self:draw_button(mutation_names[i], y+16*(i-1), self.selection==i)
        end
    elseif self.state == STT_SELECT_DELETION or self.state == STT_SELECT_SUBSTITUTION then
        self:draw_button(mutation_names[1], y+16, true)
        local xc, yc = cur_dna:draw_char(self.selection, 7)
        spr(spr_arrow, xc+5, yc-4)
    elseif self.state == STT_SELECT_INSERTION then
        self:draw_button(mutation_names[1], y+16, true)
        local xc, yc = cur_dna:draw_char(self.selection, 7)
        cur_dna:draw_char(self.selection+1, 7)
        spr(spr_arrow, xc+5, yc)
    end
end

function sfx_wrong()
end

function sfx_valid()
end