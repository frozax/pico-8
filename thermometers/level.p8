-- state
UNKNOWN = 0
EMPTY = 1
FILLED = 2

-- extremities
START = 0
MIDDLE = 1
END = 2

function load_level(number, reset)
    level_number = number
    game_level = load_level_from_def(levels[level_number+1], reset)
    init_input()
end

function load_level_from_def(ldef, reset)
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
            if i == 0 then
                e = START
            elseif i == thermo.length - 1 then
                e = END
            else
                e = MIDDLE
            end
            exp = FILLED
            if i >= thermo.fill then
                exp = EMPTY
            end
            cell={x=thermo.x, y=thermo.y, state=UNKNOWN, extremity=e, expected=exp, dir=thermo.dir}
            if (thermo.dir == LEFT) cell.x-=i
            if (thermo.dir == RIGHT) cell.x+=i
            if (thermo.dir == DOWN) cell.y+=i
            if (thermo.dir == UP) cell.y-=i
            
            add(thermo.cells, cell)
            level.cells[cell.x][cell.y] = cell
        end
        add(level.thermos, thermo)
    end
    level.origin = get_level_origin()

    function level:get_cell_bg_color(x, y) -- lua: index is 1-based
        if self.cells[x][y] == UNKNOWN then
            return unknown_col
        else
            return grass_col
        end
    end
    function level:cycle_cell(x, y)
        time_since_last_move = time()
        stt = self.cells[x][y].state
        if stt == UNKNOWN then
            self.cells[x][y].state = FILLED
        elseif stt == FILLED then
            self.cells[x][y].state = EMPTY
        elseif stt == EMPTY then
            self.cells[x][y].state = UNKNOWN
        end
    end
    -- returns "wip", "success", "error"
    function level:get_completion()
        res = "success"
        for y=0,self.h-1 do
            for x=0,self.w-1 do
                cell = self.cells[x][y]
                if cell.state == UNKNOWN and cell.expected == FILLED then
                    return "wip"
                end
                if cell.state != UNKNOWN and cell.state != cell.expected then
                    res = "error"
                end
            end
        end
        return res
    end
    -- returns object with nb (value expected), and color (depending on current nb of tents)
    -- i: 1-based
    function level:compute_col_infos(x)
        cur = 0
        full = true
        expected = 0
        for y=0, self.h-1 do
            stt = self.cells[x][y].state
            if stt == UNKNOWN then
                full = false
            end
            if stt == FILLED then
                cur += 1
            end
            if self.cells[x][y].expected == FILLED then
                expected += 1
            end
        end
        return {expected=expected, cur=cur, full=full}
    end
    function level:compute_row_infos(y)
        cur = 0
        full = true
        expected = 0
        for x=0, self.w-1 do
            stt = self.cells[x][y].state
            if stt == UNKNOWN then
                full = false
            end
            if stt == FILLED then
                cur += 1
            end
            if self.cells[x][y].expected == FILLED then
                expected += 1
            end
        end
        return {expected=expected, cur=cur, full=full}
    end
    function level:rc_spr_y(row_info)
        if row_info.cur == row_info.expected then
            return cell_size
        end
        if row_info.full then
            return cell_size*2
        else
            return 0
        end
    end
    -- return color to display number depending on state
    function level:rc_num_color(row_info)
        if row_info.cur == row_info.expected then
            return 6
        else
            if row_info.full then
                return 10
            else
                return 0
            end
        end
    end

    function is_full_or_all_set(rci)
        return rci.full or rci.expected == rci.cur
    end

    -- very very very slow
    function level:is_error(x, y)
        if is_full_or_all_set(self:compute_col_infos(x)) or is_full_or_all_set(self:compute_row_infos(y)) then
            stt = self.cells[x][y].state 
            if stt != UNKNOWN and stt != self.cells[x][y].expected then
                error_time = time()
                return true
            end
        end
        return false
    end

    function level:update()
    end

    function level:draw()
        draw_numbers(self)
        draw_cell_bgs(self)
        draw_cell_sprites(self)
    end

    return level
end