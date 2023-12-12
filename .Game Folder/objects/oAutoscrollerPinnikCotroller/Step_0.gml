
if place_meeting(x, y, oAutoscrollerLog) { // or place_meeting(x, y, oPlayer) {
	with oPinnikAutoscroller {
		if (x > oAutoscrollerLog.bbox_left) and (x < oAutoscrollerLog.bbox_right) {
			hsp = global.autoscroller_log_sp
			vsp = 3
		}
	}
}
