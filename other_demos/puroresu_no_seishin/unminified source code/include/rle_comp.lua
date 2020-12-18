function rle_comp(str)
 local output=""
 for i=1,#str do
  if i==1 then
   chr=sub(str,1,1)
   length=1
  end
  if i>1 then
   if chr==sub(str,i,i) then
    length+=1
	if length==16 then
	 output=output.."f"..chr
	 length=1
	end
   end
   if chr!=sub(str,i,i) then
    output=output..sub(tostr(length, true), 6, 6)..chr
	chr=sub(str,i,i)
	length=1
   end
  end
 end
 output=output..sub(tostr(length, true), 6, 6)..chr
 printh(output, "@clip")
 return output
end
------------------------------