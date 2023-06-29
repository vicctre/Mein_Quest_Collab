
ensure_singleton()

paused = false

function ReplaceWithPauseGiglet(obj) {
	with obj {
		var giglet = instance_create_layer(
			x, y, layer, oPauseGiglet,
			{sprite_index: sprite_index,
			 image_index: image_index,
			 image_speed: image_speed,
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

function PauseWithTimer(time) {
	if paused {
		throw "PauseWithTimer called while pause is active"
	}
	ReplaceWithPauseGiglet(oPlayer)
	ReplaceWithPauseGiglet(ENEMY)
	alarm[0] = time
}

function PauseWithMenu() {
	ReplaceWithPauseGiglet(oPlayer)
	ReplaceWithPauseGiglet(ENEMY)
	paused = true
}
