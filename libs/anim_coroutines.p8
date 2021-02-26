-- from discord user: Kevin
animations = {}

--function _init()
--  ball_anim = animate(16, 96, 30, easeinoutquad)
--end
--
--function _update()
--  update_animations()
--end
--
--function _draw()
--  cls()
--  circfill(64, ball_anim.value, 7, 7)
--end

function update_animations()
  printh(tostring(animations))
  for animation in all(animations) do
    if costatus(animation.coroutine) != 'dead' then
      coresume(animation.coroutine)
    else
      printh("del anim")
      del(animations, animation)
    end
  end
end


function animate(from, to, frames, ease)
  printh("animate"..from..to..frames)
  frames = frames or 30
  ease = ease or linear
  
  local animation = {
    coroutine = cocreate(function(from, to, frames, ease, animation)
      for frame=1,frames do
        printh("totoo"..frame)
        animation.value = ease(frame/frames, from, to-from, 1)
        yield()
      end
    end)
  }

  add(animations, animation)
  coresume(animation.coroutine, from, to, frames, ease, animation)
  
  return animation
end