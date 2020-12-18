function parse_table(str)
 local nextstr,nextindex,tbl,i="",{},{},1
 for i=1,#str do
  nc=sub(str,i,i)
  if nc=="_" or nc=="|" then
   if tonum(nextstr) then nextstr=tonum(nextstr) end
   add(nextindex, nextstr)
   nextstr=""
  else
   nextstr=nextstr..nc
  end
  if nc=="|" then
   add(tbl, nextindex)
   nextindex={}
  end
 end
 if #tbl==1 then return tbl[1] end
 return tbl
end
------------------