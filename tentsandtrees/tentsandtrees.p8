pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
-- tents and trees
-- by frozax

-- sfx: gruber

-- try the original mobile game at https://www.frozax.com/tat

#include ../libs/colors.p8
#include ../libs/buttons.p8
#include ../libs/vec2.p8
#include ../libs/fps.p8
#include ../libs/menu.p8
#include ../libs/util.p8

#include sfx.p8
#include level.p8
#include input_game.p8
#include level_select.p8
#include save.p8
#include tutorial.p8
#include draw_level.p8


function _update()
    if tutorial != 0 then
        input_tutorial()
    else
        if mode == "home" then
            home_menu:input()
        elseif mode == "level_select" then
            level_select:input()
        elseif mode == "game" then
            if pause then
                pause_menu:input()
            else
                input_game(game_level)
            end
        end
    end
end

function draw_title()
    rectfill(1, 1, 126, 35, 8)
end

function _draw()
    if tutorial != 0 then
        draw_tutorial(tutorial)
    else
        if mode == "home" then
            cls(bg_col)
            draw_title()
            home_menu:draw(50)
        elseif mode == "level_select" then
            cls(bg_col)
            draw_title()
            level_select:draw(53)
        elseif mode == "game" then
            cls(bg_col)
            game_level:draw()
            if pause then
                border = 30
                y = 40
                draw_rwin(32, y, 127-64, 50, 5, 0)
                pause_menu:draw(y + 10)
            else
                draw_input()
                completion = level:get_completion()
                print(completion, 10, 10, 0)
            end
        end
    end

    showpct(0)
end

