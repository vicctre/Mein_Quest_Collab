
make_late_init()
intro_played = false

enemies_to_activate_by_distance = []
function AddDeactivatedEnemy(inst) {
	array_push(enemies_to_activate_by_distance, {
		id: inst,
		x: inst.x,
		dist: inst.autoscroller_activate_distance
	})
}

function InitEnemies() {
	with ENEMY {
		if autoscroller_activate_distance != undefined {
			oAutoscrollerController.AddDeactivatedEnemy(id)
			instance_deactivate_object(id)
			show_debug_message("Enemy deactivated")
		}
	}
}

function CheckActivateEnemies() {
	var camera_bbox_right = camx() + camw()
	for(var i = 0; i < array_length(enemies_to_activate_by_distance); i++) {
		var data = 	enemies_to_activate_by_distance[i]
		var dist = max(data.dist, 0)
		if data.x - camera_bbox_right < dist {
			instance_activate_object(data.id)
			array_remove(enemies_to_activate_by_distance, data)
			i--
		}
	}
}

make_late_init()

function _StageExitCallback() {
	global.autoscroller_current_log_sprite_index = -1
	global.autoscroller_reached_pinnik_controllers = []
	global.camera_solid_bounds_on = false
}

oEventSystem.Subscribe(Events.stage_exit, id, _StageExitCallback)








