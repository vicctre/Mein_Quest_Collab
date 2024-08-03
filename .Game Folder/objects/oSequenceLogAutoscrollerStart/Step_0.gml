
if !is_playing() and place_meeting(x, y, global.player) {
	unpause()
	notify_started()
    with global.player {
        visible = false
        has_control = false
        hsp = 0
        hsp_to = 0
    }
}

if is_sequence_on_frame(camera_start_move_frame) {
	oCamera.set_point_target(x + camera_delta_x, oCamera.y)
	oCamera.set_smooth_factor(0.02)
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

