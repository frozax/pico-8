function hex_to_dec(hexstr,s,e)
 s=s or 1
 e=e or 0
 return tonum("0x"..sub(hexstr,s,s+e))
end
--------------------