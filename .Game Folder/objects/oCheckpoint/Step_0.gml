
if place_meeting(x, y, oPlayer) {
	var xx = oPlayer.x
	var yy = oPlayer.y
	if X != undefined {
		xx = X	
	}
	if Y != undefined {
		yy = Y	
	}
	set_checkpoint(xx, yy)
	oUI.show_checkpoint_indicator()
}
