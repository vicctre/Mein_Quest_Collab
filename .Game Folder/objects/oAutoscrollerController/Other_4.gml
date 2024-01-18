
// start from the last falling pinnik point
var len = array_length(global.autoscroller_reached_pinnik_controllers)
if len {
	var last = global.autoscroller_reached_pinnik_controllers[len - 1]
	oAutoscrollerLog.x = last.x
	oAutoscrollerLog.set_sprite_index(global.autoscroller_current_log_sprite_index)
	global.player.x  = last.x
}

// dev
if global.autoscroller_skip_log_intro {
	oAutoscrollerLog.x = max(x, oAutoscrollerLog.x)
	global.player.x = max(x, global.player.x)
	global.camera_solid_bounds_on = true
}
