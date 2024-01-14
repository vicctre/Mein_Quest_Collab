
x += hsp * is_falling
y += vsp * is_falling

if !has_hit_log and place_meeting(x, y, oAutoscrollerLog) {
	oEffects.emit_log_break(x, oAutoscrollerLog.y)
	oAutoscrollerLog.TruncateByPinnik()
	has_hit_log = true
}

if y > (room_height + 100) {
	instance_destroy()
}
