
dim_alpha += dim_ratio * sign(pause_dim_on - 0.5)
dim_alpha = clamp(dim_alpha, 0, dim_alpha_max)

if !oTransition.IsOff() or array_contains([
			rmAdventureLogsScreen,
			rmThanksForPlayingScreen,
			rmDNS_Logo,
			rmIntroSequence,
			rmTitleScreen
		], room) {
	exit
}

if paused and instance_exists(oMenuPause) {
	if !oMenuPause.menu_control {
		pause_dim_on = false
		exit // already quitting
	}
	// freeze pause alarm
	alarm[0] += alarm[0] >= 0
	if oInput.key_back {
		//PauseWithMenuContinue()
		oMenuPause.PerformButtonContinue(1)
		pause_dim_on = false
	}
} else if !paused
			and oInput.key_escape
			and IsStageRoom(room)
			and not instance_exists(oSequence) {
	PauseWithMenu()
	pause_dim_on = true
}
