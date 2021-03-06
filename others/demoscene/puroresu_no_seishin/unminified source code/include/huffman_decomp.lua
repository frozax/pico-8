function huffman_decomp(message)

 binary,nodes,decode,i="",{},"",2

 for k=1,#message do
  for j=3,0,0xffff do
   binary=binary..band(1, shr(hex_to_dec(message,k), j))
  end
 end
 
 function huffman_rebuild_tree(node)
  i+=1
  if sub(binary,i,i)=="0" then
   for j=1,2 do
	add(node,{})
	huffman_rebuild_tree(node[j])
   end
  else
   node.word=sub(tostr(tonum("0b"..sub(binary,i+1,i+8)), true), 5, 6)
   i+=8
  end
 end
 
 huffman_rebuild_tree(nodes)
 
 function huffman_recursion(node)
  if node.word then
   decode=decode..node.word
  else
   i+=1
   huffman_recursion(node[sub(binary,i,i)+1])
  end
 end
 
 while i<#binary-tonum("0b"..sub(binary,1,2)) do
  huffman_recursion(nodes)
 end
 
 return decode
 
end
--------------------------------------------------------