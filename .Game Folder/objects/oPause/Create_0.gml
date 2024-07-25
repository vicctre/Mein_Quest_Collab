
ensure_singleton()

paused = false

pause_dim_on = false
dim_alpha_max = 0.5
dim_alpha = 0
dim_ratio = 0.01

dummy_replaced_objects = [
    ENEMY, oDeadEnemy, oAutoscrollerLog, oRulaTongue,
    oMein, oMeinOnLog
]

explicitly_paused_objects = [
    oSequence, ApploonSpawner, oW2Wave
]

function PauseWithTimer(time) {
	if paused {
		throw "PauseWithTimer called while pause is active"
	}
	PauseStuff()
	alarm[0] = time
	paused = true
}

function PauseWithMenu() {
	PauseStuff()
	instance_create_layer(0, 0, "ui", oMenuPause)
	paused = true
}

function PauseStuff() {
	//// Actually pause different game objects
	// First replace game world objects with
	// visual dummies
    for (var i = 0; i < array_length(dummy_replaced_objects); i += 1) {
        var obj = dummy_replaced_objects[i]
        ReplaceWithPauseDummy(obj)
    }
	// Then tell other pausable objects to pause
    for (var i = 0; i < array_length(explicitly_paused_objects); i += 1) {
        var obj = explicitly_paused_objects[i]
        with obj { pause() }
    }
}

function ReplaceWithPauseDummy(obj) {
	with obj {
		var dummy = instance_create_layer(
			x, y, layer, oPauseDummy,
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
		dummy.source_instance = id
		instance_deactivate_object(id)
	}
}

function ReturnActualInstances() {
	with oPauseDummy {
		instance_activate_object(source_instance)
		instance_destroy()
	}
}

function UnpauseStuff() {
	ReturnActualInstances()
    for (var i = 0; i < array_length(explicitly_paused_objects); i += 1) {
        var obj = explicitly_paused_objects[i]
        with obj { unpause() }
    }
}

function PauseWithMenuContinue() {
	UnpauseStuff()
	paused = false
}

function game_paused() {
	return paused or alarm[0] > 0
}

function SetPaused(value) {
	paused = value
}
