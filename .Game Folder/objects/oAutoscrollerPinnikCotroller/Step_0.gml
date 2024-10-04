
if !already_triggered and place_meeting(x, y, oAutoscrollerLog) {
	// player reached this controller for the first time
	// so set the checkpoint here
	var last_pinnik_cotroller = noone
	var len = array_length(global.autoscroller_reached_pinnik_controllers)
	if len {
		last_pinnik_cotroller = global.autoscroller_reached_pinnik_controllers[len - 1]	
	}
	if last_pinnik_cotroller != id {
		trigger_pinniks_to_fall()
		// this is used as a checkpoint location
		array_push(global.autoscroller_reached_pinnik_controllers, id)
		oUI.show_checkpoint_indicator()
	} else {
		// has reached before, log already shortened
		deactivate_pinniks()
	}
	already_triggered = true

    oAutoscrollerLog.SetShortedSpriteEarly()
}
