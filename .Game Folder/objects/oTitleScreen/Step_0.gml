
if oInput.key_any {
	show_text = false
	oMusic.switch_music(global.msc_main_menu)
	RoomTransition(TRANS_MODE.NEXT, noone, false, 60)
}
