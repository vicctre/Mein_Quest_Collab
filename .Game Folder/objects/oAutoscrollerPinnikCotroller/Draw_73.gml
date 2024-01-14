
//if instance_exists(oAutoscrollerLog) {
//	var test = true;
//	show_debug_message("oAutoscrollerLog")
//}
//if x - oAutoscrollerLog.bbox_right < warning_sign_trigger_distance {
//	var test = true
//	show_debug_message("in range")
//}


if !already_triggered
		and instance_exists(oAutoscrollerLog)
		and x - oAutoscrollerLog.bbox_right < warning_sign_trigger_distance {
	var w = 32
	var yy = oAutoscrollerLog.bbox_top - 60
	warning_sign_image_index += warning_sign_image_speed
	var xx = oAutoscrollerLog.bbox_left + w
	draw_sprite(sWarning, warning_sign_image_index, xx, yy)
	xx = oAutoscrollerLog.bbox_right - w
	draw_sprite(sWarning, warning_sign_image_index, xx, yy)
}
