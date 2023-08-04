
if is_sequence_finished() {
	oTuffull.visible = true
	oTuffull.boss_state = "Idle"
	layer_sequence_speedscale(sequence, 0)
	oPlayer.has_control = true
	instance_destroy()
}
