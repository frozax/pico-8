particles = {}
particles.p = {}

function particles:start()
    self.p = {}
    for ip=1,600 do
        vx = (rnd(1) - 0.5) * 1.5
        vy = -rnd(2) * 2 - 3
        x = rnd(32)+64 - 16
        y = rnd(10)+128
        p = {x=x,y=y,
            vx=vx,vy=vy,
            size=flr(rnd(3))+1,
            age=-rnd(30),
            life=rnd(100)+100,
            col=rnd({11,8,10,12})
            --col=7
        }
        add(self.p, p)
    end
end

function particles:update()
    for p in all(self.p) do
        p.age += 1
        if p.age > 0 then
            p.x += p.vx
            p.y += p.vy
            --p.vy+=0.05
        end
    end
end

function particles:draw()
    for p in all(self.p) do
        if p.age > 0 and p.y > -10 then -- p.age < p.life then
            circfill(p.x, p.y, p.size, p.col)
        end
    end
end
