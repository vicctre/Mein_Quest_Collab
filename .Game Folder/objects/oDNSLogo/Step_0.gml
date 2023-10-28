
event_inherited()

if keyboard_check_pressed(vk_enter) 
		or keyboard_check_pressed(ord("X")) {
	global.logo_sequence_speed_scale = 3
	layer_sequence_speedscale(sequence_inst, global.logo_sequence_speed_scale)
}
