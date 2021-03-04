particles = {}
particles.p = {}

function particles:start()
    self.p = {}
    for ip=1,1100 do
        left_side = rnd(1) < 0.5
        vx = (rnd(2.5) + 1.0) * 1.5
        vy = -rnd(2) * 2 - 2
        x = -rnd(10) - 5
        if left_side then
        else
            x = 128 - x
            vx = -vx
        end
        p = {x=x,y=rnd(80) + 50,
            vx=vx,vy=vy,
            size=flr(rnd(3))+1,
            age=-rnd(30),
            life=rnd(100)+100,
            col=rnd({1, 3, 7, 12})
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
            p.vy+=0.05
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
