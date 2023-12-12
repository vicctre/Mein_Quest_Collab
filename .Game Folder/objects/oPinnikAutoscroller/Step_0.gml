
x += hsp
y += vsp

if !has_hit_log and place_meeting(x, y, oAutoscrollerLog) {
	oAutoscrollerLog.TruncateByPinnik()
	oEffects.emit_log_break(x, oAutoscrollerLog.y)
	has_hit_log = true
}

if y > (room_height + 100) {
	instance_destroy()
}
