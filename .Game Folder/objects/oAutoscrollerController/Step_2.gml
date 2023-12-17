
if oPause.paused
	exit

if instance_exists(oAutoscrollerLog) {
	if !intro_played {
		if (oAutoscrollerLog.x >= x) {
			x = oAutoscrollerLog.x
			intro_played = true
			oPlayer.has_control = true
		}
	} else {
		x = oAutoscrollerLog.x
		if !oPlayer.is_dead() and x > room_width {
			SlideTransition(TRANS_MODE.GOTO, W1_2_part5_AutoScroller2)
		}
	}

	CheckActivateEnemies()
}