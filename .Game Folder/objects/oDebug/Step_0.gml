
if DEV and keyboard_check_pressed(ord("R")) {
	room_restart()
}

if DEV and keyboard_check_pressed(ord("F")) and keyboard_check(vk_control) {
	window_set_fullscreen(!window_get_fullscreen())
	display_set_gui_size(window_get_width(), window_get_height())
}

if keyboard_check_pressed(ord("U")) {
	oMein.Kill()
}
