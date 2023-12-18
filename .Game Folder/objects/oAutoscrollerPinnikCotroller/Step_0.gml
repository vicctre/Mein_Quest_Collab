
if !already_triggered and place_meeting(x, y, oAutoscrollerLog) {
	// player reached this controller for the first time
	if global.autoscroller_last_pinnik_controller != id {
		trigger_pinniks_to_fall()
		global.autoscroller_last_pinnik_controller = id
	} else {
		// has reached before, log already shortened
		deactivate_pinniks()
	}
	already_triggered = true
}
