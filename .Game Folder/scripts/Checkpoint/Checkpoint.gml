
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
	global.player.x = global.checkpoint.x
	global.player.y = global.checkpoint.y
}
