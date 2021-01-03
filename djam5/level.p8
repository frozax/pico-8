MUT_INSERT = 1
MUT_DELETE = 2
MUT_SUBSTITUTE = 3
--MUT_INVERT = 2
NB_MUT_TYPES = 3
INV_MUT = {[MUT_INSERT]=MUT_DELETE, [MUT_DELETE]=MUT_INSERT, [MUT_SUBSTITUTE]=MUT_SUBSTITUTE}
MAX_SEQUENCE_LENGTH = 12

function gen_level_precise(size, mutations, srnd)
    printh("gen_level"..size.." "..mutations.." "..tostring(srnd))
    local srnd = srnd or flr(rnd(2500))
    srand(srnd)
    level = {srand=srnd, dna_length=size, mutations=mutations}
::loop::
    src_seq = {}
    dst_seq = {}
    for i=1,size do
        ACTG = flr(rnd(4))
        add(src_seq, ACTG)
        add(dst_seq, ACTG)
    end
    level.dst = dst_seq

    -- list possible mutations
    poss_muts = {}
    for i=1,size do
        add(poss_muts, {type=MUT_INSERT, pos=i})
        add(poss_muts, {type=MUT_DELETE, pos=i})
        add(poss_muts, {type=MUT_SUBSTITUTE, pos=i})
    end
    -- insert at start
    add(poss_muts, {type=MUT_INSERT, pos=size+1})

    level.mut_count = {[MUT_INSERT]=0, [MUT_DELETE]=0, [MUT_SUBSTITUTE]=0}
    for m=1,mutations do
        while true do
            poss_mut = rnd(poss_muts)
            printh("poss_mut"..tostring(poss_mut).." "..tostring(#poss_muts))
            mut_type = poss_mut.type
            if mut_type == MUT_INSERT and #src_seq >= MAX_SEQUENCE_LENGTH then
                -- pass
            else
                break
            end
        end
        -- for insert or substitute
        i = poss_mut.pos
        mutate(src_seq, mut_type, i)
        level.mut_count[INV_MUT[mut_type]] += 1
        new_poss_muts = {}
        for pm in all(poss_muts) do
            if mut_type == MUT_SUBSTITUTE then
                if pm.type == MUT_SUBSTITUTE and pm.pos == i then
                    -- ignore same
                elseif pm.pos == i and pm.type == MUT_DELETE then
                    -- don't delete a substituted cell
                else
                    add(new_poss_muts, pm)
                end
            elseif mut_type == MUT_DELETE then
                if pm.pos == poss_mut.pos then
                    -- ignore
                elseif pm.pos < poss_mut.pos then
                    -- add it if it's not an inserting
                    add(new_poss_muts, pm)
                else
                    -- modify it
                    new_pm = {type=pm.type, pos=pm.pos-1}
                    -- add if not insertion
                    if new_pm.type == MUT_INSERT and new_pm.pos == poss_mut.pos then
                        -- ignored
                    else
                        add(new_poss_muts, new_pm)
                    end
                end
            elseif mut_type == MUT_INSERT then
                if pm.pos < poss_mut.pos then
                    -- add it if it's not an inserting
                    add(new_poss_muts, pm)
                else
                    -- modify it
                    new_pm = {type=pm.type, pos=pm.pos+1}
                    -- add if not deletion
                    if new_pm.type == MUT_DELETE and new_pm.pos == poss_mut.pos then
                        printh("Ignored this (in ins):"..tostring(new_pm))
                    else
                        add(new_poss_muts, new_pm)
                    end
                end
            end
        end
        poss_muts = new_poss_muts
        printh("NEW POSS MUTS AFTER DELETION: "..tostring(poss_muts))
    end
    level.src = src_seq
    if dna_str(level.src) == dna_str(level.dst) then
        goto loop
    end

    return level
end

function dna_str(_seq)
    _dna_str = ""
    for actg in all(_seq) do
        _dna_str..=names[actg]
    end
    return _dna_str
end

function mutate(seq, mut_type, i, v)
    printh("Mutate "..tostring(seq).." with "..mutation_names[mut_type].." at "..i.." with "..tostring(v))
    local v = v
    if v == nil then
        if mut_type == MUT_INSERT then
            v = flr(rnd(4))
        elseif mut_type == MUT_SUBSTITUTE then
            while v == seq[i] or v == nil do
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

    printh("new seq:"..dna_str(seq))
end