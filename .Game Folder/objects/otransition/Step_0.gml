/// progressing the transition 


if is_on {
    var to = is_forward
    var treshold = 0.02
    if trans_type == TRANS_TYPE.SLIDE {
        to *= transition_overlap
        if is_forward {
            percent = min(transition_overlap, percent + max(((transition_overlap - percent)/10),0.005))
        } else {
            percent = max(0, percent - max((percent/10), 0.005))
        }
    // FADE
    } else {
        percent = approach(percent, to, treshold)
    }

	if abs(percent - to) <= treshold {
		if transition_delay {
			transition_delay--
			exit
		}
        if !is_forward {
            is_on = false
			exit
        } else {
			is_forward = false
		}
		switch (mode) {
			case TRANS_MODE.NEXT:
				room_goto_next() 
            break
			case TRANS_MODE.GOTO: 
				room_goto(target) 
				break
			case TRANS_MODE.RESTART:
				room_restart()
				level_reset_globals()
				percent = 1
			break
		}
	}
}
