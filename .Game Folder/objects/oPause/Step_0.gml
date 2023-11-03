
dim_alpha += dim_ratio * sign(paused - 0.5)
dim_alpha = clamp(dim_alpha, 0, dim_alpha_max)

if !oTransition.IsOff() or room == MenuTitleScreenV1 || room == Intro_Sequence {
	exit
}

if paused {
	if !oMenuPause.menu_control {
		exit // already quitting
	}
	// freeze pause alarm
	alarm[0] += alarm[0] >= 0
	if keyboard_check_pressed(vk_escape) {
		//PauseWithMenuContinue()
		oMenuPause.PerformButton(1)
	}
} else if keyboard_check_pressed(vk_escape) {
	PauseWithMenu()
}
