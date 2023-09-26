
if is_sequence_finished() {
	oPlayer.visible = true
	oPlayer.has_control = true
	oCamera.cam_zoom_target = 1;
	layer_sequence_speedscale(sequence, 0)
	instance_destroy()
}
