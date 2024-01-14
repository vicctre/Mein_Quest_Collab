
event_inherited()

if !is_playing() and place_meeting(x, y, global.player) {
	unpause()
	global.player.visible = false
	global.player.has_control = false
}
