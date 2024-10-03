
if place_meeting(x, y, global.player) {
    with global.player {
        has_control = false
        hsp = 0
        hsp_to = 0
    }
} else {
	exit
}


if global.player.down_free {
    exit
}


if !is_playing() {
    oW2Wave.StartFromSecondWave()
	oCamera.set_point_target(camera_x, oCamera.y)
	oCamera.set_smooth_factor(0.02)
    global.player.BecomeInvisibleIn(3)
    unpause()
}

// override parent's code
if is_sequence_finished() {
	layer_sequence_speedscale(sequence_inst, 0)
	// don't reset sequence so the last frame
	// is not shown at the end
	// layer_sequence_headpos(sequence_inst, 0)
	if destroy_delay > 0 {
		alarm[0] = destroy_delay
	} else {
        with global.player {
            visible = true
            has_control = true
        }
        oCamera.set_target(global.player)
        instance_destroy()
	}
}

