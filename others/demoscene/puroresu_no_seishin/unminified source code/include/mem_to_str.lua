function mem_to_str(start,len)
 output=""
 for i=start,start+len-1 do
  output=output..sub(tostr(peek(i),true),5,6)
 end
 return output
end
----------