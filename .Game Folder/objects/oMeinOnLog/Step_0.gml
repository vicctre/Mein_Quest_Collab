
if oPause.paused
	exit

key_left_pressed = oInput.key_left_pressed * has_control
key_right_pressed = oInput.key_right_pressed * has_control
key_up_pressed = oInput.key_up_pressed * has_control
key_left = oInput.key_left * has_control
key_right = oInput.key_right * has_control
key_down = oInput.key_down * has_control
key_jump = oInput.key_jump * has_control
key_attack = oInput.key_attack * has_control

down_free = place_empty(x, y + 1, wall_obj) and (y < bottom_bound_y)
up_free = place_empty(x, y - 1, wall_obj)
left_free = place_empty(x - 1, y, wall_obj)
right_free = place_empty(x + 1, y, wall_obj)

vsp += grav * down_free

if !down_free {
	sprite_index = sMeinLogRideJump
	if key_jump {
		vsp = jump_sp
	}
} else {
	sprite_index = sMeinLogRide
}

y = min(y, bottom_bound_y)

scr_move_coord_contact_obj(hsp, vsp, wall_obj)

if x > room_width {
	SlideTransition(TRANS_MODE.NEXT)
}
