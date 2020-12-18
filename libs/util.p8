function blink(speed, c0, c1)
    ti = flr(time() * speed)
    if ti % 2 == 0 then
        return c0
    end
    return c1
end