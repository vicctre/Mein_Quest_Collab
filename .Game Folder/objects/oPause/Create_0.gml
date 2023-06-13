
ensure_singleton()

function ReplaceWithPauseGiglet(obj) {
	with obj {
		var giglet = instance_create_layer(
			x, y, layer, oPauseGiglet,
			{sprite_index: sprite_index,
			 image_index: image_index,
			 image_angle: image_angle,
			 image_xscale: image_xscale,
			 image_yscale: image_yscale}
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
	ReplaceWithPauseGiglet(oPlayer)
	ReplaceWithPauseGiglet(ENEMY)
	alarm[0] = time
}
