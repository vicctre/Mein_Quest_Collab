
if !already_triggered
		and instance_exists(oAutoscrollerLog)
		and x - oAutoscrollerLog.bbox_right < warning_sign_trigger_distance {
	var w = sprite_get_width(oAutoscrollerLog.sprite_index) * 0.5 - 16
	var yy = oAutoscrollerLog.bbox_top - 60
	warning_sign_image_index += warning_sign_image_speed
	var xx = oAutoscrollerLog.x + w
	draw_sprite(sWarning, warning_sign_image_index, xx, yy)
	xx = oAutoscrollerLog.x - w
	draw_sprite(sWarning, warning_sign_image_index, xx, yy)
}
