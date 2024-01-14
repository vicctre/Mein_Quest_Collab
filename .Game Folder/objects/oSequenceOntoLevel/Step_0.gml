if is_sequence_finished() {
	oMein.visible = true
	oMein.has_control = true
	oCamera.cam_zoom_target = 1;
	layer_sequence_speedscale(sequence, 0)
	instance_destroy()
}
