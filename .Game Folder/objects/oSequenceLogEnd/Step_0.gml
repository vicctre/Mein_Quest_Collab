
if is_sequence_on_frame(play_landing_sound_frame) {
	audio_play_sound(global.sfx_land, 7, false)
}

if is_sequence_finished() {
	layer_sequence_speedscale(sequence, 0)
	global.player.visible = true
	global.player.has_control = true
	global.player.x = x + player_rel_x_appear
	instance_destroy()
}
