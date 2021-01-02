MUT_INSERT = 1
MUT_DELETE = 2
MUT_SUBSTITUTE = 3
--MUT_INVERT = 2
NB_MUT_TYPES = 3
INV_MUT = {[MUT_INSERT]=MUT_DELETE, [MUT_DELETE]=MUT_INSERT, [MUT_SUBSTITUTE]=MUT_SUBSTITUTE}

function gen_level_precise(size, mutations)
    src_seq = {}
    dst_seq = {}
    for i=1,size do
        ACTG = flr(rnd(4))
        add(src_seq, ACTG)
        add(dst_seq, ACTG)
    end
    level = {}
    level.dst = dst_seq

    level.mut_count = {[MUT_INSERT]=0, [MUT_DELETE]=0, [MUT_SUBSTITUTE]=0}
    for m=1,mutations do
        mut_type = flr(rnd(nb_mut_types))
        mut_type = MUT_SUBSTITUTE
        -- only used for insert
        v = flr(rnd(4))
        i = flr(rnd(src_seq)) + 1
        mutate(src_seq, mut_type, i)
        level.mut_count[INV_MUT[mut_type]] += 1
    end
    level.src = src_seq

    printh(tostring(level))
    return level
end

function gen_level(diff)
    srand(0)
    return gen_level_precise(11, 4)
end

function mutate(seq, mut_type, i, v)
    printh("mutate"..tostring(seq).." with "..mut_type.." ".." at "..i.." with "..tostring(v)..".")
    if mut_type == MUT_SUBSTITUTE then
        local v = v
        while v == seq[i] or v == nil do
            v = flr(rnd(4))
        end
        seq[i] = v
    end
    printh("new seq:"..tostring(seq))
end