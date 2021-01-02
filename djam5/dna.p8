
A=2
T=3
C=4
G=5
pair={[A]=T,[T]=A,[C]=G,[G]=C}
ANIM_START = "anim_start"
ANIM_STOP = "anim_stop"

function create_dna(sequence)
    dna = {}
    dna.sequence = sequence
    dna.anim = ""
    dna.anim_start = 0

    function dna:update()
    end

    function dna:ang_from_t(branch)
        return 0 - (branch-1) * 0.04 + (t() - self.anim_start)
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

    function dna:draw(_x, _y)
        circ_col = 7
        local y = _y
        local max_width=15
        local bar_half_height = 1
        local bar_spacing = bar_half_height*2 + 4
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
            mod_ang = (ang + 0.25) % 1
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
            local branch_x = _x
            rectfill(branch_x-width, y-bar_half_height, branch_x, y+bar_half_height, self.sequence[i])
            rectfill(branch_x+width, y-bar_half_height, branch_x, y+bar_half_height, pair[self.sequence[i]])
            circfill(branch_x-width, y, r, circ_col)
            circfill(branch_x+width, y, r2, circ_col)
            y+=bar_spacing
        end
    end

    return dna
end

