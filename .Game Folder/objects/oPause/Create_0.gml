
ensure_singleton()

paused = false

function ReplaceWithPauseGiglet(obj) {
	with obj {
		var giglet = instance_create_layer(
			x, y, layer, oPauseGiglet,
			{sprite_index: sprite_index,
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

function MenuLayout() {
	return [
		{
			title: "Quit",
			action: function() {
				SlideTransition(TRANS_MODE.RESTART)	
			}
		},
		{
			title: "Continue",
			action: oPause.PauseWithMenuContinue
		}
	]
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
	with instance_create_layer(0, 0, "ui", oMenu) {
		menu = other.MenuLayout()	
		menu_items = array_length(menu) 
		menu_top = menu_y - ((menu_itemheight * 1.5) * menu_items) 
		menu_cursor = menu_items - 1
	}
	paused = true
}

function PauseWithMenuContinue() {
	ReturnActualInstances()
	paused = false
}
