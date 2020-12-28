-- https://www.lexaloffle.com/bbs/?tid=37015

vec2mt={
    __add=function(v1,v2)
        return vec2(v1.x+v2.x,v1.y+v2.y)
    end,
    __sub=function(v1,v2)
        return vec2(v1.x-v2.x,v1.y-v2.y)
    end,
    __unm=function(self)
        return vec2(-self.x,-self.y)
    end,
    __mul=function(s,v)
        return vec2(s*v.x,s*v.y)
    end,
    __len=function(self)
        return sqrt(self.x*self.x+self.y*self.y)
    end,
    __eq=function(v1,v2)
        return v1.x==v2.x and v1.y==v2.y
    end,
}
vec2mt.__index=vec2mt

function vec2(x,y)
    v = setmetatable({x=x,y=y},vec2mt)
    return v
end

function rotate_2d_multi(ps, center, angle)
  local s = sin(angle)
  local c = cos(angle)

  new_list = {}
  for p in all(ps) do
    -- translate point back to origin:
    p.x -= center.x;
    p.y -= center.y;
    add(new_list, vec2(p.x * c - p.y * s + center.x, p.x * s + p.y * c + center.y))
  end
  return new_list

end

function rotate_2d(p, center, angle)
  local s = sin(angle)
  local c = cos(angle)

  -- translate point back to origin:
  p.x -= center.x
  p.y -= center.y

  -- rotate point
  return vec2(p.x * c - p.y * s + center.x, p.x * s + p.y * c + center.y)
end
