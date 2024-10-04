
mouse_moved = mouse_x_prev != mouse_x or mouse_y_prev != mouse_y

if mouse_moved {
	mouse_movement_time++
} else {
	mouse_movement_time = 0
}

mouse_x_prev = mouse_x
mouse_y_prev = mouse_y

if mouse_movement_time > 1 {
	mouse_inactive_timer.reset()
	window_set_cursor(cr_default)
}

if !mouse_inactive_timer.update() {
	window_set_cursor(cr_none)
	if !mouse_moved {
		mouse_movement_time = 0	
	}
}
