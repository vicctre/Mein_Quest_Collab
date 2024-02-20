
// trigger showing stage name
var room_name = room_get_name(room);
if (string_pos("part1", room_name) != 0) {
	area_name_text_timer = area_name_text_timer_max;
}

// trigger showing checkpoint
if checkpoint_indicator.need_to_show() {
	checkpoint_indicator.start_animation()
}
