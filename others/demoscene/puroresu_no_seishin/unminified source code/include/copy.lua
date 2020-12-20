function copy(object)
 local cpy={verts_normal={},verts_tri={}}
 function vertcopy(copyverts,origverts)
  for i in all(origverts) do
   add(copyverts,{i[1],i[2],i[3]})
  end
 end
 vertcopy(cpy.verts_tri,object.verts_tri)
 vertcopy(cpy.verts_normal,object.verts_normal)
 
 cpy.tris,cpy.mats,cpy.layers=object.tris,object.mats,object.layers

 return cpy
end
----------------------------------------------