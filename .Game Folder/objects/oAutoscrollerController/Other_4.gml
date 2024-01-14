
global.camera_solid_bounds_on = true

// start from the last falling pinnik point
if global.autoscroller_last_pinnik_controller != undefined {
	oAutoscrollerLog.x = global.autoscroller_last_pinnik_controller.x
	oAutoscrollerLog.set_sprite_index(global.autoscroller_current_log_sprite_index)
	global.player.x  = global.autoscroller_last_pinnik_controller.x
}

// dev
if global.autoscroller_skip_log_intro {
	oAutoscrollerLog.x = max(x, oAutoscrollerLog.x)
	global.player.x = max(x, global.player.x)
}
