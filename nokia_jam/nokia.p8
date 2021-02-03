pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
-- nokia jam pico-8
-- by frozax

-- Nokia font by Zeh Fernando
-- zeh@fatorcaos.com.br

-- Follow me on twitter: @frozax
-- My mobile games: https://www.frozax.com
-- More games: https://frozax.itch.io

#include ../libs/tostring.p8
#include ../libs/util.p8
#include ../libs/buttons.p8
#include ../libs/util.p8
#include ../libs/anim_coroutines.p8
#include ../libs/easings.p8

#include sound.p8
#include font.p8
#include level.p8
#include menu.p8
#include game.p8

bg = 6
fg = 5
sw = 84
sh = 48
sox = (128-sw)/2
soy = (128-sh)/2
cx = (sox+sw \ 2)
cy = (soy+sh \ 2)
button_down = ""
rnd_erase=false

fps15 = false
function update15fps()
    if fps15 == false then
        fps15 = true
    else
        fps15 = false
    end
end

function _update()
    update15fps()
    --if(btnp(buttons.b1)) button_down="b1"
    --if(btnp(buttons.b2)) button_down="b2"
    --if(btnp(buttons.up)) button_down="up"
    --if(btnp(buttons.down)) button_down="down"
    --if(btnp(buttons.left)) button_down="left"
    --if(btnp(buttons.right)) button_down="right"
    
    update_animations()

    if fps15 then
        rnd_erase = flr(rnd()*10) == 0
    end

    if game_state == "mainmenu" then
        mainmenu:update()
    elseif game_state == "levelselect" then
        levelselect:update()
    elseif game_state == "options" then
        options:update()
        if btnp(buttons.b2) then
            set_state("mainmenu")
        end
    elseif game_state == "game" then
        level:update()
        game:update()
        if btnp(buttons.b2) then
            set_state("mainmenu")
        end
    elseif game_state == "howtoplay1" then
        if btnp(buttons.b1) or btnp(buttons.right) then
            set_state("howtoplay2")
        end
    elseif game_state == "howtoplay2" then
        if btnp(buttons.b1) or btnp(buttons.right) then
            set_state("howtoplay3")
        elseif btnp(buttons.b2) or btnp(buttons.left) then
            set_state("howtoplay1")
        end
    elseif game_state == "howtoplay3" then
        if btnp(buttons.b1) or btnp(buttons.right) then
            set_state("howtoplay4")
        elseif btnp(buttons.b2) or btnp(buttons.left) then
            set_state("howtoplay2")
        end
    elseif game_state == "howtoplay4" then
        if btnp(buttons.b1) or btnp(buttons.right) then
            set_state("options")
        elseif btnp(buttons.b2) or btnp(buttons.left) then
            set_state("howtoplay3")
        end
    end
end

-- colors

function clear_screen()
    cls(0)
    rectfill(sox, soy, sox+sw-1, soy+sh-1, bg)
end

-- convert to pico8
function _x(x)
    return x + sox
end
function _y(y)
    return y + soy
end
function _p(x, y)
    return _x(x), _y(y)
end

function _draw()
    if fps15 then
        draw()
    end
end

function set_pal_inv()
    pal(8, fg)
    pal(7, bg)
end

function set_pal()
    pal(7, fg)
    pal(8, bg)
end

function set_state(state)
    -- end state
    printh("set_state: ".."game_state".." -> "..state)
    if game_state == "mainmenu" then
        music(-1)
    end
    -- set state
    game_state = state
    -- begin state
    if state == "mainmenu" then
        music(0)
        logo_y = animate(soy + 58, soy + 10, 45, ease_out_quad)
    end
end

