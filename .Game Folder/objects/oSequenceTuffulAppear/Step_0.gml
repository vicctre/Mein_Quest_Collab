
if is_sequence_on_frame(global.tufful_intro_landing_time) {
	Screen_Shake(4, 30)
	audio_play_sound(global.sfx_boss_land, 0, false)
}

if is_sequence_on_frame(frame_roar) {
	audio_play_sound(global.sfx_roar01, 0, false)
}

if is_sequence_finished() {
	oTuffull.visible = true
	oTuffull.boss_state = "Idle"
	layer_sequence_speedscale(sequence, 0)
	global.player.has_control = true
	instance_destroy()
}
