
if is_sequence_finished() {
	oBossHpUI.ease_in()
	oRularog.visible = true
	oRularog.state = oRularog.idleState
	oRularog.x = x
	if global.rula_start_state != undefined {
		oRularog.state = variable_instance_get(oRularog, global.rula_start_state)
	}
	layer_sequence_speedscale(sequence_inst, 0)
	global.player.has_control = true
	instance_destroy()
	oMusic.switch_music(global.msc_bigboss, true, 0)
}

if DEV and oInput.key_attack and layer_sequence_get_speedscale(sequence_inst) != 0 {
	layer_sequence_speedscale(sequence_inst, 10)
}
