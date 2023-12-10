
event_inherited()

if !is_playing() and place_meeting(x, y, oPlayer) {
	unpause()
	oPlayer.visible = false
	oPlayer.has_control = false
}
