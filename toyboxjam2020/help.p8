help_on = false

function enable_help()
    help_on = true
end

function show_help()
    draw_rwin(8, 18, 128-16, 100, 1, 7)
    printco("help", 25, 1, 7)
    t = {"walk toward the trees or",
         "stones to gather them.",
         "",
         "enter the train from the",
         "start or end locomotive",
         "to choose the direction of",
         "travel.",
         "",
         "",
         "have fun!",
         "",
         "@frozax"}
    y=38
    for s in all(t) do
        printco(s, y, 7, 1)
        y += 6
    end
end

menuitem(3, "help", function() enable_help() end)