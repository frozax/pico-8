
debug = {}

function debug:init()
    ui.tree = 100
    ui.stone = 100

    ptt = {
        {6,8}, {6,9}, {6,10},
        {6,11}, {6,12}, {6,13},
        {6,14}, {6,15}, {6,16},
        {7,16}, {8,16},{9,16}
    }
    for c in all(ptt) do
        world.items[c[1]][c[2]]:set_rail()
    end
    world:refresh_connections()
    --train:update()
    --train.state="drive_start"
end