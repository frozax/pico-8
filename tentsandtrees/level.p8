-- remove tents and grass
function _reset_state(state)
    for y=1,#state do
        for x=1,#state[y] do
            if state[y][x] == TE or state[y][x] == GR then
                state[y][x] = UN
            end
        end
    end
end

function load_level(ldef)
    level = {}
    level.size = #ldef
    level.def = ldef
    level.state = ldef  -- user state
    _reset_state(level.state)
    level.rows = {}
    level.cols = {}
    function level:get_cell_state(x, y) -- lua: index is 1-based
        return self.state[y][x]
    end
    function level:set_cell_state(x, y, stt) -- lua: index is 1-based
        self.state[y][x] = stt
    end
    function level:get_cell_bg_color(x, y) -- lua: index is 1-based
        stt = self:get_cell_state(x, y)
        if stt == UN then
            return unknown_col
        else
            return grass_col
        end
    end
    function level:cycle_cell(x, y)
        stt = self:get_cell_state(x, y)
        if stt == UN then
            self:set_cell_state(x, y, GR)
        elseif stt == GR then
            self:set_cell_state(x, y, TE)
        elseif stt == TE then
            self:set_cell_state(x, y, UN)
        end
    end
end