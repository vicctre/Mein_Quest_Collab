
event_inherited()

if !is_playing() and place_meeting(x, y, oMein) {
	unpause()
	oMein.visible = false
	oMein.has_control = false
}
