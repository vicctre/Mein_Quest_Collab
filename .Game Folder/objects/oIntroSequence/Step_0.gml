event_inherited()

if keyboard_check_pressed(vk_enter) or keyboard_check_pressed(ord("X")) {
	SlideTransition(TRANS_MODE.NEXT);
	oMusic.switch_music(global.msc_stage_1_1);
}
