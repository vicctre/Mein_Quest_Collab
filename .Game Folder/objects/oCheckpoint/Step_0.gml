
if place_meeting(x, y, global.player) {
	var xx = global.player.x
	var yy = global.player.y
	if X != undefined {
		xx = X	
	}
	if Y != undefined {
		yy = Y	
	}
	set_checkpoint(xx, yy)
	oUI.show_checkpoint_indicator()
}
