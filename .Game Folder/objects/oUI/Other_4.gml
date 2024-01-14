var room_name = room_get_name(room);
if (string_pos("part1", room_name) != 0) {
	area_name_text_timer = area_name_text_timer_max;
}

switch(string_copy(room_name, 1, 4)) {
	case "W1_1":
		global.current_logs = global.Logs_Collected[0];
	break;
	case "W1_2":
		global.current_logs = global.Logs_Collected[1];
	break;
}

if room != W1_1_part1 {
	checkpoint_indicator.start_animation()
}
