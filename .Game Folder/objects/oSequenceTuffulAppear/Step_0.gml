
if is_transition_finished() {
	oTuffull.visible = true
	oTuffull.boss_state = "Idle"
	layer_sequence_speedscale(sequence, 0)
	instance_destroy()
}
