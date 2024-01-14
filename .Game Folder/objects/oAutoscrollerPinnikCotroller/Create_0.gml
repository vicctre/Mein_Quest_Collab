
sprite_index = noone
already_triggered = false
warning_sign_trigger_distance = 300
warning_sign_image_index = 0
warning_sign_image_speed = 0.25

if array_has(global.autoscroller_reached_pinnik_controllers, id) {
	already_triggered = true
}

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
