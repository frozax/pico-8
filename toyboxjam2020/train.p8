train = {}
train.city=""
train.last_city=""
train.state = "stop"    -- stop, drive_front, drive_back

function train:init()
    self.wagons=1
    self.front_pos=world.train_start
    self.front_dir
end

function train:update()
end

function train:draw()

end

