
if is_sequence_finished() {
	oBossHpUI.ease_in()
	oRularog.visible = true
	oRularog.state = oRularog.idleState
	oRularog.x = x
	layer_sequence_speedscale(sequence_inst, 0)
	global.player.has_control = true
	instance_destroy()
}

if DEV and oInput.key_attack and layer_sequence_get_speedscale(sequence_inst) != 0 {
	layer_sequence_speedscale(sequence_inst, 10)
}
