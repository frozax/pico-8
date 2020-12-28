function array_of_bool_to_array_of_bytes(bools)
    bytes = {}
    assert(#bools % 8 == 0, "must be modulo 8")
    for i=0,(#bools/8)-1 do
        byte = 0
        for b=0,7 do
            if bools[i*8+b+1] then
                byte += (1<<(7-b))
            end
        end
        add(bytes, byte)
    end
    assert (8*#bytes == #bools, "incoherent result"..#bytes.." "..#bools)
    return bytes
end

function array_of_bytes_to_array_of_bools(bytes)
    bools = {}
    for i=0,#bytes-1 do
        for b=7,0,-1 do
            if bytes[i+1] & (1<<b) == (1<<b) then
                add(bools, true)
            else
                add(bools, false)
            end
        end
    end
    assert (8*#bytes == #bools, "incoherent result"..#bytes.." "..#bools)
    return bools
end

-- test
-- printh(tostring(array_of_bool_to_array_of_bytes({
--     true,false,false,true,true,true,true,true,
--     false,false,false,false,false,true,true,false})))
-- printh(tostring(array_of_bytes_to_array_of_bools({159,6})))