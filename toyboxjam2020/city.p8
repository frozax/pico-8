cur_city = 0
city_w, city_h=4,4
city_names = {"paris", "tokyo", "dallas", "london", "berlin", "roma"}--, "madrid", "sydney"}
city_rewards = {50, 60, 100, 150, 200, 250, 250}--, "madrid", "sydney"}
first_city = vec2(3, 7)
cities_pos = {{first_city.x, first_city.y}, {14, 16}, {31, 24}, {50, 9}, {80, 18}, {110,22}}


function create_city(position)
    city = {}
    city.x = position.x
    city.y = position.y
    city.name=city_names[cur_city + 1]
    city.reward=city_rewards[cur_city+1]
    city.flip1 = rnd({true,false})
    city.flip2 = rnd({true,false})
    city.gare_x = rnd({0, 1, 2})
    cur_city = (cur_city + 1) % #city_names

    function city:draw()

        x = self.x*8 - world.origin.x
        y = self.y*8 - world.origin.y

        spr(spr_clock, x+self.gare_x*8+4, y-16)

        -- name
        rectfill(x+3, y-15-8, x + 31-4, y - 9-8, 1)
        print(self.name, x + 16 - #self.name*4/2, y - 14-8, 7)
    end

    function city:gen_item(local_coords)
        x = local_coords.x + self.x
        y = local_coords.y + self.y
        if local_coords.y == -1 then
            if local_coords.x < self.gare_x or local_coords.x > self.gare_x + 1 then
                return create_item({type="house", city=self, x=x,y=y})
            else
                return create_item({type="gare_col", city=self, x=x,y=y})
            end
        elseif local_coords.y == -2 then
            if local_coords.x == self.gare_x then
                return create_item({type="gare_left", city=self, x=x,y=y})
            elseif local_coords.x == self.gare_x+1 then
                return create_item({type="gare_right", city=self, x=x,y=y})
            end
        elseif local_coords.y == 0 then
            return create_item({type="rail", city=self, x=x,y=y})
        end
        return create_item({x=x,y=y,city=self})
    end

    function city:spawn_coins()
        sfx_spawn_coins()
        for x=self.x,self.x+3 do
            i = world.items[x][self.y-2]
            if i.type == nil or i.type == "" then
                world.items[x][self.y-2] = create_item({x=x,y=self.y-2,type="coins",amount=self.reward\2})
            end
        end
    end

    return city
end
