function draw_win(_x,_y,_w,_h,_c1,_c2)
 rectfill(_x,_y,_x+_w,_y+_h,_c1)
 rect(_x,_y,_x+_w,_y+_h,_c2)
end

cur_city = 0
city_w, city_h=4,4
city_names = {"paris", "dallas", "tokyo", "london", "berlin", "roma", "madrid", "sydney"}

function create_city()
    city = {name=city_names[cur_city + 1]}
    city.flip1 = rnd({true,false})
    city.flip2 = rnd({true,false})
    city.gare_x = rnd({0, 1, 2})
    cur_city = (cur_city + 1) % #city_names
    city.x=cur_city*5 - 2
    city.y=7

    function city:update()
    end

    function city:draw()

        x = self.x*8 - world.origin.x
        y = self.y*8 - world.origin.y

        -- houses
        --if self.gare_x != 0 then
        --    spr(spr_house, x, y-8, 1, 1, self.flip1)
        --end
        --if self.gare_x == 2 then
        --    spr(spr_house, x+8*1, y-8, 1, 1, self.flip2)
        --end
        --if self.gare_x == 0 then
        --    spr(spr_house, x+8*2, y-8, 1, 1, self.flip2)
        --end
        --if self.gare_x != 2 then
        --    spr(spr_house, x+8*3, y-8, 1, 1, self.flip2)
        --end

        spr(spr_clock, x+self.gare_x*8+4, y-16)

        -- rails
        --spr(spr_rail_h, x, y)
        --spr(spr_rail_h, x+8, y)
        --spr(spr_rail_h, x+8*2, y)
        --spr(spr_rail_h, x+8*3, y)

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
            return create_item({type="railh", city=self, x=x,y=y})
        end
        return create_item({x=x,y=y,city=self})
    end

    return city
end
