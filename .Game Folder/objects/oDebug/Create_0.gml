
if !ensure_singleton() {
	exit
}

if global.dev_level_goto != noone {
	room_goto(global.dev_level_goto)
}

//if !global.gui_adjusted {
//	display_set_gui_size(window_get_width(), window_get_height())
//	gui_adjusted = false
//}