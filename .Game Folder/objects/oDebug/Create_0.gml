
if !ensure_singleton() {
	exit
}

if global.dev_level_goto != noone {
	room_goto(global.dev_level_goto)
}

function delete_layer_sprite(element_name) {
	var el_id = layer_sprite_get_id("Assets", element_name)
	layer_sprite_destroy(el_id)
}

//if !global.gui_adjusted {
//	display_set_gui_size(window_get_width(), window_get_height())
//	gui_adjusted = false
//}