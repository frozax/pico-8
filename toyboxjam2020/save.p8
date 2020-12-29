-- to save:
-- coins, tree, stone
-- player and train pos
-- rails placed, stone/tree removed

-- coords: 
-- 120*30 => 12b

-- x: 0..127: 7b
-- y: 0..31: 5b

save = {}

MAX_ITEMS = 512

function save:init()
    cartdata("frozax_tbj2020")
    self.items = {}
    for x=0,world.w-1 do
        for y=0,world.h-1 do
            it = world.items[x][y].type
            if it == "stone" or it == "tree" then
                add(self.items, {x,y})
            end
        end
    end
    assert (#self.items < MAX_ITEMS, "too many brekable items")
    self:load()
end

-- data is 16b
SAVE_VERSION_CONTROL=0
SAVE_PLAYER_X=2
SAVE_PLAYER_Y=4
-- 16b
SAVE_COINS=6
SAVE_STONES=8
SAVE_TREES=10
SAVE_TRAIN_POS=12
SAVE_AREA_UNLOCKED=14
SAVE_OBJ_DONE=16
-- 512b
SAVE_ITEMS_START=18
-- 
SAVE_RAILS_START=SAVE_ITEMS_START + 512/8
SIZE_PER_RAIL_SAVED = 16 -- 16b
MAX_RAILS_SAVED = (256-SAVE_RAILS_START) * 8 \ SIZE_PER_RAIL_SAVED

DATA_START = 0x5e00
VERSION=8

function save:save()
    poke2(DATA_START+SAVE_VERSION_CONTROL, VERSION)
    poke2(DATA_START+SAVE_PLAYER_X, player.p.x)
    poke2(DATA_START+SAVE_PLAYER_Y, player.p.y)

    poke2(DATA_START+SAVE_COINS, ui.coins)
    poke2(DATA_START+SAVE_STONES, ui.stone)
    poke2(DATA_START+SAVE_TREES, ui.tree)
    poke2(DATA_START+SAVE_TRAIN_POS, train.pp)
    poke2(DATA_START+SAVE_AREA_UNLOCKED, world.areas_unlocked)
    done = 0
    for i=1,#ui.objectives do
        if ui.objectives[i].done then
            done += 1
        end
    end
    poke2(DATA_START+SAVE_OBJ_DONE, done)

    bool_items = {}
    for i = 1, #self.items do
        x,y=self.items[i][1], self.items[i][2]
        it = world.items[x][y].type
        -- true means item removed
        add(bool_items, it != "tree" and it != "stone")
    end
    while #bool_items < 512 do
        add(bool_items, false)
    end
    aob = array_of_bool_to_array_of_bytes(bool_items)
    for b = 1,#aob do
        poke(DATA_START+SAVE_ITEMS_START+b-1, aob[b])
    end

    -- save rails
    ir, failed = 0, 0
    for x=0,world.w-1 do
        for y=0,world.h-1 do
            it = world.items[x][y]
            if it:is_rail() and not it.city then
                if ir < MAX_RAILS_SAVED then
                    poke(DATA_START+SAVE_RAILS_START + ir*2 + 0, x+1)
                    poke(DATA_START+SAVE_RAILS_START + ir*2 + 1, y+1)
                    ir += 1
                else
                    failed += 1
                end
            end
        end
    end
    if (failed > 0) printh("Saved "..ir.."/"..(failed+ir).." rails")

end

function save:load()
    version = peek2(DATA_START+SAVE_VERSION_CONTROL)
    if version == VERSION then
        player.p.x = peek2(DATA_START+SAVE_PLAYER_X)
        player.p.y = peek2(DATA_START+SAVE_PLAYER_Y)

        ui.coins = peek2(DATA_START+SAVE_COINS)
        ui.stone = peek2(DATA_START+SAVE_STONES)
        ui.tree = peek2(DATA_START+SAVE_TREES)

        player.p.x = peek2(DATA_START+SAVE_PLAYER_X)
        player.p.y = peek2(DATA_START+SAVE_PLAYER_Y)
        train.pp = peek2(DATA_START+SAVE_TRAIN_POS)
        world.areas_unlocked = peek2(DATA_START+SAVE_AREA_UNLOCKED)
        done = peek2(DATA_START+SAVE_OBJ_DONE)
        for i=1,#ui.objectives do
            if i <= done then
                ui.objectives[i].done = true
            end
        end

        bytes_items = {}
        for b = 1,(512/8) do
            byte = peek(DATA_START+SAVE_ITEMS_START+b-1)
            add(bytes_items, byte)
        end
        aob = array_of_bytes_to_array_of_bools(bytes_items)
        for i=1,#self.items do
            if aob[i] then
                x,y=self.items[i][1], self.items[i][2]
                world.items[x][y] = create_item({x=x,y=y})
            end
        end

        -- load rails
        ir = 0
        for x=0,world.w-1 do
            for y=0,world.h-1 do
                if ir < MAX_RAILS_SAVED then
                    x = peek(DATA_START+SAVE_RAILS_START + ir*2 + 0) - 1
                    y = peek(DATA_START+SAVE_RAILS_START + ir*2 + 1) - 1
                    if x >= 0 and y >= 0 then
                        world.items[x][y]:set_rail()
                    end
                    ir += 1
                end
            end
        end
        world:refresh_connections()
    end
end