function _init()
    mode = "game"
    tutorial = 3
    cell_inner_size = 11
    cell_size = 12
    tree_height = 14

    bg_col = 15
    grass_col = 11
    unknown_col = 13
    grid_col = 5
    numbers_wip_col = 1
    numbers_error_col = 8
    numbers_ok_col = 9
    input_col = 0

    bplay = {text="play"}
    bhtp = {text="how to play"}
    function bplay:click()
        mode = "level_select"
    end
    function bhtp:click()
        tutorial = 1
    end
    home_menu = create_menu({bplay,bhtp})

    bres = {text="resume"}
    function bres:click()
        pause = false
    end
    bquit = {text="quit"}
    function bquit:click()
        pause = false
        mode = "home"
    end

    pause_menu = create_menu({bres, bhtp, bquit})
    pause = false

    GR = 0
    TE = 1
    TR = 2
    UN = 3
    l = {
        {GR,GR,GR,TE,GR},
        {TE,TR,GR,TR,GR},
        {GR,GR,GR,GR,GR},
        {TR,TR,TE,GR,TE},
        {TE,GR,GR,GR,TR},
    }
    game_level = load_level(l)

    levels = {l}
    init_input()
    --level_select = create_level_select(#levels)
    level_select = create_level_select(20)
end


__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000900000007000007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00009820000077700077700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00008880000007770777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00098282000000777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00098282000000077700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00982528200000777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00985558200007770777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
09885558820077700077700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
09888888820007000007000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00003330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00033333000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00033333000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00033333000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00073333000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00037733000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00033333000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00033337000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00033773000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00033333000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00003330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
f0f0ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
f0f0ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
f000ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
fff0ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
fff0ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffff0f0f000f000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffff0f0ff0ff0f0fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffff0f0ff0ff000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffff000ff0ff0fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffff000f000f0fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
fffffffffffffffffffffffffffffffffff111fffffffff999fffffffff11ffffffffff99ffffffffff11fffffffffffffffffffffffffffffffffffffffffff
fffffffffffffffffffffffffffffffffffff1fffffffff9f9ffffffffff1fffffffffff9fffffffffff1fffffffffffffffffffffffffffffffffffffffffff
fffffffffffffffffffffffffffffffffff111fffffffff9f9ffffffffff1fffffffffff9fffffffffff1fffffffffffffffffffffffffffffffffffffffffff
fffffffffffffffffffffffffffffffffff1fffffffffff9f9ffffffffff1fffffffffff9fffffffffff1fffffffffffffffffffffffffffffffffffffffffff
fffffffffffffffffffffffffffffffffff111fffffffff999fffffffff111fffffffff999fffffffff111ffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffff5555555555555555555555555555555555555555555555555555555555555fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffff5bbbbbbbbbbb5bbbbbbbbbbb5bbbbbbbbbbb5bbbbbbbbbbb5ddddddddddd5fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffff5bbbbbbbbbbb5bbbbbbbbbbb5bbbbbbbbbbb5bbbbb9bbbbb5ddddddddddd5fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffff5bbbbbbbbbbb5bbbbbbbbbbb5bbbbbbbbbbb5bbbb982bbbb5ddddddddddd5fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffff99ffff5bbbbbbbbbbb5bbbbbbbbbbb5bbbbbbbbbbb5bbbb888bbbb5ddddddddddd5fffffffffffffffffffffffffffffffffffff
fffffffffffffffffffffffff9ffff5bbbbbbbbbbb5bbbbbbbbbbb5bbbbbbbbbbb5bbb98282bbb5ddddddddddd5fffffffffffffffffffffffffffffffffffff
fffffffffffffffffffffffff9ffff5bbbbbbbbbbb5bbbbbbbbbbb5bbbbbbbbbbb5bbb98282bbb5ddddddddddd5fffffffffffffffffffffffffffffffffffff
fffffffffffffffffffffffff9ffff5bbbbbbbbbbb5bbbbbbbbbbb5bbbbbbbbbbb5bb9825282bb5ddddddddddd5fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffff999fff5bbbbbbbbbbb5bbbbbbbbbbb5bbbbbbbbbbb5bb9855582bb5ddddddddddd5fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffff5bbbbbbbbbbb5bbbb333bbbb5bbbbbbbbbbb5b988333882b5ddddddddddd5fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffff5bbbbbbbbbbb5bbb33333bbb5bbbbbbbbbbb5b983333382b5ddddddddddd5fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffff5bbbbbbbbbbb5bbb33333bbb5bbbbbbbbbbb5bbb33333bbb5ddddddddddd5fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffff5555555555555555333335555555555555555555333335555555555555555fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffff5bbbbbbbbbbb5bbb73333bbb5ddddddddddd5bbb73333bbb5ddddddddddd5fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffff5bbbbbbbbbbb5bbb37733bbb5ddddddddddd5bbb37733bbb5ddddddddddd5fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffff5bbbbbbbbbbb5bbb33333bbb5ddddddddddd5bbb33333bbb5ddddddddddd5fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffff11ffff5bbbbbbbbbbb5bbb33337bbb5ddddddddddd5bbb33337bbb5ddddddddddd5fffffffffffffffffffffffffffffffffffff
fffffffffffffffffffffffff1ffff5bbbbbbbbbbb5bbb33773bbb5ddddddddddd5bbb33773bbb5ddddddddddd5fffffffffffffffffffffffffffffffffffff
fffffffffffffffffffffffff1ffff5bbbbbbbbbbb5bbb33333bbb5ddddddddddd5bbb33333bbb5ddddddddddd5fffffffffffffffffffffffffffffffffffff
fffffffffffffffffffffffff1ffff5bbbbbbbbbbb5bbbb333bbbb5ddddddddddd5bbbb333bbbb5ddddddddddd5fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffff111fff5bbbbbbbbbbb5bbbbb4bbbbb5ddddddddddd5bbbbb4bbbbb5ddddddddddd5fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffff5bbbbbbbbbbb5bbbbb4bbbbb5ddddddddddd5bbbbb4bbbbb5ddddddddddd5fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffff5bbbbbbbbbbb5bbbbb4bbbbb5ddddddddddd5bbbbb4bbbbb5ddddddddddd5fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffff5bbbbbbbbbbb5bbbbbbbbbbb5ddddddddddd5bbbbbbbbbbb5ddddddddddd5fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffff5555555555555555555555555555555555555555555555555555555555555fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffff5bbbbbbbbbbb5bbbbbbbbbbb5bbbbbbbbbbb5bbbbbbbbbbb5bbbbbbbbbbb5fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffff5bbbbbbbbbbb5bbbbbbbbbbb5bbbbbbbbbbb5bbbbbbbbbbb5bbbbbbbbbbb5fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffff5bbbbbbbbbbb5bbbbbbbbbbb5bbbbbbbbbbb5bbbbbbbbbbb5bbbbbbbbbbb5fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffff999fff5bbbbbbbbbbb5bbbbbbbbbbb5bbbbbbbbbbb5bbbbbbbbbbb5bbbbbbbbbbb5fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffff9f9fff5bbbbbbbbbbb5bbbbbbbbbbb5bbbbbbbbbbb5bbbbbbbbbbb5bbbbbbbbbbb5fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffff9f9fff5bbbbbbbbbbb5bbbbbbbbbbb5bbbbbbbbbbb5bbbbbbbbbbb5bbbbbbbbbbb5fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffff9f9fff5bbbbbbbbbbb5bbbbbbbbbbb5bbbbbbbbbbb5bbbbbbbbbbb5bbbbbbbbbbb5fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffff999fff5bbbbbbbbbbb5bbbbbbbbbbb5bbbbbbbbbbb5bbbbbbbbbbb5bbbbbbbbbbb5fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffff5bbbb333bbbb5bbbb333bbbb5bbbbbbbbbbb5bbbbbbbbbbb5bbbbbbbbbbb5fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffff5bbb33333bbb5bbb33333bbb5bbbbbbbbbbb5bbbbbbbbbbb5bbbbbbbbbbb5fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffff5bbb33333bbb5bbb33333bbb5bbbbbbbbbbb5bbbbbbbbbbb5bbbbbbbbbbb5fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffff5555333335555555333335555555555555550000000000000555555555555fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffff5bbb73333bbb5bbb73333bbb5ddddddddddd0ddddddddddd0ddddddddddd5fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffff5bbb37733bbb5bbb37733bbb5ddddddddddd0ddddddddddd0ddddddddddd5fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffff5bbb33333bbb5bbb33333bbb5ddddddddddd0ddddddddddd0ddddddddddd5fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffff111fff5bbb33337bbb5bbb33337bbb5ddddddddddd0ddddddddddd0ddddddddddd5fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffff1fff5bbb33773bbb5bbb33773bbb5ddddddddddd0ddddddddddd0ddddddddddd5fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffff111fff5bbb33333bbb5bbb33333bbb5ddddddddddd0ddddddddddd0ddddddddddd5fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffff1fffff5bbbb333bbbb5bbbb333bbbb5ddddddddddd0ddddddddddd0ddddddddddd5fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffff111fff5bbbbb4bbbbb5bbbbb4bbbbb5ddddddddddd0ddddddddddd0ddddddddddd5fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffff5bbbbb4bbbbb5bbbbb4bbbbb5ddddddddddd0ddddddddddd0dddd333dddd5fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffff5bbbbb4bbbbb5bbbbb4bbbbb5ddddddddddd0ddddddddddd0ddd33333ddd5fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffff5bbbbbbbbbbb5bbbbbbbbbbb5ddddddddddd0ddddddddddd0ddd33333ddd5fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffff5555555555555555555555555555555555550000000000000555333335555fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffff5ddddddddddd5ddddddddddd5ddddddddddd5ddddddddddd5bbb73333bbb5fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffff5ddddddddddd5ddddddddddd5ddddddddddd5ddddddddddd5bbb37733bbb5fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffff5ddddddddddd5ddddddddddd5ddddddddddd5ddddddddddd5bbb33333bbb5fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffff11ffff5ddddddddddd5ddddddddddd5ddddddddddd5ddddddddddd5bbb33337bbb5fffffffffffffffffffffffffffffffffffff
fffffffffffffffffffffffff1ffff5ddddddddddd5ddddddddddd5ddddddddddd5ddddddddddd5bbb33773bbb5fffffffffffffffffffffffffffffffffffff
fffffffffffffffffffffffff1ffff5ddddddddddd5ddddddddddd5ddddddddddd5ddddddddddd5bbb33333bbb5fffffffffffffffffffffffffffffffffffff
fffffffffffffffffffffffff1ffff5ddddddddddd5ddddddddddd5ddddddddddd5ddddddddddd5bbbb333bbbb5fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffff111fff5ddddddddddd5ddddddddddd5ddddddddddd5ddddddddddd5bbbbb4bbbbb5fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffff5ddddddddddd5ddddddddddd5ddddddddddd5ddddddddddd5bbbbb4bbbbb5fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffff5ddddddddddd5ddddddddddd5ddddddddddd5ddddddddddd5bbbbb4bbbbb5fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffff5ddddddddddd5ddddddddddd5ddddddddddd5ddddddddddd5bbbbbbbbbbb5fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffff5555555555555555555555555555555555555555555555555555555555555fffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff

__sfx__
010200000472005731067410c75110761077610070000700007001970000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700
000800000f04013051170511800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000300000c1600e151101411213113121141111511115115000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000006450084500d4500f4501a450214402243000400004000040000400004000040000400004000040000400004000040000400004000040000400004000040000400004000040000400004000040000400
000400000c5600f55114051180511b0411d0412000017000140000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700
000300000c7500f041130311312500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00060000190611c0511f04122031280051f000220002200021000220001f0001f000220002200021000220001f0001f0002e0012e0002d0002e0002b0002b0002b0022b005000000000000000000000000000000
000200000c1540d1510e5510f54110041110411273113731147311573500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000400002152526535005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500
000300002f73534735000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000300003053534535044000440010400044000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00030000180251f535260452a55512604176011b6011f601226012560128601296012b601296012760124601216011f6011c601186011560113601116010f6010e60500500005000050000500005000050000500
0002000019045000001e0450000023045000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00040000260452b035300253000500703007030070300703007030070300703007030070300703007030070300703007030070300703007030070300703007030070300703007030070300703007030070300703
000400002474526745297452e7453074532745357453a7452400526005290052e0053000532005350053a00500000000000000000000000000000000000000000000000000000000000000000000000000000000
00010000197770c700197770c7001c7670c7001c7570c7001e7570c700217470c700217370c700237370c700237270c700257170c700287170c7000c7000c700135000c600135000c600135050c605135050c605
00010000287770c700257770c700257670c700237570c700237570c700217470c700217370c7001e7370c7001c7270c7001c7170c70019717127050c700127050070000700007000070000700007000070000700
00020000016100d6111c61131611146110c61108611056110261501601016050c600116001a600006000060000600006000060000600006000060000600006000000000000000000000000000000000000000000
00020000052670061710267006171236700617123570161712357016170a157006170d147006170d147006170b047006170b037006170a037006170a727006170b727006170c717006170b117006170811700617
000400002763022630206201b6201661015610116100d6100b6100761005610036100261002610026100261001610016100161501600016000160001600000000000000000000000000000000000000000000000
00070000386303062025610206101c61019610176101561012610106100f6100d6100b6100a613086130761306613046130361303613006050060500605006050060500605006050060500605006050060500605
000200000c475152740f474186651646515264114540e6550d4550b24408445066440443502234014340062500424002240041500615000040000400004000040000400004000040000400004000040000400004
0002000012055112550f0450e2450d0450c2450b0350a235090350823507025062250502504225030150221501015012150400503205010050760506605066050560504605046050360502605016050160501605
00020000010541325514045142451203515235110351622510025172250e0250a2250702508225050250621503015042150400503205010050760506605066050560504605046050360502605016050160501605
000200003f643232333a64121231346411e2312f641172312a63112221246310d2211e63109221186310522111621032110c62101211086250121504625002150261500615006000060500600006000060000600
000300000c363236650935520641063311b6210432116611023210f611013110a6110361104600036000260001600016000460003600026000160001600016000160004600036000260001600016000160001600
00051c2032251376512a25133641222412e6411b2412564115241216410c2311d631092311963106231166310323112631022310e631012310a63100221086210022104621002210362100211026110021100611
000500001235311353103530f3530e3530e3530d3530d3430c3430c3430b3430b3430a3430a343093330933308333083330733307333063330632305323053230432304323033230332302313023130131301313
000100000c1500e0511105114051170511705014051120510f0510c15100100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100001000010000100
000500000c466186660c456186560c446186460c436186360c416186160c406184060040000400004000040000400004000040000400004000040000400004000040000400004000040000400004000040000400
0002000002215006200341500630052150063008415006300b215006400d415006401022500640124250065011225006400f425006400d2150064009415006300621500630054150063003215006300341500620
000200003f6142646525361242512345122341212413f6041f3050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000100200a4133b2110a1133b4110b013302110b313302210a1133b2110a4133b2110a0133b2210a1133b211091133a211091133a6110a4133b2210a1133b2110a7133b2210a3133b2110a1133b2110a6133b411
000100003b35039350363503475032750307502e7502b750297502675023750235000b20007200062000520003200022000120001200000000000000000000000000000000000000000000000000000000000000
00020000133551f3552b3553735537305003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000000
000100001d251202512f2512c2513e2513d2511d0001d0001d0001d0001d0001d0001d00000200002000020000200002000020000200002000020000200002000020000200002000020000200002000020000200
000100002b52329543265532555323551215511f5511c5511955118551165511455113541105410d5310b52108521075210551103511025110151102400023000130003400024000140001400024000240001400
000100000f12500000000000710500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000100000c15515003000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0004000014163007000c1000000000000000001015300700000000000000000000000b14300700000000000000000000000613300700000000000000000000000312300700000000000000000000000111300700
000200000c05006731037150070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700
000c00000c34300300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300003000030000300
0005000011574160741357418074155641a064165641b054185541d0541a7541f5441b044217441d544220441f744245342103426734220242772424014297140070400704007040070400704007040070400704
000600000b07012741127350c07013741137350d07014741147350f0701674116735182001840018300185021800512200122050a2000a4000a3000a0050a70500000000000d0001400014005000000000000000
000300000c343236450933520621063311b6210432116611023210f611013110a6110361104600036000260001600016000460003600026000160001600016000160004600036000260001600016000160001600
00020000187551a5551c7551554517745195451273514535167350f52511725135250c7150e515107150060000600006000060000600006000060000600006000060000600006000060000600006000060000600
000600001c36311000103331031310303107031070513005306041070310705000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000200002406025051270412f0002b0512c0512d0412e0312f0212f0052f00032000030000000037000370002f0002f0002f0002f000000003300004000000000000000000000000000000000000000000000000
001000001c1431c1331c1231c1131b1031a1030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000300002e3322b33128332263312333221331203321d3311b3221a3211932217321153221332112322103210e3120c3110b31209311073120631104312033110231201311013120031100300003000030000300
00010000352103751534100371003f10039100331001f1001f1001f1001f100231002a10034100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00090000013150132501345000002660021600196001260011607116070c60710607156071a6071e607206072260722607206001d6001c60018600156001560014600166001a6001c6001c600166000f60000000
000200001d3551d7451d3351375513345137350070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700007000070000700
000a00022474129741000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000300001d61506323156002d60001600016000160002600026000360003600036000d60000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000100000c0150c0050c005110350c0050c0050c00516055000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005
0007000023745287452d3021e105370021c0051330213302133021330213302133021330213302133021330213302133021330213302133021330213302133021320207002070022b0001f0001f0021f0021f002
000400002f3402f3402f3403434034340343403433034330343303433034330343203432034310343103431034310343103431500300003000030000300003000030000300003000030000300003000030000300
000200001d6651e655083410a4410b3410c4310d3310f43111321134211532117411193111b4111b3011d3011830510305163050f3050e3050d3050c3050b3050a30509305083050630505305043050000000000
000900000864514645070450654502204006050550005500266002460023600216001f6001d6001c6001a60018600176001660015600146000030000300003000030000300003000030000300003000030000300
00020000071540f163163730b22332643216331c6231861315613136130e6130a61304600000000000000000000000b1010710105101031010110100000000000000000000000000000000000000000000000000
0012000015753047000500005700070000770009000097000b0000b7000c0000c7000c000180000c000180000c000180000c00018000210022100221002000000000000000000000000000000000000000000000
000600002336311000103330400010705107031070513005306041070310705000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00010000137371c537142371d737155471e147167471f547161571f757175572015718767215671916722767115771a177127771b57718100210001950022100140001d500151001e000165001f1001700020500
