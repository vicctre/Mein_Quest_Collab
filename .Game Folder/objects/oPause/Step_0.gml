
if paused {
	// freeze pause alarm
	alarm[0] += alarm[0] >= 0
	if keyboard_check_pressed(vk_escape) {
		ReturnActualInstances()
		paused = false
	}
} else if keyboard_check_pressed(vk_escape) {
	paused = true
	PauseWithMenu()
}
