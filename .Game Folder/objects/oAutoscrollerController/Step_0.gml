
if oPause.paused
	exit

if instance_exists(oAutoscrollerLog) {
	if !intro_played { 
		if (oAutoscrollerLog.x >= x) {
			x = oAutoscrollerLog.x
			intro_played = true
			global.player.has_control = true
			global.camera_solid_bounds_on = true
		}
	} else {
		x += global.autoscroller_log_sp
		oAutoscrollerLog.x = x
        // win
		if !global.player.is_dead() and x > room_width {
			RoomTransition(TRANS_MODE.GOTO, W1_2_part5_AutoScroller2, true)
		}
	}

	CheckActivateEnemies()

	if oAutoscrollerLog.x > room_width - 100 {
		global.camera_solid_bounds_on = false	
	}
}