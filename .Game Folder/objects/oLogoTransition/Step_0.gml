
if !faded_in {
	alpha -= alpha_ratio
	if alpha < 0 {
		faded_in = true	
	}
} else {
	alpha += alpha_ratio
	if alpha > 1 {
		room_goto_next()	
	}
}
