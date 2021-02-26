

function _reset_state(level, clear)
    level.state = {}
    for y=1,#level.def do
        row = {}
        for x=1,#level.def[y] do
            stt = level.def[y][x]
            if (stt == TE or stt == GR) and clear then
                stt = UN
            end
            add(row, stt)
        end
        add(level.state, row)
    end
end

function load_level(number, reset)
    level_number = number
    game_level = load_level_from_def(levels[level_number+1], reset)
    init_input()
end

function load_level_from_def(ldef, reset)
    printh("load level")
    level = {}
    level.w = ldef.w
    level.h = ldef.h
    level.def = ldef
    level.thermos = {} -- added later
    level.cells = {} -- added later
    for x = 1,level.w do
        col = {}
        for y=1,level.h do
            add(col,nil)
        end
        add(level.cells, col)
    end
    -- compute numbers and thermo ref
    level.cells = {}     -- 0-index
    level.rows = {}      -- 0-index 
    level.cols = {}      -- 0-index
    for x=1,level.w do
        col = {}
        level.cols[x-1] = -1
        for y=1,level.h do
            col[y-1] = "NONE"
            if (x==1) level.rows[y-1] = -1
        end
        level.cells[x-1] = col
    end
    -- set thermo in cells
    -- and count rc
    for thermo_def in all(ldef.thermos) do
        --create thermo objects
        thermo = {}
        thermo.x = thermo_def[1]
        thermo.y = thermo_def[2]
        thermo.dir = thermo_def[3]
        thermo.length = thermo_def[4]
        thermo.fill = thermo_def[5]
        thermo.cells = {}
        for i=0,thermo.length-1 do
            cell={x=thermo.x, y=thermo.y}
            if (thermo.dir == LEFT) cell.x-=i
            if (thermo.dir == RIGHT) cell.x+=i
            if (thermo.dir == DOWN) cell.y-=i
            if (thermo.dir == UP) cell.y+=i
            add(thermo.cells, cell)
            level.cells[cell.x][cell.y] = thermo
        end
        add(level.thermos, thermo)
    end
    printh(tostring(level))
    pix_size = level.w * (cell_size)
    level.origin = vec2((128 - pix_size)/2, (128 - pix_size)/2 + 2)

    if reset == nil or reset then
        clear = true
    else
        clear = false
    end
    _reset_state(level, clear)

    function level:launch_start_anim()
    end

    function level:get_expected_state(x, y) -- lua: index is 1-based
        return self.def[y][x]
    end
    function level:get_cell_state(x, y) -- lua: index is 1-based
        return self.state[y][x]
    end
    function level:get_anim(x, y) -- lua: index is 1-based
        return self.anims[y][x]
    end
    function level:set_cell_state(x, y, stt) -- lua: index is 1-based
        old = self.state[y][x]
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
            return true
        elseif stt == GR then
            self:set_cell_state(x, y, TE)
            return true
        elseif stt == TE then
            self:set_cell_state(x, y, UN)
            return true
        else
            return false
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

    function level:update()
    end

    function level:draw()
        --draw_grid(self)
        if self.show_numbers then
            draw_numbers(self)
        end
        draw_cell_bgs(self)
        draw_cell_sprites(self)
    end

    level:launch_start_anim()

    return level
end