function draw()
    clear_screen()

    set_pal()
    if game_state == "mainmenu" then
        mainmenu:draw()
    elseif game_state == "howtoplay1" then
        _print("Turn on all the", sox+1, soy+1, fg)
        _print("lights to win.", sox+1, soy+10, fg)
        _print("1/4", sox+42 - 5, soy+sh - 9, fg)
    elseif game_state == "howtoplay2" then
        _print("Select the", sox+1, soy+1, fg)
        _print("switch with", sox+1, soy+10, fg)
        _print("LEFT/RIGHT.", sox+1, soy+19, fg)
        _print("2/4", sox+42 - 5, soy+sh - 9, fg)
    elseif game_state == "howtoplay3" then
        _print("Use UP/DOWN to", sox+1, soy+1, fg)
        _print("to flip the", sox+1, soy+10, fg)
        _print("the switches.", sox+1, soy+19, fg)
        _print("3/4", sox+42 - 5, soy+sh - 9, fg)
    elseif game_state == "howtoplay4" then
        _print("When in game,", sox+1, soy+1, fg)
        _print("use X to quit", sox+1, soy+10, fg)
        _print("Have fun!", sox+14, soy+24, fg)
        _print("4/4", sox+42 - 5, soy+sh - 9, fg)
    elseif game_state == "options" then
        options:draw()
    elseif game_state == "levelselect" then
        levelselect:draw()
    elseif game_state == "game" then
        --printc("hello nokia", 64-2, fg)
        --_print("Hello Nokia!", sox+1, soy+1, fg)
        --_print("AABBCCDDEEFFGGHHII\nJJKKLLMMNNOOPPQQ\nRRSSTTUUVVWW\nXXYYZZ0123456789", 0, 70, fg)
        --_print("aabbccddeeffgghhii\njjkkllmmnnooppqq\nrrssttuuvvww\nxxyyzz0123456789", 0, 70, fg)
        --_print("+-*/=%\"'#@&_()\n,.;:?!\\|<>[]^~", 0, 70, fg)
        --_print(tostring(rnd(10)), cx, cy)
        --_print(button_down, sox+1, soy+10, fg)
        --_print(tostring(btn()), sox+1, soy+20, fg)
        level:draw()
        game:draw()
    end
    pal()
    _draw_safe_frame()
end

function _draw_safe_frame()
    col = 3
    rectfill(0, 0, 127, soy - 1, col)
    rectfill(0, soy+sh, 127, 127, col)
    rectfill(0, 0, sox - 1, 127, col)
    rectfill(_x(sw), 0, 127, 127, col)
end

