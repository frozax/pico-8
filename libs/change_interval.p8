function change_interval(v, start_old, end_old, start_new, end_new, can_go_out_of_limits)
	if not can_go_out_of_limits then
		if v < start_old then
			return start_new
        end
		if v > end_old then
			return end_new
        end
    end
	return (v - start_old) * (end_new - start_new) / (end_old - start_old) + start_new
end

