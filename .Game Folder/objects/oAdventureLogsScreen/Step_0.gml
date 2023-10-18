
if goto_next_room_on and keyboard_check_pressed(ord("X")) {
	SlideTransition(TRANS_MODE.GOTO, next_room)
}
else if (global.pages_placeholder == 0) {
	SlideTransition(TRANS_MODE.GOTO, next_room)
}