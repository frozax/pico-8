function showfps(c)
    if c then
        color(c)
    end
    print("fps "..stat(7).." "..flr(stat(1)*100).."%")
end

function showpct(c)
    pct = flr(stat(1)*100)
    if pct > 100 then
        c = 8
    elseif pct > 80 then
        c = 9
    elseif not c then
        c = 0
    end

    pct = tostr(pct)
    if #pct == 1 then pct = "0"..pct end
    palt(0, false)
    --y = 121
    y = 0
    rectfill(0, y, 4*#pct, 6+y, 1)
    palt(0, true)
    print(pct, 1, y+1, c)
end