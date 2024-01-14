if is_sequence_finished() {
	global.player.visible = true
	global.player.has_control = true
	oCamera.cam_zoom_target = 1;
	layer_sequence_speedscale(sequence, 0)
	instance_destroy()
}
