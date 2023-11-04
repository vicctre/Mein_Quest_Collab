
if goto_next_room_on and (keyboard_check_pressed(ord("X")) or gamepad_button_check_pressed(0, gp_face3)) {
	SlideTransition(TRANS_MODE.GOTO, next_room)
}
