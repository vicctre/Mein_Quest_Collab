
if layer_sequence_get_headpos(sequence_inst) == global.tufful_intro_landing_time {
	Screen_Shake(4, 30)
	audio_play_sound(global.sfx_boss_land, 0, false)
}

if is_sequence_finished() {
	oTuffull.visible = true
	oTuffull.boss_state = "Idle"
	layer_sequence_speedscale(sequence, 0)
	oPlayer.has_control = true
	instance_destroy()
}