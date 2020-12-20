function dot3d_rotate(x,y,z,sinq,cosq,axis)
 if axis=="x" then return x,y*cosq-z*sinq,y*sinq+z*cosq end
 if axis=="y" then return z*sinq+x*cosq,y,z*cosq-x*sinq end
 if axis=="z" then return x*cosq-y*sinq,x*sinq+y*cosq,z end
end
--