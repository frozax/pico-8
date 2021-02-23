-- mode 0: clockwise 90
-- mode 1: clockwise 270
-- mode 2: mirror + clockwise 90
-- mode 3: mirror + clockwise 270
-- dx,dy: screen position
-- w,h: sprite width and height (1 if not specified)

function rotate(sprite,mode,dx,dy,w,h)
 local sx=sprite%16*8
 local sy=flr(sprite/16)*8
 w,h=w or 1,h or 1
 w,h=w*8-1,h*8-1
 local ya,yb,xa,xb=0,1,0,1
 if mode==0 then
  ya,yb=h,-1
 elseif mode==1 then
  xa,xb=w,-1
 elseif mode==2 then
  ya,yb,xa,xb=h,-1,w,-1
 end
 for y=0,h do
  for x=0,w do
   pset((y-ya)*yb+dx,(x-xa)*xb+dy,sget(x+sx,y+sy))
  end
 end
end
