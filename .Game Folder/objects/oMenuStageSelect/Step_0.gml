
event_inherited()

if oInput.key_escape and menu != main_menu {
	PerformGoBack()
	audio_play_sound(global.sfx_select, 7, false)
}
