cartdata("frozax_thermometers")

-- 0-based
function set_level_completed(i)
    dset(i, 1)
end

-- 0-based
function is_level_completed(i)
    return dget(i) == 1
end

function set_show_hint(show_hint)
    if show_hint then
        v = 1
    else
        v = 0
    end
    dset(31, v)
end

function get_show_hint()
    return dget(31) == 1
end

