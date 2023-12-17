
// start from the last falling pinnik point
if global.autoscroller_last_pinnik_controller != undefined {
	oAutoscrollerLog.x = global.autoscroller_last_pinnik_controller.x
	oAutoscrollerLog.sprite_index = global.autoscroller_current_log_sprite
	oPlayer.x  = global.autoscroller_last_pinnik_controller.x
}
