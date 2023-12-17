
visible = false
already_triggered = false

function trigger_pinniks_to_fall() {
	with oPinnikAutoscroller {
		if (x > oAutoscrollerLog.bbox_left) and (x < oAutoscrollerLog.bbox_right) {
			hsp = global.autoscroller_log_sp
			vsp = 3
		}
	}
}

function deactivate_pinniks() {
	with oPinnikAutoscroller {
		if (x > oAutoscrollerLog.bbox_left) and (x < oAutoscrollerLog.bbox_right) {
			instance_deactivate_object(id)
		}
	}
}
