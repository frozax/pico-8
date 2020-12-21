particles = {}
particles.p = {}

function particles:start()
    self.p = {}
    for ip=1,500 do
        left_side = rnd(1) < 0.5
        vx = (rnd(2) + 1) * 1.5
        vy = -rnd(2) * 2 - 2
        if left_side then
            x = -rnd(5) - 2
        else
            x = 132
            vx = -vx
        end
        p = {x=x,y=rnd(10) + 100,
            vx=vx,vy=vy,
            size=flr(rnd(3))+1,
            age=-rnd(30),
            life=rnd(100)+100,
            col=rnd({7, 9, 10, 9, 10})
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
