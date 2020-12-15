function showfps(c)
    if c then
        color(c)
    end
    print("fps "..stat(7).." "..flr(stat(1)*100).."%")
end