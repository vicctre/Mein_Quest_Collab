
if is_sequence_finished() {
	oBossHpUI.ease_in()
	oRularog.visible = true
	oRularog.state = oRularog.idleState
	layer_sequence_speedscale(sequence, 0)
	global.player.has_control = true
	instance_destroy()
}
