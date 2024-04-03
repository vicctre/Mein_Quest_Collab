
if !is_playing() and place_meeting(x, y, global.player) {
	unpause()
	notify_started()
	global.player.visible = false
	global.player.has_control = false
}

// override parent's code
if is_sequence_finished() {
	layer_sequence_speedscale(sequence_inst, 0)
	// don't reset sequence so the last frame
	// is not shown at the end
	// layer_sequence_headpos(sequence_inst, 0)
	if destroy_delay > 0 {
		alarm[0] = destroy_delay
		SlideTransition(TRANS_MODE.NEXT, noone, true)
	} else {
		instance_destroy()
	}
}

