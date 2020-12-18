function initscene2()

 flip_to_mem()
 str_to_mem_call(0x1900,spr_scene2_text)

end

function initscene3()

 flip_to_mem() 

 for i=1,5 do
  add(flowerpix_set,false)
 end
 
 pix_speeds,lagcheck,f2=parse_table("0.007_0.0044|0.005_0.007|0.008_0.0065|0.0034_0.0073|0_0|"),true,0xfd40
 
end

function initscene4()

 picture_inited,flashimage,previmage,images,n=0,1,0,"",1

 cor_mand_prep=cocreate(mand_prep_next_frame)
 nextprepframe=0
 
end

function initscene5()

 n=2
 
 memset(0,0,8192)

end

 function create_material(values)
 
  local material={}
  for n=1,3,2 do
   add(material,{
                 diffuse=values[n][1],
                 ambient=values[n][2],
                 curve_patterns=generate_gradient(values[n+1],values[n][3]),
                 palette_index=values[n][3]
                })
  end
  return material
  
 end
 

function initscene6()

 mand_keyframes,circles,rots,objmat_pregen,objmat,rowspeed=nil,nil,parse_table("1_0_0.0053_0_1_y|1_0.1_-0.001_0_1_z|2_0.1_0.0032_0_1_y|2_-0.08_0.00066_0_1_x|3_0_0.01_0_1_y|3_0_0_0.5_1_z|3_0_0.005_0_1_x|4_0_0.0022_0_0.5_y|"),{parse_table("30_0_0|0_32_64_96|60_30_4|30_60_90|"),parse_table("70_20_0|0_32_64|120_0_4|10_20_50|"),parse_table("70_20_0|0_32_64|60_20_4|0_30_60|"),parse_table("70_20_0|0_32_64|60_20_4|0_30_60|")},{},parse_table(" -0.2884_0.6969_0.4778_-0.595_0.4045_-0.2127_0.589_-0.5385_0.6375_-0.2968_0.2665_0.3572_0.6459_0.4968_-0.2127_0.28_-0.2764_0.3624_0.5723_0.2206_-0.6498_-0.3071_-0.5496_-0.3689_0.5724_-0.5972_0.4967_-0.2355_-0.4511_-0.2286_-0.6888_0.5176_-0.3362_0.4665_0.3199_0.6883_0.3057_-0.6732_-0.4808_0.5877|")
 
 for i in all(objmat_pregen) do
  add(objmat,create_material(i))
 end
 
 str_to_mem_call(0x5f10,"8082058605060789848081018c8b8a00") 
 str_to_mem_call(4096,spr_objtexts)

end


function initscene7()

 palshift=0
 
 str_to_mem_call(3072,spr_bigfont) 
 
 gradtable=parse_table("0_44_24_84_2.3_3_0_0_40_200_44_156_40_94_-5.7_9_0_0_0_156|176_220_44_78_3.8_4.3_0_0_216_376_220_332_40_92_-3.6_7.5_0_0_176_332|352_396_74_106_3.9_2.3_0_0_392_552_396_508_84_106_-3.1_4.8_0_0_352_508|528_572_29_75_1.8_3.215_0_0_572_728_572_684_38_83_-6.1_9.8_0_0_528_684|")
 
 function cor_prerotate_belt()
  obj_belt_prerot={}
  for i=1,150 do
   obj_belt_prerot[i]=copy(obj_belt)
   translate(obj_belt_prerot[i],0,-1,0)
   rotate(obj_belt_prerot[i],0.25,"y")
   rotate(obj_belt_prerot[i],-i/150,"x")
  end
 end
 
 cor=cocreate(cor_prerotate_belt) 

end

function initscene8()
 
 textrefresh,textnum,texts,overlay_params,greets_prepped,material,laserpatterns,greetings_curvemods,anim2_prepped,palshift,roadpals,anim=0,1,parse_table("kamigoye|one winged_angel|destino|burning_hammer|"),parse_table("0_78_93_70|176_78_108_40|176_93_57_75|352_78_75_55|528_78_75_80|528_93_81_97|"),{},create_material(parse_table("328_-200_0|0_91_98_105|128_0_4|0_40_80|")),generate_gradient(parse_table("0_32_64_96|"),11),parse_table("0.002_0.005|0.003_0.003|0.001_0.0027|0.0022_0.0011|"),false,5,parse_table("7_7_7_8_8|11_8_8_9_9|"),create_anim(anim2)

 for i=1,8 do
  add(greets_prepped,false)
 end

 pal()

 fillp()
 
 for y=68,127 do

  offset,z2=11,1024/(y-64)
  if y>80 or y%2==0 then offset=7 end
  
  for x=0,128 do
   
   x2,colmod=z2-(x*z2/64),0

   if x2%14>7 then colmod=2 end
   color(flr((z2*0.7)%4+colmod)%4+offset)
   if abs(x2)>14 then color(15) end
   pset(x,y)
  end
 end

 memcpy(0x1100,0x7100,3840) 
 
 str_to_mem_call(0x5f10,"8082058605060789848081018c8b8a00")
 str_to_mem_call(2048,spr_tokyo..spr_heavyweight)

end

function initscene9()

 pal()
 
 palshift,gradtable=0,parse_table("0_44_24_104_6.3_3.4_0_0_40_200_44_156_25_90_-6.2_9.2_0_0_0_156|178_220_34_78_2.5_4.3_0_0_216_376_220_332_50_82_-5.1_6.2_0_0_176_332|352_396_77_93_1.9_4.3_0_0_392_225_396_508_42_100_-6.5_8.8_0_0_352_508|528_572_29_94_4.8_8.215_0_0_572_728_572_684_30_98_-3.5_4.3_0_0_528_684|")
 
 str_to_mem_call(3072,spr_bigfont)

end

function initscene10()

 memset(0,0,8192)

end

function initscene11()

 fillp()

end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------