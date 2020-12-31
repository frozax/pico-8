pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
-- bump 2021
-- by frozax

-- @frozax

frame = 0
global = {}
function _update()
    item = create_item()
    add(global, item)
    frame += 1
    if frame % 100 == 0 then
        printh(stat(0))
        global = {}
    end
end

function _draw()
    cls(1)

    print(frame, 1, 1)
    print(stat(0), 20, 1)
end

function create_item()
    item = {}
    function item:f1()
        print("1")
    end
    function item:f2()
        print("2")
    end
    function item:f3()
        print("3")
    end
    function item:f4()
        print("3")
    end
    return item
end

function _init()
    print("done")
end