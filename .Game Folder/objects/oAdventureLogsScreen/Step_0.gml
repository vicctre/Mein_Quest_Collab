
if (goto_next_room_on and keyboard_check_pressed(ord("X"))) or global.pages_placeholder == 0 {
	SlideTransition(TRANS_MODE.GOTO, next_room, 60)
	oMusic.switch_music(global.msc_stage_1_1)
}
