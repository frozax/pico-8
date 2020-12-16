-- bm
-- by Billiam

bm={
  marks={},
  temp={},
  colors = {13,7,10,9,8},
  open=0,
  on=t
}
setmetatable(bm, {
  __call=function(t,label)
    if(not t.on)return
    if label then
      t.open+=1
      t.temp[t.open]={label, stat(1), stat(2)}
    else
      local tot2, sys2 = stat(1), stat(2)
      local temp = t.temp[t.open]
      if(not temp)return
      local label,tot,sys=unpack(temp)

      local old_t=t.marks[label]
      local total = tot2-tot
      if old_t then
        old_t.c+=1
        old_t.a=old_t.a+(total-old_t.a)/old_t.c
      else
        t.marks[label]={label=label, total=total, sys=sys2-sys,c=1,a=total}
      end
      t.temp[t.open]=nil
      t.open-=1
    end
  end
})

function bm:toggle()
  self.on=not self.on
end

function bm:draw()
  if(not self.on)return
  local y=8
  local cyc=1398
  for k,m in pairs(self.marks) do
    local col = self.colors[flr(m.total*20)+1] or 8
    local t =  flr((m.c>1 and m.a*m.c or m.total)*cyc)
    local avg = m.c>1 and "(" .. flr(m.a*cyc) .."a/".. m.c ..") " or ""
    local sys = flr(m.sys*cyc)
    local mes=m.label ..": ".. t .."t " .. avg .. sys .."s"
    rectfill(1,y-1,#mes*4,y+5,0)
    print(mes, 1,y,col)
    y+=8
  end
end

function bm:reset()
  if(not self.on)return
  self.marks={}
  self.open=0
  self.temp={}
end