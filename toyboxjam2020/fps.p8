function showpct(c)
    pct = flr(stat(1)*100)
    if not c then
        c = 0
    end

    pct = tostr(pct)
    if #pct == 1 then pct = "0"..pct end
    palt(0, false)
    --y = 121
    y = 1
    rectfill(0, y, 4*#pct, 6+y, 1)
    palt(0, true)
    print(pct, 1, y+1, c)
end