


if DEV {
	if keyboard_check_pressed(ord("R")) {
		room_restart()
	}
	if keyboard_check_pressed(ord("F")) and keyboard_check(vk_control) {
		window_set_fullscreen(!window_get_fullscreen())
		display_set_gui_size(window_get_width(), window_get_height())
	}
	if keyboard_check_pressed(vk_f2)  {
		var tp = gamespeed_fps
		game_set_speed(game_get_speed(tp)==60 ? 5: 60, tp)
	}
}

if DEV and keyboard_check_pressed(ord("F")) and keyboard_check(vk_control) {
	window_set_fullscreen(!window_get_fullscreen())
	display_set_gui_size(window_get_width(), window_get_height())
}

if keyboard_check_pressed(ord("U")) {
	global.player.Kill()
}
