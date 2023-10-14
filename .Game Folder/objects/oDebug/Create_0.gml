
if !ensure_singleton() {
	exit
}

function delete_layer_sprite(element_name) {
	var el_id = layer_sprite_get_id("Assets", element_name)
	layer_sprite_destroy(el_id)
}


if room == rmGuiWorkaround {
	alarm[0] = 30
	exit
}

if global.dev_level_goto != noone {
	room_goto(global.dev_level_goto)
}
if !global.gui_workaround_restart_happened {
	global.gui_workaround_restart_happened = true
	room_restart()
}

//if !global.gui_adjusted {
//	display_set_gui_size(window_get_width(), window_get_height())
//	gui_adjusted = false
//}