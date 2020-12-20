function rotate(object, q, axis)

 if #object==0 then
  rotate(object.verts_tri, q, axis)
  rotate(object.verts_normal, q, axis)
  return
 end
 
 sinr,cosr=sin(q),cos(q)
   
 for i in all(object) do
  i[1],i[2],i[3]=dot3d_rotate(i[1],i[2],i[3],sinr,cosr,axis)
 end

end
---------------------------------------------------------------------------