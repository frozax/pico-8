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
    items = {}
    for x=0,world.w-1 do
        for y=0,world.h-1 do
            it = world.items[x][y].type
            if it == "stone" or it == "tree" then
                add(items, {x,y})
            end
        end
    end
    assert (#items < MAX_ITEMS, "too many brekable items")
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
-- 512b
SAVE_ITEMS_START=14
-- 
SAVE_RAILS_START=SAVE_ITEMS_START + 512/8
SIZE_PER_RAIL_SAVED = 16 -- 16b
MAX_RAILS_SAVED = (256-SAVE_RAILS_START) * 8 \ SIZE_PER_RAIL_SAVED
printh("max railed saved"..MAX_RAILS_SAVED)

DATA_START = 0x5e00
VERSION=4

function save:save()
    poke2(DATA_START+SAVE_VERSION_CONTROL, VERSION)
    poke2(DATA_START+SAVE_PLAYER_X, player.p.x)
    poke2(DATA_START+SAVE_PLAYER_Y, player.p.y)

    poke2(DATA_START+SAVE_COINS, ui.coins)
    poke2(DATA_START+SAVE_STONES, ui.stone)
    poke2(DATA_START+SAVE_TREES, ui.tree)
    poke2(DATA_START+SAVE_TRAIN_POS, train.pp)
end

function save:load()
    version = peek2(DATA_START+SAVE_VERSION_CONTROL)
    printh("load versino:" ..version)
    if version == VERSION then
        player.p.x = peek2(DATA_START+SAVE_PLAYER_X)
        player.p.y = peek2(DATA_START+SAVE_PLAYER_Y)
        printh("load"..tostring(player.p))

        ui.coins = peek2(DATA_START+SAVE_COINS)
        ui.stone = peek2(DATA_START+SAVE_STONES)
        ui.tree = peek2(DATA_START+SAVE_TREES)

        player.p.x = peek2(DATA_START+SAVE_PLAYER_X)
        player.p.y = peek2(DATA_START+SAVE_PLAYER_Y)
        train.pp = peek2(DATA_START+SAVE_TRAIN_POS)
    end
end