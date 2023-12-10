
if !intro_played {
	oAutoscrollerLog.x += global.autoscroller_log_sp
	if oAutoscrollerLog.x >= x {
		x = oAutoscrollerLog.x
		intro_played = true
		oPlayer.has_control = true
	}
} else {
	x += global.autoscroller_log_sp
	oAutoscrollerLog.x = x
}
