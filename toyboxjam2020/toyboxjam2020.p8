pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
-- toy box jam 2
-- by frozax
-- for toy box jam 2

#include ../libs/vec2.p8
#include ../libs/util.p8
#include ../libs/buttons.p8
#include ../libs/colors.p8
#include ../libs/fps.p8
#include ../libs/tostring.p8

#include anim.p8
#include ui.p8
#include city.p8
#include world_item.p8
#include world.p8
#include player.p8
#include sfx.p8

-------------------------------
function printo(str, x, y, c0, c1)
for xx = -1, 1 do
 for yy = -1, 1 do
 print(str, x+xx, y+yy, c1)
 end
end
print(str,x,y,c0)
end

function _update()
    anims:update()
    -- draw player before to center the world properly
    player:update()
    world:update()
    ui:update()
end

function _draw()
    world:draw()
    --world:debug()
    ui:draw()
    player:draw()
    showpct(7)
    --printo(tostring(world.items[player.p.x\8][player.p.y\8].type), 1, 1, 1, 7)
end

__gfx__
00012000606660666066606660666066606660666066606616666661feeeeee87bbbbbb30000004000000030000300000b0dd030777777674f9f4fff7999a999
07d1257000000000000000000000000000000000007777006d6666d6e8888882b3333331040000000300000003000030d3000b0d76777777fffff9f49999979a
057d57d0666066606660566060333306608888066676d75062444426e8811882b33773310000040000000300000003b0000b030077777677ff4fffff99a99999
22566d11000000000000000000333300008888000077770064222246e8866882b3366531000400000003000000b00bb0b0030000777677779fff9ff999997997
11d6652206660666066605666033330660888806067d675664442446e8877282b3355131400000003000000030b30b003000dd0b677777774fffff9fa9999979
0d75d750000000000000000000331300008818000077770064222a96e8822182b33113310000000400000003003b00030b00000377777776ff4fffff999a9999
07521d70660666066606660660331306608818066605550664424446e8888882b33333310400000003000000030b00000300b00076777777ff9ff9ff99999799
0002100000000000000000000033330000888800000000006422224682222222311111110000400000003000000030000dd030b077776777f9ffff4f979999a9
111c111c7ccc7cc70000000005500550005070500500700000dddd00656565650d0aa000000aa000760000000766660006566650777777500007a90000000070
11c111c177ccc7cc000000000765676005076005000760050dddddd0666666650df99f000df99f0006500000766550000666666576666650000a0000000006d6
1c111c11c77ccc7c00000000076007605076660050766700dddddddd662226650de11e000de11e0700650000664500000659405676565650000aa90000006d60
c111c111cc77ccc7076007600765676050766605007676000555555066666665d55660070d66660200065006650450000009400076666650000a00000006d000
111c111c7cc77ccc07656760076007600766767007667670066666606655566509066602d5d6609200006560650045000009400076565650000a0000076d0000
11c111c1c7cc77cc0760076000000000576676655761166506dd6c6066111665000cc092090cc00200000650600004500009400076565650007aa9007dd6d000
1c111c11cc7cc77c1765676100000000766767667610016606dd6c606611166500c11c0200c11c000000604500000045000940000766650000a00a006d06d000
c111c1117cc7cc771d211d2100000000565655656610016606dd6660cc444ccc044004400440044000060004000000040009400000555000009aa900076d0000
0bb3b3b030bbb0030150051001500510940000499999999994000049000099997667060000065000d777777dd55550000076dc0000999900000000000007d000
bb3b3b350bbb3300157556511575515194544449444444444444444400094444641605000065d650566666657665d650075555d0094444900000000000766d00
b3b33333bb3bbb305757651557576515945555490550055004555550009440006666666065616560566666657661656001c6dc109444444900000000076666d0
b3333335b3b3b33505766650057656509400004904500450045004500944000011111156006176d011111155766176d007cc6d50999aa9990000000000044000
0b4334503bbb3b3505666650056565509400004904500450045004509945400076d176d57661110076d176d57661110007cc6d50955aa5590007d00000094000
0009450033b3b355575665155516551594544449045004500454445094405400656165606161d650656165607661d65007cc6d509544444900766d0000094000
0009450003335550156551511155515194555549444444444455554494000544d650d65064616560d650d6507661656007cc6d5095444449076666d000094000
095454540033350301500510015005109400004999999999940000499400004900000000766176d000000000d55176d00066d500999999990004400000094000
000990000777770000077000007dd500007665000554455000007000067666500007000099999999750705607776777677777776777777767777777677777776
049aa94075666660007667000007500007666650554444550000770000565100007a900090040405565656507665766576666665766666657766665576666665
49a99a940065d56000077000077665507666666545444454000076700067650007aaa90094444445057775007665766576555565766776657676656576666665
9a9aa9a900666660076666707766665576565565455a9554000077770067650007aaa90090004005767766606555655576566765767665657667566576666665
9a9aa9a900655d60765555677666666576666665411a911407007000006765000a99990094444445057665007677767776566765767665657667566576666665
49a99a94006666606500005676666665765565654445544476666667006765007556559095555555565656506576657676577765766556657676656576666665
049aa940006777775650056577666655766666654444444407666670006765000aaaa90000055000750605606576657676666665766666657766665576666665
00499400005555500567765007766550655555555444444500777700067666500000000005064005000000005565556565555555655555556555555565555555
00000000000005d9007a4200000000000000000900009999900a000000000000000000000049400000040000a7a9999900076000000000000001000000000000
0e82e82000555d5507a9942000000000000909aa009999aa09000a900009000009009090049a94000049400004a994400007610000111000001c10000eeeee20
e788888205d6d5550a999940000000000000aaaa09a9aaaa00009000008aa800008aa80049a7a940049a9400097999400007610001ccc10001c7c1007262626c
e88888825d7ddd500a99994000000009090a9a9a099a9909a000000000a77a9009a77a009a777a9449a7a94009a99990707765071c777c1001c7c10015252520
0888882056dddd500a9999400000a09a00a9a9a999a997900090000009a77a0000a77a9049a7a940049a9400099a99407667665601ccc10001c7c10002e50000
0088820055ddd5500ae999400000099a09aa9a7799a970000a000000008aa800008aa800049a940000494000009994007676656500111000001c10005e200000
000820000555550007fe9420000099a70aa9a7779aa090000900000000009000090900900049400000040000000a900007655651000000000001000025200000
0000000000555000007942000009aa779aaa97779aa90000000000000000000000000000000400000000000007a9994000766510000000000000000000000000
000550000005500005677650000550000567765000ddd0000000000000033000060aa05065656565757575751111111111111111111111112888888212888821
00566500005666000567765000566500567777650d666d0003333330033bb33006aa00505dddddd66060606015555555555555555555555188eeee88288ee882
0567765066677760567777650567765067766776d67666d033bbbb3333b77b3306a00a506d5555d5575757571565505050505050505556518ea77ae888eaae88
5677776577777776567777655675576577655677d66666d03b7777b33b7777b30600aa505d5cc6d6060606061555550505050505050555518e7777e88ea77ae8
6777777677777777677557765675576556500565dd666d503b7777b33b7777b3060aa0506d5cc6d5757575751555505050505050505555518e7777e88ea77ae8
77777777666775577777777705677650050000500dddd50033bbbb3333b77b3306aa00505d5666d6606060601555550505050505050555518ea77ae888eaae88
56666665005677505666666500566500000000000055500003333330033bb33006a00a506dddddd55757575715655050505050505055565188eeee88288ee882
05555550000566000555555000055000000000000000000000000000000330000600aa5055555555060606061555555555555555555555512888888212888821
00aaaa000007000000dddd0000dddd000022220050222205bb0bb0bb0b0bb0b00000bbb000000000000990003bb1000000666000000770000076660000766600
0a999940000e00000d7cc7d00d7cc7d0552882550528825003abba30b3abba3b000b1b1ba000bbb000007900b3b3b10006000600007755000702826007282060
a979979400e88000d70cc07dd77cc77d22588522225885220bbbbbb00bbbbbb00a0bbbbbb00b1b1b009a9990bb3bbb1060700060077665500602825006282050
a71991740e111800d77cc77dd70cc07d271881722708807203baab3003baab30b00b3707b00bbbbb0979a99913b3b3b160000060775555550066550000665500
a9999994e8191880dccccccddccccccd2888888228888882b003300b00033000b00bbb00b00b370799a999790bbb3bb160000060775e275507d75d6007d75d60
a992299408111820dcc11ccddcc11ccd28881882288188820b3bb3b00b3bb3b0bb0bbbb0bb0bb3309997aa9901b3b3b106000600775227557d7dd5d67d7dd5d6
b30880d5008882000dccccd00dceecd0028888299288882000bbbb00b0bbbb0b0bb0bbbbbbb0bbbb0999a990001bbb3000666000777776557d7dd5d57d7dd5d5
ff0ee0660008200000dddd0000dddd0099222290092222990bb33bb000b33b0000bbbbb00bbbbbb0009a99000001110b00000000055555500665565006655650
08000080a00700b00056650000077000004aa4000077770000777700000000076776d7765000000000d7cd0009aaaa900000567700a7777d0007700000077000
0000000007a00bba056766500076650044a77a4407666670000666700000007676675665650000000d77ccd09a1aa1a9000567760a6666dd0076670000700700
00880800077bba7b5676666500766500aa7777aa71166117a0776657000007667667566566500000d777cccd9a5aa5a905677775a7777d5d0766667007000070
8008e808b0b7aab067666666007665004aa77aa4712662177a6666660000766676675665666500007777cccc9aaaaaa95677775076666d5d7666666770000007
008ee80000ba7ab0666666660076650004a77a40066116606d666666000766667667566566665000dcccdddd09affa900567777676666d5d0005500000077000
000888000b7b77ab56666665007665004a7aa7a405666650d05661150076666676675665666665000dccddd09a9aa9a95677766576666d5d0006600000700700
000000800ab0b7aa05666650076666504aa44aa4006116000006665007666666766756656666665000dcdd00a900009a6777655076666dd00006600007000070
08008000ab0000a00056650006555550aa4004aa0056650000665000766666666552155666666665000dd0009a9009a9776650006ddddd000006600070000007
007aaa00000a0000202000000006822d02822222020220d000000000000000000000000000000000007665000076650005555555555555555555555055677655
0a999aa000079000022282100026cdcd1111110002200d0000000000000000000000000000000000075006500750065055666666666666666666665556555565
0a9aaa90000a9000001111110216ddddddcdcddd21ddd00002000000000000000000000000000000065006500650000056676767676767676767766556677665
0a9aaaa00009900066ddcdcd0016dddd66666d0081cddd0022ddd000000000000000000000000000766666657666666556777777777777777777776556677665
0a9aaa90000a9000600ddddd0015ddd066dddd001ddddd008dddd000002282000202820002222200766166657663666556777676767676767676776555677655
0a9aaa90000990000005ddd00052111056d111111c66d1111dddd1000221166600211110002282dd766166657663666556766676666666666767766556555565
09aaaa90000990000552211100520010052200000d6661001d66611100666c10011dddd000111110766666657666666556776756666666667577666556677665
0099990000009000500200100502001000502000000552221d666222666dddc066666666666dddd0655555556555555556766665555555555667766556677665
0028210020000000002821002200000002228200005000000000000000000000c0c6cc0000777700056650000000000056677665555575555566765555555555
02111110222821000211111002282100221116660205002002022210202221000cccccc0071111605600650007a00a7056776665565755665555555556677665
d21ddcd60111111021ddcdcd0111111000666c10022560220022822102282210cdd7d7d071111115607006000a9009a056677665565757676565565655555555
d1dd66660ddddcd0666ddddd0dddcdc0066dddcd101d5682011111111111111006ddddd071100115600006000000000056776665575757777576755757777775
00d66d00066dddd06066dd00066dddd05555dd0011ddd62206ddcdcd0ddcdcd00d665ddd71100115560065000000000056677665575756766557675675555557
202211000066dd00001221000066dd00021dd00000dd661260d5dddd6d5dddd000c5ccc071111115056694500a90000056776665565756666565565655677655
02000010002212000110020000221100200100000dd6dc116552ddd16522dd11005c00c0061111500000094507a0000056677665565755665555555556776665
0000000100012000000000200002100000100000d000c1105220011152220001050c00c000555500000000940000000056776665555575555567665556677665
0028226000000000628210000022000022000000222200001112000006822d0026822d0077777777002820000077770056776675555755555677666556776665
002222600028220026111100081d0000820d0000228110001112800026cdcd0016cdcd0000000000028e8200076566d056676756665575656577666556677665
061221600022222006dcdc00621d0000612d000011dcd00011dc600016dddd0006dddd000600600608e7e8007665666d56777667676575657667766555776655
06d11dd0061221160ddddd00611c0200611c0200d66665d5dddd656506dddd0006dddd000000000008eee8007665556d56677777777575757777766575555557
0dd1d1d00dd11ddd05dddd006cdd52016cdd5201dddd0d00ddd6060005ddd00005ddd00000500500028e82007666666d56667676767575756767666557777775
005111000dd1d1dd522dd0d0d66d5211d6665211211100001112000005221110052211100000000000282000076666d056666666666575656666666555555555
0015000000551110220100000d6652100dd6521020001000100020005002000150020001010100100028200000dddd0055666666665575656666665556677665
00105000001051000110000000dd510000dd51002000010010000200500000005000000000000000002820000000000005555555555755555555555055555555
062281100000000000400000202821000028210000282100000000000000000000000000000000007777777711111100566666660015d0005666666500000000
6d6dcdc00000122240900040111111102111111021111110030100000606330000003300000000007555555717777610655115510015d0006666666600000000
506dddd0000dd18090a040900ddbdbd00ddbdbd01ddbdbd003013300663138300031383000077000756556571777610065155551001d50006000000601111110
506dddd0000ddd11a00090a40666dddd1666dddd0666dddd00313830633313300633133000766700755555571776610051155551000d15006000000605555550
5006ddd000ddddd10405a00900d5dd0000d5dd0000d5dd00003313303331301363313013005665007555555717667610655115110001d5006000000605555550
00021111002d6dd00905004a005111000052110000521100033130131110000011100000000550007565565716116761655551510001d0006000000605155150
000200010222166d0a5000900520001005002000052201001110000010000000100000000000000075555557010016716555515100105d006000000605111150
0002000020011006dd1110a05020000050010000500001001000000000000000000000000000000077777777000001105111111500150d000000000005111150
b3b00b3b0bbbbbb00000000000000900aaaaaaaaaaaaaaaa994499444444444499999999555555555555555566666666666d6666dd5555ddcccccccc00088000
b039930bbbb33bbb0000000000009a90aaa999aaaaaa99aa944494444444444499444499555d55ddd55dd55d6d6666d66dd666d6d566665dcccccccc00800800
00999200b33bb33b0000000000000900aaaaaa9aaaaaaa9a444444444444444444444444dddddddddddddddd6666666666dd6d6656666665cccccccc08099080
00944200b393323b0000090000e00b00aa9aaa9a99aaaaaa1414141499449944991111995d55d555dd555d55666666666d66666656666665cccccccc80900908
009992000099920000909a900eae0300a9aaa9aaaa9aaaaa414141419444944494111149dddddddddddddddd6666666666666dd656666665cccccccc80900908
099999200444992009a9090000e00300a9aaaaaaaaaaa9aa11111111444444449911119955dd5d55d555d55d666666666666d6665d6666d5cccccccc08099080
044499200999992000900b0000b00300aa99aaaaaa999aaa000000004444444444111144dddddddddddddddd6d6666d66dd666ddd5dddd5d1cc11cc100800800
029992200299922000b0030000300300aaaaaaaaaaaaaaaa000000004444444499111199555555555555555566666666d666666ddd5555dd1111111100088000
00000000002222200777000000044000000aa000007000000777700000bbbbbbbbbbbbbbbbbbbb002222222222222222000000000000000000000bbb00990000
2222222202944442067770000049940000a7aa0000700000070070000b333b333b333b3333b333b042244224422442240000000000000000000b3b3b00049000
44444444029999420677770000444200007aa90000700000070070000b34333433343334433343b04444444444444444000000000000000000bbb3bb09094090
44444444022222220677777000494200007aa9007770000077077000b3444444444444444444443b44444444444444220b00000000000000003b3b3094994949
222222220294949206777700004992000a7aaa907770000077077000b3344444444444444444433b4444444444444422b0b0bb00000000000bb3bbb099494490
222222220294949206777000004942000aaa99900000000000000000bb34444444444444444443bb444444444222444400b0b0b0000000000b3b3b0009949900
2442442402949492066600000049920000666d000000000000000000b3344224422442244224433b4224422442224224000b0000077707703bbb000000949000
22422424002222200000000000042200000000000000000000000000b3222222222222222222223b2222222222222222000b0000777777773300000000040000
00aaa900000ee0000000000000800000008000000000000000000000008008000000000000808000000000000fffff000fffff000fffff00002ee20000000000
00666d000eeaaee0000ee0000877000008770000008000000007000000088000000000000008800000000800f44444f0f44444f0f44444f002222220002ee200
067176d00eeaaee00eeaaee0a7170007a7170f0708770007000770700088e800080880800088e80008088000f4fff4f0f4fff4f0f4fff4f0047ff74002222220
6771766db0beeb0b0eeaaee0087777770877ff77a71777770004007708888e800088e80008888e800088e800f4f4f4f0f4f4f4f0f4f4f4f0471ff17404ffff40
6771116db3bbbb3b0bbeebb0077fff77077fff77087fff77009994400818818008888e800818888008888e80f4f444f0f4f444f0f4f444f00ffffff0471ff174
6777766d3bb1b1bb33bb1b1b077ff7700777f770077ff7700949994002888e8001888e100288888001888e80f4ff22f0f4ff1e10f4fff1e1002222000ffffff0
067766d03bbbbbbb33bbbbbb0077770000a7770000777a00099494400288888002888880022288800222888044422220444feee0444feeee00eeee0000eeee00
00666d000333333003333330000a0a0000000a00000a000009944400002228000022280000222200002222000422220004eeeee004eeeeee0040040000400400
0002ee20002ee200002ee2000000000000000000002ee2000022ee00000000000022ee000022ee000022ee00022ee00000000000002222000000000002222000
002222220222222002222220002ee2000000000002222220022222200022ee00022222200222222002222220222222000022ee00022222200022220022222200
0447ff74047ff760014ff4100222222000000000071ff170044447f002222220044447f0044447f0044447604441ff0002222220044444400222222044444440
0471ff17471ff1644f1ff1f401ffff1000000000477ff774044f71f004444ff0044f71f0044f71f0044f716044ff1d0004441ff04f4444f404444440f4444f40
00ffffff0ffffd6d0fffffd04f1ff1f4002ee2000ffffff000fffff0044f71f000fffff000fffff000fffd6d0ff4d666044ff1f00ffffff04f4444f4ffffff00
00222200002222d000222d6d0ffffff002222220002222000022220000fffff00022220000222200002222d002222d0000fffff0002222000ffffff000222200
00eee40000eeee4000eeee6000eeee00011ff11000eeee0000eeee0000eeee0000eee400004eee0000eeee400eeee00000eeee0000eeee0000eeee0004eeee00
004000000040040000400460004004004ffffff40040040000400400004004000040000000000400004004000400400000400400004004000040040000000400
__label__
dddddddddddddddddmddddddddddddddddddddddddddddddddddddddmdddddddddddmddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddmdddmdddddddmddmdddddddddddddddddddddddddd
ddmmddddddddddddddddddddddddmdddmdddddddddddddddddddddmmddmmdddddddddmmdddddddddddddddddddddddddddddddddddddddddddddddddddddddmm
ddddddddddddddddddddddddddddddddddddddddddddddddddmdddmdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddmddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
ddddddddddddddddddddddddddddddddddddddddddddddddddddddddmdddddddmdddddddddddddddddddmddmddddddmmddddddddddddddmdddddmmmddddddddd
ddmddddmdddmdddddddddddddddddddddddddddddddddddddddddmddddddddddddddddddddmdddmmdddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddmddddddddddddddddddddddmdddddddddddddddddddddddddddddddddddddddddmddddddddddddddddddddd
dddddddddddddddddmdddmddddddddddddddddddddddddddddddddddddddddddddddmddddddddddddmmddmmddddddmmdmddddddddddddddddddddddddddddddd
ddddddddddddddddddddddddddddddddddddddddmddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddmdddddddddddddddmmd
mdddmdddddddddddddddddddddddddddmddddddddddddddddddddddddddddddddddddmdddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddmdddddddddddddddddddddmddddddddddddddddddd
dmmddmmddmmdmddddddddddddmdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddmddddddddddddmddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
ddddddddddddddddddddddddddddddddddddddddddddddddddddddmdmdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddmmdddddddd
dddmdmdmddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddmddmddddddddmddddddddddddddddddddddddddddd
ddmddddddddddddddddddddddddddddddddddddmddddddddddddddddddddddddddmdddddddddddddddddddddddddddddddddddmdddddddddddddddddddddddmd
dddmdmdddddddmdmddddddddddddddmdddmdddddddddddddddddddddddddddddddddmdddddddddddddddddddddddmdddddddddddddddmddddddddddddddddddd
ddddddddddddmdddmdddddddddddmdmdmdmddddddddddmdddddddddddddmddddddmdddddddddmdddmdddddddmdmddddddddddddddddddddddddddddddddddddd
ddddmddddddddddddddddddddddddddddddddddddddddmddddddddddddmdddddddddddddddddmdddddddddddddddddddddmdddddddddddddddddddddddmddddd
ddddddddddddddddddmdmdmdmdmdmdmdmdmddmddmdmddddddddddmdddddddddddddddddddddddddddddddddddddddddddddddmdddddddddddddddddddddddddd
mdddmdddmddddddddddddddddddddddddddddddddddddmdddddddddddddddddddddddddddddddddddddddddddddddddddddmddmmdddmdmdddddddddddddddddd
ddddddddddddddddddmdddddddmdddddddddddddddddmdddddddddddddddmdmdmdddmdddddddddddddddddmdddddddmdddddddddddddmddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddmdddmdddmddddddddddddddmdddmddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddmdddddddmdd
ddddddddddddddddddddddddmdddmdddddddddddmddddmddddmddmdddmdddmddddddddddmdddddddddddddddmdddmdddmdddddddmddddddddmdddddddddddddd
mdddddddddddddddddddddddddddddddddddddddddddmddddddddddddddddddddddddddddddddddddddddddddmdddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
ddddddddddddddddmmdmdmdddmdddmddddmddmddddmdmmddmdmmdmdmdmdmdmmdddmddddddmdddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd

