anims = {}

anims.twoframe=0 --two frame anims
anims.threeframe=0
anims.fourframe=0
anims.fiveframe=0
anims.sixframe=0
anims.sevenframe=0
anims.eightframe=0
anims.maxdelay=4
anims.framedelay=anims.maxdelay-1

function anims:update()
    -- update state, check input
    self.framedelay-=1
    if (self.framedelay==0) then
        self.twoframe = (self.twoframe+1) % 2 --two frame anims
        self.threeframe = (self.threeframe+1) % 3 --two frame anims
        self.fourframe = (self.fourframe+1) % 4 -- four frame anims
        self.fiveframe = (self.fiveframe+1) % 5 -- five frame anims
        self.sixframe = (self.sixframe+1) % 6 -- six frame anims
        self.sevenframe = (self.sevenframe+1) % 7
        self.eightframe = (self.eightframe+1) % 8
        self.framedelay=self.maxdelay
    end
end

function create_anim(frames, flips_x, flips_y)
    if flips_x == nil then
        flips_x = {}
        for i=1,#frames do add(flips_x, false) end
    end
    if flips_y == nil then
        flips_y = {}
        for i=1,#frames do add(flips_y, false) end
    end
    if type(frames[1]) == "number" then
        -- if frame numbers, convert to rects
        new_frames = {}
        for i=1,#frames do
            x = (frames[i] % 16) * 8
            y = (frames[i] \ 16) * 8
            add(new_frames, {x=x, y=y, w=8, h=8})
        end
        frames = new_frames
    end

    anim = {frames=frames, flips_x=flips_x, flips_y=flips_y}

    function anim:update()
        mod = 1
        if #self.frames == 1 then
            mod = 0
        elseif #self.frames == 2 then
            mod = anims.twoframe
        elseif #self.frames == 3 then
            mod = anims.threeframe
        elseif #self.frames == 4 then
            mod = anims.fourframe
        elseif #self.frames == 5 then
            mod = anims.fiveframe
        elseif #self.frames == 6 then
            mod = anims.sixframe
        elseif #self.frames == 7 then
            mod = anims.sevenframe
        elseif #self.frames == 8 then
            mod = anims.eightframe
        else
            assert(false, "unhandled nb frames")
        end
        self.frame = self.frames[mod + 1]
        self.flip_x = self.flips_x[mod + 1]
        self.flip_y = self.flips_y[mod + 1]
    end

    function anim:draw(p)
        --printh(tostring(self))
        sspr(self.frame.x, self.frame.y, self.frame.w, self.frame.h, p.x, p.y, self.frame.w, self.frame.h, self.flip_x, self.flip_y)
    end

    return anim
end