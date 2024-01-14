
if !already_triggered and place_meeting(x, y, oAutoscrollerLog) {
	// player reached this controller for the first time
	// so set the checkpoint here
	if global.autoscroller_last_pinnik_controller != id {
		trigger_pinniks_to_fall()
		// this is used as a checkpoint location
		global.autoscroller_last_pinnik_controller = id
		oUI.show_checkpoint_indicator()
	} else {
		// has reached before, log already shortened
		deactivate_pinniks()
	}
	already_triggered = true
}
