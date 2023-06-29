
if paused {
	if !oTransition.IsOff() or !oMenu.menu_control {
		exit // already quitting
	}
	// freeze pause alarm
	alarm[0] += alarm[0] >= 0
	if keyboard_check_pressed(vk_escape) {
		PauseWithMenuContinue()
		oMenu.PerformButton(1)
	}
} else if keyboard_check_pressed(vk_escape) {
	paused = true
	PauseWithMenu()
}
