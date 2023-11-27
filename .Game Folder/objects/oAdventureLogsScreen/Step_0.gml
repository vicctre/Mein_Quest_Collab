
if goto_next_room_on and oInput.key_action
		or global.pages_placeholder == 0 {
	SlideTransition(TRANS_MODE.GOTO, next_room, 60)
	if !DEMO {
		oMusic.switch_music(global.msc_stage_1_1)
	}
}
