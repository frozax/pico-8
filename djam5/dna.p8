A=0
T=1
C=2
G=3
pair={[A]=T,[T]=A,[C]=G,[G]=C}
colors={[A]=2,[T]=3,[C]=4,[G]=5}
names={[A]="a",[T]="t",[C]="c",[G]="g"}
ANIM_START = "anim_start"
ANIM_STOP = "anim_stop"

bar_half_height = 1
bar_spacing = bar_half_height*2 + 4
max_width=15

function create_dna(sequence, _x, _y, _lr)
    printh("create_dna"..tostring(sequence))
    dna = {}
    dna.sequence = sequence
    dna.anim = ""
    dna.anim_start = 0
    dna.x = _x
    dna.y = _y
    dna.lr = _lr

    function dna:update()
    end

    function dna:ang_from_t(branch)
        return 0 - (branch-1) * 0.06 + (t() - self.anim_start)/3
    end

    function dna:start()
        self.anim = ANIM_START
        self.anim_start = t()
    end

    function dna:stop()
        self.anim = ANIM_STOP
        -- compute final angle
        self.ang_end = flr(self:ang_from_t(1)+1)
    end

    function dna:size()
        return #self.sequence
    end

    function dna:draw()
        circ_col = 7
        local y = self.y
        front_r = 3
        mid_r = 2
        back_r = 1
        --t()/5
        for i=1,#self.sequence do
            ang = self:ang_from_t(i)
            if self.anim == ANIM_START then
                if ang < 0 then
                    ang = 0
                end
            elseif self.anim == ANIM_STOP then
                if ang > self.ang_end then
                    ang = self.ang_end
                end
            else
                ang = 0
            end

            --ang=0
            -- distance: 0 or 0.5: midd
            -- 0 and 0.5: mid_r
            -- 0.25: front_r
            -- 0.75: back

            -- with (+0.25)%1 --> 0.25/0.75: mid_r  0.5: front  0/1: back
            local mod_ang = (ang + 0.25) % 1
            if mod_ang < 0.1 then
                r = back_r
            elseif mod_ang < 0.4 then
                r = mid_r
            elseif mod_ang < 0.6 then
                r = front_r
            elseif mod_ang < 0.9 then
                r = mid_r
            else
                r = back_r
            end
            if r == front_r then
                r2 = back_r
            elseif r == mid_r then
                r2 = mid_r
            else
                r2 = front_r
            end

            width = cos(ang) * max_width
            local branch_x = self.x
            c1 = colors[self.sequence[i]]
            c2 = colors[pair[self.sequence[i]]]
            if ang%1 < 0.5 then
                circfill(branch_x+width, y, r2, c2)
                rectfill(branch_x+width, y-bar_half_height, branch_x, y+bar_half_height, c2)
                rectfill(branch_x-width, y-bar_half_height, branch_x, y+bar_half_height, c1)
                circfill(branch_x-width, y, r, c1)
            else
                circfill(branch_x-width, y, r, c1)
                rectfill(branch_x-width, y-bar_half_height, branch_x, y+bar_half_height, c1)
                rectfill(branch_x+width, y-bar_half_height, branch_x, y+bar_half_height, c2)
                circfill(branch_x+width, y, r2, c2)
            end
            self:draw_char(i, c1)
            y+=bar_spacing
        end
    end

    function dna:draw_char(_i, _c1)
        local y = self.y+(_i-1)*bar_spacing
        if self.lr == "r" then
            xt = self.x + max_width + 8
        else
            xt = self.x - max_width - 10
        end
        print(names[self.sequence[_i]], xt, y-2, _c1)
        return xt, y
    end

    return dna
end

