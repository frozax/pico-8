pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
-- bump 2021
-- by frozax

-- @frozax

frame = 0
global = {}
function _update()
    frame += 1
end

function _draw()
end

function create_item()
    item = {}
    function item:f1()
        print("f1")
    end
    return item
end

local ItemMetaTable = {}
local ItemMethods = {}
function ItemMethods:f1()
    print("f1_mt"..self.a)
end
ItemMetaTable.__index = ItemMethods

function create_item_mt()
    item = {a=rnd()}
    setmetatable(item, ItemMetaTable)
    return item
end

function create_item_large()
    item = {}
    function item:f1()
    end
    function item:f2()
    end
    return item
end

function _init()
    print("done")
    print(stat(0))
    count=9000
    items = {}
    print("before "..stat(0))
    for i=1,count do
        add(items, create_item())
    end
    items[1]:f1()
    print(count.." simple_old "..stat(0))
    for i=1,count do
        add(items, create_item_large())
    end
    print(count.." large_old "..stat(0))

    new_items = {}
    for i=1,count do
        add(new_items, create_item_mt())
    end
    new_items[1]:f1()
    new_items[2]:f1()
    print(count.." simple_mt "..stat(0))


end