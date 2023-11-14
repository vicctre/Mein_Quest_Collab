
dim_alpha += dim_ratio * sign(paused - 0.5)
dim_alpha = clamp(dim_alpha, 0, dim_alpha_max)

if !oTransition.IsOff() or array_contains([
			rmAdventureLogsScreen,
			rmThanksForPlayingScreen,
			rmDNS_Logo,
			rmIntroSequence,
			MenuTitleScreenV1
		], room) {
	exit
}

if paused {
	if !oMenuPause.menu_control {
		exit // already quitting
	}
	// freeze pause alarm
	alarm[0] += alarm[0] >= 0
	if keyboard_check_pressed(vk_escape) || gamepad_button_check_pressed(0, gp_start) {
		//PauseWithMenuContinue()
		oMenuPause.PerformButton(1)
	}
} else if (keyboard_check_pressed(vk_escape) || gamepad_button_check_pressed(0, gp_start))
			and not instance_exists(oSequence) {
	PauseWithMenu()
}
