anim = {}

anim.twoframe=0 --two frame anims
anim.threeframe=2 -- three frame anims
anim.fourframe=1 -- four frame anims
anim.fiveframe=3 -- five frame anims
anim.sixframe=4 -- six frame anims
anim.maxdelay=16
anim.framedelay=anim.maxdelay-1

function anim:update()
    -- update state, check input
    self.framedelay-=1
    if (self.framedelay==0) then
        self.twoframe = (self.twoframe+1) % 2 --two frame anims
        self.threeframe = (self.threeframe+1) % 3 --two frame anims
        self.fourframe = (self.fourframe+1) % 4 -- four frame anims
        self.fiveframe = (self.fiveframe+1) % 5 -- five frame anims
        self.sixframe = (self.sixframe+1) % 6 -- six frame anims
        self.framedelay=self.maxdelay
    end
end
