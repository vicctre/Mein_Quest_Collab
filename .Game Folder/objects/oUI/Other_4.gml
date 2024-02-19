
// trigger showing stage name
var room_name = room_get_name(room);
if (string_pos("part1", room_name) != 0) {
	area_name_text_timer = area_name_text_timer_max;
}

// trigger showing checkpoint
if checkpoint_indicator.need_to_show() {
	checkpoint_indicator.start_animation()
}

// get stage adv logs for drawing
stage_logs = oStageManager.GetStageData(room).adv_logs
stage_logs_num = array_length(stage_logs)
