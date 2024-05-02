
if is_sequence_finished() {
	oBossHpUI.ease_in()
	oRularog.visible = true
	oRularog.state = oRularog.idleState
	oRularog.x = x
	layer_sequence_speedscale(sequence, 0)
	global.player.has_control = true
	instance_destroy()
}

if DEV and oInput.key_attack {
	layer_sequence_speedscale(sequence_inst, 10)
}
