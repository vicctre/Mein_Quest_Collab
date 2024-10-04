
var mx = display_mouse_get_x()
var my = display_mouse_get_x()

mouse_moved = mouse_x_prev != mx or mouse_y_prev != my

mouse_x_prev = mx
mouse_y_prev = my

if mouse_moved {
	mouse_inactive_timer.reset()
	window_set_cursor(cr_default)
}

if !mouse_inactive_timer.update() {
	window_set_cursor(cr_none)
}