function _init()
    set_state("game")
    level = gen_level()
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000007770000007770077000000007770000000077000000077770000077700077700000777777700000777777000
00000777700000000007777000000000000000007770000007770000700000007770000000777000007777777700777000077700007777777777007777777700
00077777777000000770000770000000000000007770000007770000700000007700000000770000077770007700777000007700007700770770077700007700
00777777777700007000000007000000000000007770000007770000700000007700000000770000077000007000770000007770077000700070077000000700
07777777777770070000000000700000000000007770000007770000700000077700000000770000077000000000770000000770000007700000077700000000
07777777777770070000000000700000000000007770000007770000700000077000000000770000770000000000777777777770000007700000077777000000
07777777777770070000000000700000000000007770000007770077000000077000000000770000770000000000777777777770000007700000007777777000
07777777777770070000000000700000000000000000000000000000000000077000000000770000770000077700777700000770000007700000000077777700
07777777777770070000000000700000000000007700000000770000000000077000000000770000770000777700777000000770000007700000070000777770
07777777777770070000000000700000000000007700000000770000000000077000000000770000770000007700770000000770000007700000070000000770
07777777777770070000000000700000000000007700000000770000000000077000000000770000777000007700770000000770000007700000070000000770
00777777777700007000000007000000000000007700000000770000000000077000007000770000077700077700770000000770000007700000077000007770
00077777777000000700000070000000000000007700000000770000000000077700077000770000077777777700770000007770000007700000077777777700
00007777770000000070000700000000000000007700000000770000000000077777777000777000007777777000777000007770000007770000007777777700
00007777770000000070000700000000000000007700000000770000000000077777777000777000000077770000777000077770000007770000000777770000
00000777700000000007777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000700700000000007007000000000000000007000000000070000000000000000777000000007770000077700007777700000000000000000000000000000
00000777700000000007777000000000000000007000000000070000000000000007777700000007777000077700007777000000000000000000000000000000
00000700700000000007007000000000000000007000000000070000000000000077777770000077777700077770007777000000000000000000000000000000
00000077000000000000770000000000000000007000000000070000000000000777707777000077777700007770007770000000000000000000000000000000
00000000000000000000000000000000000000007000000000070000000000000777000777000077777770007770007770000000000000000000000000000000
77777700077770000770000000000000000000007000000000070000000000007770000077700077707770007770007770000000000000000000000000000000
70000700700007007777000000000000000000007000000000070000000000007770000077700077707777007770007770000000000000000000000000000000
70000707000000707777000000000000000000000000000000000000000000007700000007700077700777707770000770000000000000000000000000000000
70000707000000707777000000000000000000007000000000070000000000077700000007770077700077707770000770000000000000000000000000000000
70000707000000700770000000000000000000007000000000070000000000077700000007770077700077777770000770000000000000000000000000000000
70000707000000700000000000000000000000007000000000070000000000077700000007770077700007777770000770000000000000000000000000000000
70000707000000700000000000000000000000007000000000070000000000077700000007770077700007777770000770000000000000000000000000000000
70000707000000700000000000000000000000007000000000070000000000077700000007770077700007777770000000000000000000000000000000000000
77777707000000700000000000000000000000007000000000070000000000077770000077770077700000777770000070000000000000000000000000000000
00000007000000700000000000000000000000000000000000000000000000007777777777700077700000777770000777000000000000000000000000000000
77000007000000700000000000000000000000007777700007700000000000007777777777700077700000777770007777700000000000000000000000000000
77000007000000700000000000000000000000007070700077770000000000000777777777000077770000077770007777700000000000000000000000000000
00000000700007000000000000000000000000000777000070070000000000000077777770000007770000077700000777000000000000000000000000000000
00770000077770000000000000000000000000000070000070070000000000000000000000000000000000000000000000000000000000000000000000000000
07777000000000000000000000000000000000000070000070070000000000000000000000000000000000000000000000000000000000000000000000000000
77777700000000000000000000000000000000000070000070070000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000077770000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77777777777777777777777777777777777777777777777777777777777777777777777777777777777700000000000000000000000000000000000000000000
88888888888888888888888888888888888888888888888888888888888888888888888888888888888800000000000000000000000000000000000000000000
88888877788888877777777777888888777888888777777777778888887778888887777777777788888800000000000000000000000000000000000000000000
77777778777777778888888887777777787777777788888888877777777877777777888888888777777700000000000000000000000000000000000000000000
88888877788888877777777777888888777888888777777777778888887778888887777777777788888800000000000000000000000000000000000000000000
88888888888888888888888888888888888888888888888888888888888888888888888888888888888800000000000000000000000000000000000000000000
88888888888888888888888888888888888888888888888888888888888888888888888888888888888800000000000000000000000000000000000000000000
88877778888888888888888888888888888887788888888778888888778877888888888888888888778800000000000000000000000000000000000000000000
88778888888888888888888888888888888887788888888778888888778888888888888888888888778800000000000000000000000000000000000000000000
88778888877788777788877778778788777887778778778778877788777877887778877778887778778800000000000000000000000000000000000000000000
88778888778778778778778778777788887787788778778778888778778877877877877877877888778800000000000000000000000000000000000000000000
88778888778778778778778778778888777787788778778778877778778877877877877877877778778800000000000000000000000000000000000000000000
88778888778778778778877778778887787787788778778778778778778877877877877877888778888800000000000000000000000000000000000000000000
88877778877788778778888778778888777788778877778778877778877877887778877877877788778800000000000000000000000000000000000000000000
88888888888888888888877788888888888888888888888888888888888888888888888888888888888800000000000000000000000000000000000000000000
88888888888888888888888888888888888888888888888888888888888888888888888888888888888800000000000000000000000000000000000000000000
88888888888888888888888888888888888888888888888888888888888888888888888888888888888800000000000000000000000000000000000000000000
88777777777778888887778888887777777777788888877788888877777777777888888777888888777700000000000000000000000000000000000000000000
77788888888877777777877777777888888888777777778777777778888888887777777787777777788800000000000000000000000000000000000000000000
88777777777778888887778888887777777777788888877788888877777777777888888777888888777700000000000000000000000000000000000000000000
88888888888888888888888888888888888888888888888888888888888888888888888888888888888800000000000000000000000000000000000000000000
77777777777777777777777777777777777777777777777777777777777777777777777777777777777700000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00777000777700007777007777000777770077777000777000770770000770000077000770077077000070000077000770077770007777000777700077770000
07707700770770077000007707700770000077000007700000770770000770000077000770770077000077000777700770770077007707707700770077077000
07707700777700077000007707700777700077770007700000777770000770000077000777700077000077707777770770770077007707707700770077077000
07707700770770077000007707700770000077000007707700770770000770000077000777000077000077707777777770770077007707707700770077077000
07777700770770077000007707700770000077000007707700770770000770000077000777700077000077070777707770770077007777007700770077770000
07707700770770077000007707700770000077000007707700770770000770000077000770770077000077000777700770770077007700007707700077770000
07707700777700007777007777000777770077000000777700770770000770007770000770077077770077000777700070077770007700000777770077077000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077707777770077077077007707700077770077077007700777770000000007700000000000000077000000000077000000000007700000077000007700000
07700000077000077077077007707700077770077077007700000770000000007700000000000000077000000000770000000000007700000000000000000000
07700000077000077077077007707700077077770007777000007770007770007777000077700007777000777000777000007777007777000077000007700000
00770000077000077077007777007707077007700000770000077700000077007707700770000077077007707700770000077077007707700077000007700000
00077000077000077077007777000770770077770000770000777000007777007707700770000077077007777700770000077077007707700077000007700000
00077000077000077077000770000770770770077000770000770000077077007707700770000077077007700000770000007777007707700077000007700000
07770000077000007770000770000770770770077000770000777770007777007777000077700007777000777700770000000077007707700077000007700000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007770000000000000000077000000
07700000077000000000000000000000000000000000000000000000000000007700000000000000000000000000000000000000000000000077700000770000
07700000077000000000000000000000000000000000000000000000000000007700000000000000000000000000000000000000000000000770770007770000
07707700077000777777007777000077700077770000777700770700007770007770000770770077077077000770770770077077007777700770770000770000
07777000077000707707707707700770770077077007707700777700077000007700000770770077077077070770770770077077000077000770770000770000
07770000077000707707707707700770770077077007707700770000077770007700000770770007770077070770077700077077000770000770770000770000
07777000077000707707707707700770770077770000777700770000000770007700000770770007770007777700770770007777007700000770770000770000
07707700077000707707707707700077700077000000007700770000077700000770000077770000700007707700770770000077007777700077700000770000
00000000000000000000000000000000000077000000007700000000000000000000000000000000000000000000000000007770000000000000000000000000
07777000777700000077007777000077700077777000777000077700000000000707000000000000777007700770000000000000000000000007000000700000
00007700000770000777007000000770000000077007707700770770000000000777700077700007700000777700700070000700000000000707070000700000
00007700000770007077007777000777700000770007707700770770000000007707000700070007700007777770077700000700000000000777770007700000
00777000077700070077000007700770770000770000777000770770000000007777007777700007700000077000770770077777007777000077700007000000
07700000000770077777000007700770770007700007707700077770000000000777707777000077770007777770770770000700000000000777770077000000
07700000000770000077000007700770770007700007707700000770000000000707700700070007700000077000077700000700000000000707070070000000
07777700777700000077007777000077700007700000777000077700000000007777000077700077777000077000700070000000000000000007000070000000
00000000000000000000000000000000000000000000000000000000000000000707000000000000000000000000000000000000000000000000000000000000
00000007700700070700007000000070700000000000777000000000000070000700000000000000000000000000000000077770007700000700000077000000
00000007707700070700007000000777770077770007707700000000000700000070000000000000000000000000000000000077007700000700000077000000
07777000007000000000000000000777770770077000777000000000007700000077000000000000000007700000770000000770007700000770000077000000
00000000077000000000000000000070700777777007777070000000007700000077000000000000000007700000770000007700007700000070000077000000
07777000070000000000000000000777770770777007707770000000007700000077000000000000000000000000000000007700007700000077000077000000
00000000770770000000000000000777770777777007707770000000007700000077000070000077000000700000770000000000000000000007000077000000
00000000700770000000000000000070700770000000777070777770000700000070000770000077000007700000770000007700007700000007000077000000
00000000000000000000000000000000000077770000000000000000000070000700000700000000000007000000000000000000000000000000000077000000
00777000077700000007000700000077700007770000700000007000000770700000000000000000000000000000000000000000000000000000000000000000
00770000007700000077000770000077000000770000070000077700007077000000000000000000000000000000000000000000000000000000000000000000
00770000007700000770000077000077000000770000000000070700000000000000000000000000000000000000000000000000000000000000000000000000
00770000007700007700000007700077000000770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00770000007700000770000077000077000000770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00770000007700000077000770000077000000770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00770000007700000007000700000077000000770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00777000077700000000000000000077700007770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333336666666666666666666666666666666666666666666666666666666666666666666666666666666666663333333333333333333333
33333333333333333333336556556666666556556666666666666566655666666655666655666666655666666666666666666666663333333333333333333333
33333333333333333333336556556666666556556666666666666556655666666655666666666666655666666666666666666666663333333333333333333333
33333333333333333333336555556655566556556655566666666555655665556655655655665556655666666666666666666666663333333333333333333333
33333333333333333333336556556556556556556556556666666555555655655655556655666655655666666666666666666666663333333333333333333333
33333333333333333333336556556555556556556556556666666556555655655655566655665555655666666666666666666666663333333333333333333333
33333333333333333333336556556556666556556556556666666556655655655655556655655655666666666666666666666666663333333333333333333333
33333333333333333333336556556655556556556655566666666556665665556655655655665555655666666666666666666666663333333333333333333333
33333333333333333333336666666666666666666666666666666666666666666666666666666666666666666666666666666666663333333333333333333333
33333333333333333333336666666666666666666666666666666666666666666666666666666666666666666666666666666666663333333333333333333333
33333333333333333333336666666666666666666666666666666666666666666666666666666666666666666666666666666666663333333333333333333333
33333333333333333333336666666666666666666666666666666666666666666666666666666666666666666666666666666666663333333333333333333333
33333333333333333333336666666666666666666666666666666666666666666666666666666666666666666666666666666666663333333333333333333333
33333333333333333333336666666666666666666666666666666666666666666666666666666666666666666666666666666666663333333333333333333333
33333333333333333333336666666666666666666666666666666666666666666666666666666666666666666666666666666666663333333333333333333333
33333333333333333333336666666666666666666666666666666666666666666666666666666666666666666666666666666666663333333333333333333333
33333333333333333333336666666666666666666666666666666666666666666666666666666666666666666666666666666666663333333333333333333333
33333333333333333333336666666666666666666666666666666666666666666666666666666666666666666666666666666666663333333333333333333333
33333333333333333333336666666666666666666666666666666666666666666666666666666666666666666666666666666666663333333333333333333333
33333333333333333333336666666666666666666666666666666666666666666666666666666666666666666666666666666666663333333333333333333333
33333333333333333333336655566666666666666666666666666666666666666666666666666666666666666666666666666666663333333333333333333333
33333333333333333333336556556666666666666666666666666666666666666666666666666666666666666666666666666666663333333333333333333333
33333333333333333333336556556666666666666666666666666666666666666666666666666666666666666666666666666666663333333333333333333333
33333333333333333333336556556666666666666666666666666666666666666666666666666666666666666666666666666666663333333333333333333333
33333333333333333333336556556666666666666666666666666666666666660000666660000666000666000660000666666666663333333333333333333333
33333333333333333333336556556666666666666666666666666666666666660666666660666660066660060066660066666666663333333333333333333333
33333333333333333333336655566666666666666666666666666666666666660000666660000660000660060066660066666666663333333333333333333333
33333333333333333333336666666666666666666666666666666666666666666660066666660060060060060066000666666666663333333333333333333333
33333333333333333333336666666666666666666666666666666666666666666660066666660060060066000066660066666666663333333333333333333333
33333333333333333333336666666666666666666666666666666666666666666660060066660060060066660066660066666666663333333333333333333333
33333333333333333333336666666666666666666666666666666666666666660000660060000666000666000660000666666666663333333333333333333333
33333333333333333333336666666666666666666666666666666666666666666666666666666666666666666666666666666666663333333333333333333333
33333333333333333333336666666666666666666666666666666666666666666666666666666666666666666666666666666666663333333333333333333333
33333333333333333333336666666666666666666666666666666666666666666666666666666666666666666666666666666666663333333333333333333333
33333333333333333333336666666666666666666666666666666666666666666666666666666666666666666666666666666666663333333333333333333333
33333333333333333333336666666666666666666666666666666666666666666666666666666666666666666666666666666666663333333333333333333333
33333333333333333333336666666666666666666666666666666666666666666666666666666666666666666666666666666666663333333333333333333333
33333333333333333333336666666666666666666666666666666666666666666666666666666666666666666666666666666666663333333333333333333333
33333333333333333333336666666666666666666666666666666666666666666666666666666666666666666666666666666666663333333333333333333333
33333333333333333333336666666666666666666666666666666666666666666666666666666666666666666666666666666666663333333333333333333333
33333333333333333333336666666666666666666666666666666666666666666666666666666666666666666666666666666666663333333333333333333333
33333333333333333333336666666666666666666666666666666666666666666666666666666666666666666666666666666666663333333333333333333333
33333333333333333333336666666666666666666666666666666666666666666666666666666666666666666666666666666666663333333333333333333333
33333333333333333333336666666666666666666666666666666666666666666666666666666666666666666666666666666666663333333333333333333333
33333333333333333333336666666666666666666666666666666666666666666666666666666666666666666666666666666666663333333333333333333333
33333333333333333333336666666666666666666666666666666666666666666666666666666666666666666666666666666666663333333333333333333333
33333333333333333333336666666666666666666666666666666666666666666666666666666666666666666666666666666666663333333333333333333333
33333333333333333333336666666666666666666666666666666666666666666666666666666666666666666666666666666666663333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333

__sfx__
011200001d0402204027040270402904027040240401f0401b0401804018040160401304013040130401304013040130401604016040180401b0401b04018040160401604016040180401d0401f0402204022040
001000001d0501b0501b0501805016050160501305013050130501305016050180501d0501f0502205022050220501f0501f0501d0501d0501d0501d0501d0501b0501b0501d0501f05024050240502405024050
011100202b5402b5402e5402e500305403354033540305002e5402e5402e5403050029540295402b5402e5002e5402e5403054033500355403354033540305002e5402e5402e5402e5002b54029540295402e500
001100202b5402b5402e5402e50030540335403354030500295402954029540305002454024540275402e50030540305402e54033500355403354033540305002e5402e5402e5402e5002b54029540295402e500
001100202b5402b5402e5402e50033540305403054030500305403054030540305002e5402e540305402e50033540335403554033500375403754033540305003354033540335402e5003054033540335402e500
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
01 02424344
00 03424344
02 04424344

