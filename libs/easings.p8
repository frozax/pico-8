-- create ease urve from 0 to 0 going to 1 with ease function
function ease(zero_duration, ease_to_1, ease_to_1_duration, one_duration, ease_to_0, ease_to_0_duration, zero_duration_end)
    total_duration = zero_duration + ease_to_1_duration + one_duration + ease_to_0_duration + zero_duration_end
    ti = time() % total_duration
    --printh(ti)
    if ti < zero_duration then
        return 0
    end
    ti -= zero_duration
    if ti < ease_to_1_duration then
        tt = ti / ease_to_1_duration
        return ease_to_1(tt, 0, 1, 1)
    end
    ti -= ease_to_1_duration
    if ti < one_duration then
        return 1
    end
    ti -= one_duration
    if ti < ease_to_0_duration then
        tt = 1 - ti/ease_to_0_duration
        return ease_to_0(tt, 0, 1, 1)
    end
    ti -= ease_to_0_duration
    if ti < zero_duration_end then
        return 0
    end
end

-- tweening & easing functions
-- by matt sephton

-- http://robertpenner.com/easing/penner_chapter7_tweening.pdf
-- http://gizma.com/easing/
-- https://github.com/kikito/tween.lua/blob/master/tween.lua
-- http://forum.multitheftauto.com/viewtopic.php?f=108&t=75895

function pow(a,b)
  return a ^ b
end

-- order of steepness
-- linear, sine, quad, cubic, quartic, quintic, expo, circ

function linear(t,b,c,d)  -- simple linear tweening - no easing, no acceleration
  return c*t/d + b
end


function ease_in_quad(t,b,c,d)  -- quadratic easing in - accelerating from zero velocity
  t /= d
  return c*t*t + b
end

function ease_out_quad(t,b,c,d)  -- quadratic easing out - decelerating to zero velocity
  t /= d
  return -c * t*(t-2) + b
end

function ease_in_out_quad(t,b,c,d)  -- quadratic easing in/out - acceleration until halfway, then deceleration
  t /= d/2
  if (t < 1) return c/2*t*t + b
  t -= 1
  return -c/2 * (t*(t-2) - 1) + b
end


function ease_in_cubic(t,b,c,d)  -- cubic easing in - accelerating from zero velocity
  t /= d
  return c*t*t*t + b
end

function ease_out_cubic(t,b,c,d)  -- cubic easing out - decelerating to zero velocity
  t /= d
  t -= 1
  return c*(t*t*t + 1) + b
end

function ease_in_out_cubic(t,b,c,d)  -- cubic easing in/out - acceleration until halfway, then deceleration
  t /= d/2
  if (t < 1) return c/2*t*t*t + b
  t -= 2
  return c/2*(t*t*t + 2) + b
end


function ease_in_quartic(t,b,c,d) -- quartic easing in - accelerating from zero velocity
  t /= d
  return c*t*t*t*t + b
end

function ease_out_quartic(t,b,c,d) -- quartic easing out - decelerating to zero velocity
  t /= d
  t -= 1
  return -c * (t*t*t*t - 1) + b
end

function ease_in_out_quartic(t,b,c,d) -- quartic easing in/out - acceleration until halfway, then deceleration
  t /= d/2
  if (t < 1) return c/2*t*t*t*t + b
  t -= 2
  return -c/2 * (t*t*t*t - 2) + b
end


function ease_in_quintic(t,b,c,d) -- quintic easing in - accelerating from zero velocity
  t /= d
  return c*t*t*t*t*t + b
end

function ease_out_quintic(t,b,c,d) -- quintic easing out - decelerating to zero velocity
  t /= d
  t -= 1
  return c*(t*t*t*t*t + 1) + b
end

function ease_in_out_quintic(t,b,c,d) -- quintic easing in/out - acceleration until halfway, then deceleration
  t /= d/2
  if (t < 1) return c/2*t*t*t*t*t + b
  t -= 2
  return c/2*(t*t*t*t*t + 2) + b
end

-- add frozax
function ease_in_back(t,b,c,d)
    c1 = 1.70158;
    c3 = c1 + 1;

    return c3 * t * t * t - c1 * t * t;
end
function ease_in_out_back(t,b,c,d)
    c1 = 1.70158;
    c2 = c1 * 1.525;

    if t < 0.5 then
        return (pow(2 * t, 2) * ((c2 + 1) * 2 * t - c2)) / 2
    else
        return (pow(2 * t - 2, 2) * ((c2 + 1) * (t * 2 - 2) + c2) + 2) / 2;
    end
end
function ease_out_back(t,b,c,d)
    c1 = 1.70158;
    c3 = c1 + 1;

    return 1 + c3 * pow(t - 1, 3) + c1 * pow(t - 1, 2);
end


--TO FIX
function ease_in_sine(t,b,c,d) -- sinusoidal easing in - accelerating from zero velocity
  return c * (1 - cos(t/d/4)) + b
end

function ease_out_sine(t,b,c,d) -- sinusoidal easing out - decelerating to zero velocity
  return c * -sin(t/d/4) + b
end

function ease_in_out_sine(t,b,c,d) -- sinusoidal easing in/out - accelerating until halfway, then decelerating
  return c/2 * (1 - cos(t/d/2)) + b
end


--TO FIX
function ease_in_expo(t,b,c,d) -- exponential easing in - accelerating from zero velocity
  return c * pow(2, 10 * (t/d - 1)) + b
end

--requires higher precision
function ease_out_expo(t,b,c,d) -- exponential easing out - decelerating to zero velocity
  return c * (-pow(2, -10 * t/d) + 1) + b
end

--requires higher precision
function ease_in_out_expo(t,b,c,d) -- exponential easing in/out - accelerating until halfway, then decelerating
  t = t/(d/2)
  if t<1 then
    return c/2*2^(10*(t-1))+b
  end
  t = t-1
  return c/2*(-2^(-10*t)+2)+b
end
