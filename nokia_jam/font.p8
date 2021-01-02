-- prints using nokia font

font_width = 7
font_height = 8
--font_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 $€£¥¤+-*/=%\"'#@&_(),.;:?!\\|{}<>[]'^~"
font_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 $$$$$+-*/=%\"'#@&_(),.;:?!\\|$$<>[]$^~"
-- init array of char -> index function
char_2_index = {}
char_2_size = {}
char_2_left_border = {}
for i=1,#font_chars do
    c = sub(font_chars, i, i)
    char_2_index[c] = i
    size = 5
    if c=="'" then
        size=1
    elseif c == "i" or c == "I" or c == "l" or c=="," or c=="." or c==";" or c==":" or c=="!" or c=="|" then
        size = 2
    elseif c == "1" or c == "f" or c == "j" or c=="t" or c=="/" or c=="\"" or c=="(" or c==")" or c=="\\" or c=="[" or c=="]" then
        size = 3
    elseif c=="L" or c=="J" or c=="c" or c=="r" or c=="s" or c=="=" then
        size = 4
    elseif c=="N" or c=="O" or c=="Q" or c=="T" or c=="V" or c=="X" or c=="Y" or c=="%" or c=="@" or c=="&" then
        size = 6
    elseif c=="M" or c=="W" or c=="m" or c=="w" then
        size = 7
    end
    border = (font_width - size) \ 2
    if c == "I" then
        border = 3
    elseif c=="f" or c=="j" or c=="t" or c=="/" or c=="\"" or c=="'" or c=="&" or c=="," or c=="." or c==";" or c==":" or c=="!" or c=="\\" or c=="|" then
        border = 1
    end
    char_2_size[c] = size
    char_2_left_border[c] = border
end
printh(tostring(char_2_index))
printh(tostring(char_2_size))

function _print(t, x, y, c)
    pal(7,c)
    local dx = x
    local dy = y
    for i=1,#t do
        c = sub(t, i, i)
        if c == "\n" then
            dy += font_height
            dx = x
        else
            local asc = char_2_index[c] - 1
            size = char_2_size[c]
            sx = (asc % 18) * font_width
            sy = (asc \ 18) * font_height + 80
            border = char_2_left_border[c]
            --printh(c.." "..dx.." "..dy.." "..sx.." "..sy.." "..size.."x"..font_height.." left_border:"..border)
            sspr(sx+border, sy, size, font_height, dx, dy)
            dx += size + 1
        end
    end
    pal()
end