
ensure_singleton()

paused = false

function ReplaceWithPauseGiglet(obj) {
	with obj {
		var giglet = instance_create_layer(
			x, y, layer, oPauseGiglet,
			{sprite_index: sprite_index,
			 visible: visible,
			 image_index: image_index,
			 image_speed: 0,
			 image_angle: image_angle,
			 image_xscale: image_xscale,
			 image_yscale: image_yscale,
			 image_blend: image_blend,
			 image_alpha: image_alpha}
		)
		giglet.source_instance = id
		instance_deactivate_object(id)
	}
}

function ReturnActualInstances() {
	with oPauseGiglet {
		instance_activate_object(source_instance)
		instance_destroy()
	}
}

function PauseStuff() {
	ReplaceWithPauseGiglet(oPlayer)
	ReplaceWithPauseGiglet(ENEMY)
	ReplaceWithPauseGiglet(deadEnemy)
	with oSequence {
		pause()
	}
}

function UnpauseStuff() {
	ReturnActualInstances()
	with oSequence {
		unpause()
	}
}

function PauseWithTimer(time) {
	if paused {
		throw "PauseWithTimer called while pause is active"
	}
	PauseStuff()
	alarm[0] = time
}

function PauseWithMenu() {
	PauseStuff()
	instance_create_layer(0, 0, "ui", oMenuPause)
	paused = true
}

function PauseWithMenuContinue() {
	UnpauseStuff()
	paused = false
}

function game_paused() {
	return paused or alarm[0] > 0
}
