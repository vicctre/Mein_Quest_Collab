
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
		RoomTransition(TRANS_MODE.NEXT, noone, true)
	} else {
		instance_destroy()
	}
}

