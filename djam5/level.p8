MUT_INSERT = 1
MUT_DELETE = 2
MUT_SUBSTITUTE = 3
--MUT_INVERT = 2
NB_MUT_TYPES = 3
INV_MUT = {[MUT_INSERT]=MUT_DELETE, [MUT_DELETE]=MUT_INSERT, [MUT_SUBSTITUTE]=MUT_SUBSTITUTE}
MAX_SEQUENCE_LENGTH = 12

function gen_level_precise(size, mutations, srnd)
    printh("gen_level"..size.." "..mutations.." "..tostring(srnd))
    local srnd = srnd or flr(time()*100)
    srand(srnd)
    level = {srand=srnd, dna_length=size, mutations=mutations}

    src_seq = {}
    dst_seq = {}
    for i=1,size do
        ACTG = flr(rnd(4))
        add(src_seq, ACTG)
        add(dst_seq, ACTG)
    end
    level.dst = dst_seq

    level.mut_count = {[MUT_INSERT]=0, [MUT_DELETE]=0, [MUT_SUBSTITUTE]=0}
    for m=1,mutations do
        while true do
            mut_type = flr(rnd(NB_MUT_TYPES)) + 1
            if mut_type == MUT_INSERT and #src_seq >= MAX_SEQUENCE_LENGTH then
                -- pass
            else
                break
            end
        end
        -- for insert or substitute
        i = flr(rnd(#src_seq)) + 1
        mutate(src_seq, mut_type, i)
        level.mut_count[INV_MUT[mut_type]] += 1
    end
    level.src = src_seq

    printh(tostring(level))
    return level
end

function mutate(seq, mut_type, i, v)
    printh("Mutate "..tostring(seq).." with "..mutation_names[mut_type].." at "..i.." with "..tostring(v))
    local v = v
    if v == nil then
        if mut_type == MUT_INSERT then
            v = flr(rnd(4))
        elseif mut_type == MUT_SUBSTITUTE then
            while v == seq[i] or v == nil do
                printh("GOT INTO RND!"..tostring(v))
                v = flr(rnd(4))
            end
        end
    end
    if mut_type == MUT_SUBSTITUTE then
        assert (i <= #seq, "invalid substitution")
        seq[i] = v
    elseif mut_type == MUT_DELETE then
        deli(seq, i)
    elseif mut_type == MUT_INSERT then
        add(seq, v, i)
    end
    printh("new seq:"..tostring(seq))
end