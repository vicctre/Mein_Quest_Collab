
x += hsp * is_falling
y += vsp * is_falling

if !has_hit_log and place_meeting(x, y, oAutoscrollerLog) {
	oAutoscrollerLog.TruncateByPinnik()
	// after truncate the other pinnik won't hit the log
	// and won't spawn particle effect itself
	// so we do it here
	// (it will cause some extra particle spawns, but whatever)
	with oPinnikAutoscroller {
		oEffects.emit_log_break(x, oAutoscrollerLog.y)
	}
	has_hit_log = true
}

if y > (room_height + 100) {
	instance_destroy()
}
