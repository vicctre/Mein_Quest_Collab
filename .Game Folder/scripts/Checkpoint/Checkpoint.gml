
function reset_checkpoint() {
	global.checkpoint = undefined
}

function set_checkpoint(x, y) {
	global.checkpoint = {
		x: x,
		y: y
	}
}

function is_checkpoint_set() {
	return global.checkpoint != undefined
}

function player_goto_checkpoint() {
	oPlayer.x = global.checkpoint.x
	oPlayer.y = global.checkpoint.y
}
