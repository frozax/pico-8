-- remove tents and grass
function _reset_state()
    level.state = {}
    for y=1,#level.def do
        row = {}
        for x=1,#level.def[y] do
            stt = level.def[y][x]
            if stt == TE or stt == GR then
                stt = UN
            end
            add(row, stt)
        end
        add(level.state, row)
    end
end

function load_level(ldef)
    level = {}
    level.size = #ldef
    level.def = ldef
    -- compute numbers
    level.rows = {}
    level.cols = {}
    for i=1, level.size do
        r, c = 0, 0
        for j=1, level.size do
            -- row
            if level.def[i][j] == TE then
                r += 1
            end
            -- col
            if level.def[j][i] == TE then
                c += 1
            end
        end
        add(level.rows, {nb=r})
        add(level.cols, {nb=c})
    end
    _reset_state()

    function level:get_expected_state(x, y) -- lua: index is 1-based
        return self.def[y][x]
    end
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
    -- returns "wip", "success", "error"
    function level:get_completion()
        res = "success"
        for y=1,self.size do
            for x=1,self.size do
                stt = self:get_cell_state(x, y)
                exp = self:get_expected_state(x, y)
                if exp == TE then
                    if stt == UN then
                        return "wip"
                    end
                    if stt != TE then
                        res = "error"
                    end
                end
                if stt == TE and exp != TE then
                    res = "error"
                end
            end
        end
        return res
    end
    -- returns object with nb (value expected), and color (depending on current nb of tents)
    -- i: 1-based
    function level:compute_col_infos(x)
        cnt = 0
        for y=1, self.size do
            if self:get_cell_state(x, y) == TE then
                cnt += 1
            end
        end
        return {nb=self.cols[x].nb, color=self:rc_colors(self.cols[x].nb, cnt)}
    end
    function level:compute_row_infos(y)
        cnt = 0
        for x=1, self.size do
            if self:get_cell_state(x, y) == TE then
                cnt += 1
            end
        end
        return {nb=self.rows[y].nb, color=self:rc_colors(self.rows[y].nb, cnt)}
    end
    -- return color to display number depending on state
    function level:rc_colors(expected, cur)
        if cur > expected then
            return numbers_error_col
        end
        if cur == expected then
            return numbers_ok_col
        end
        return numbers_wip_col
    end
end