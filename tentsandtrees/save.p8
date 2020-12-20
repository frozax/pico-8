cartdata("frozax_tentsandtrees")

-- 0-based
function set_level_completed(i)
    dset(i, 1)
end

-- 0-based
function is_level_completed(i)
    return dget(i) == 1
end