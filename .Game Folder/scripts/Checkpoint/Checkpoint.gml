
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
	oMein.x = global.checkpoint.x
	oMein.y = global.checkpoint.y
}
