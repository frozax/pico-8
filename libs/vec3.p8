vec3mt={
    --__add=function(v1,v2)
    --    return vec2(v1.x+v2.x,v1.y+v2.y)
    --end,
    --__sub=function(v1,v2)
    --    return vec2(v1.x-v2.x,v1.y-v2.y)
    --end,
    --__unm=function(self)
    --    return vec2(-self.x,-self.y)
    --end,
    --__mul=function(s,v)
    --    return vec2(s*v.x,s*v.y)
    --end,
    --__len=function(self)
    --    return sqrt(self.x*self.x+self.y*self.y)
    --end,
    --__eq=function(v1,v2)
    --    return v1.x==v2.x and v1.y==v2.y
    --end,
}
vec3mt.__index=vec3mt

function vec3(x,y,z)
    return setmetatable({x=x,y=y,z=z},vec3mt)
end
