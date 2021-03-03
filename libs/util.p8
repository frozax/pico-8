function blink(speed, c0, c1)
    ti = flr(time() * speed)
    if ti % 2 == 0 then
        return c0
    end
    return c1
end

-- code from democart
function draw_rwin(_x,_y,_w,_h,_c1,_c2)
 -- would check screen bounds but may want to scroll window on?
 if (_w<12 or _h<12) return(false) -- min size
 -- okay draw inside
 rectfill(_x+3,_y+1,_x+_w-3,_y+_h-1,_c1) -- x big middle bit
 line(_x+2,_y+3,_x+2,_y+_h-3,_c1) -- x left edge taller
 line(_x+1,_y+5,_x+1,_y+_h-5,_c1) -- x left edge shorter
 line(_x+_w-2,_y+3,_x+_w-2,_y+_h-3,_c1) -- x right edge taller
 line(_x+_w-1,_y+5,_x+_w-1,_y+_h-5,_c1) -- x right edge shorter
 --now the border left side
 line(_x,_y+5,_x,_y+_h-5,_c2) -- x longest leftmost edge
 line(_x+1,_y+3,_x+1,_y+4,_c2) -- x 2 left top
 line(_x+1,_y+_h-4,_x+1,_y+_h-3,_c2) -- x 2 left btm
 pset(_x+2,_y+2,_c2)  -- x 1 top dot
 pset(_x+2,_y+_h-2,_c2)  -- x 1 btm dot
 line(_x+3,_y+1,_x+4,_y+1,_c2)  -- x 2 top curve
 line(_x+3,_y+_h-1,_x+4,_y+_h-1,_c2)  -- x 2 btm curve
 --now the border right side
 line(_x+_w,_y+5,_x+_w,_y+_h-5,_c2) -- x longest leftmost edge
 line(_x+_w-1,_y+3,_x+_w-1,_y+4,_c2) -- x 2 left top
 line(_x+_w-1,_y+_h-4,_x+_w-1,_y+_h-3,_c2) -- x 2 left btm
 pset(_x+_w-2,_y+2,_c2)  -- x 1 top dot
 pset(_x+_w-2,_y+_h-2,_c2)  -- x 1 btm dot
 line(_x+_w-3,_y+1,_x+_w-4,_y+1,_c2)  -- x 2 top curve
 line(_x+_w-3,_y+_h-1,_x+_w-4,_y+_h-1,_c2)  -- x 2 btm curve
 -- top and bottom!
 line(_x+5,_y,_x+_w-5,_y,_c2) -- x top
 line(_x+5,_y+_h,_x+_w-5,_y+_h,_c2) -- x bottom
end

function draw_win(_x,_y,_w,_h,_c1,_c2)
 rectfill(_x,_y,_x+_w,_y+_h,_c1)
 rect(_x,_y,_x+_w,_y+_h,_c2)
end

-------------------------------
-- string width with glyphs
function strwidth(str)
 local px=0
 for i=1,#str do
  px+=(ord(str,i)<128 and 4 or 8)
 end
 --remove px after last char
 return px-1
end
-------------------------------
-- get centered on screen width
function center_x(str)
 return 64 - strwidth(str)/2
end
-------------------------------
function printc(_str,_y,_c)
 if _c == nil then
   _c = ongoing_c or 0
 end
 ongoing_c = _c
 if _y == nil then
   _y = ongoing_y or 0
 end
 where=center_x(_str)
 if (where<0) where=0
 print(_str,where,_y,_c)
 ongoing_y = _y + 6
end

-------------------------------
-- centered and outlined
function printco(_str,_y,_c,_co)
 where=center_x(_str)
 if (where<0) where=0
 printo(_str,where,_y,_c,_co)
end

-------------------------------
function printo(str, x, y, c0, c1)
for xx = -1, 1 do
 for yy = -1, 1 do
 print(str, x+xx, y+yy, c1)
 end
end
print(str,x,y,c0)
end

function array_contains(__l, __item)
    for __litem in all(__l) do
        if __litem == __item then
            return true
        end
    end
    return false
end

function array_equals(__a1, __a2)
    if #__a1 != #__a2 then
        return false
    end

    for k, v in pairs(__a1) do
        if __a2[k] != v then
            return false
        end
    end

    return true
end

function shuffle(t)
    for n=1,#t*2 do -- #t*2 times seems enough
        local a,b=flr(1+rnd(#t)),flr(1+rnd(#t))
        t[a],t[b]=t[b],t[a]
    end
    return t
end

function sort(t)
    for n=2,#t do
        local i=n
        while i>1 and t[i-1] > t[i] do
            t[i],t[i-1]=t[i-1],t[i]
            i-=1
        end
    end
end