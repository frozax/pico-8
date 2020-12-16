function showfps(c)
    if c then
        color(c)
    end
    print("fps "..stat(7).." "..flr(stat(1)*100).."%")
end

function showpct(c)
    pct = flr(stat(1)*100)
    if pct > 100 then
        c = colors.red
    elseif pct > 80 then
        c = colors.orange
    elseif not c then
        c = colors.black
    end

    print(pct, 1, 1, c)
end