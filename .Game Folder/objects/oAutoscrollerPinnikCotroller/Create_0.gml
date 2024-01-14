
visible = false
already_triggered = false
warning_sign_trigger_distance = 300
warning_sign_image_index = 0
warning_sign_image_speed = 0.25

function trigger_pinniks_to_fall() {
	with oPinnikAutoscroller {
		if (x > oAutoscrollerLog.bbox_left) and (x < oAutoscrollerLog.bbox_right) {
			trigger()
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
