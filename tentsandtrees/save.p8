cartdata("frozax_tentsandtrees")

function set_level_completed(i)
    dset(i, 1)
end

function is_level_completed(i)
    return dget(i) == 1
end