
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
	var camera_bbox_right = scr_camx(0) + scr_camw(0)
	for(var i = 0; i < array_length(enemies_to_activate_by_distance); i++) {
		var data = 	enemies_to_activate_by_distance[i]
		var dist = max(data.dist, 0)
		if data.x - camera_bbox_right < dist {
			instance_activate_object(data.id)
			array_remove(enemies_to_activate_by_distance, data)
			i--
			show_debug_message("Enemy activated by distance")
		}
	}
}

make_late_init()

oEventSystem.Subscribe(
	Events.stage_exit,
	function() {
		global.autoscroller_current_log_sprite_index = -1
		global.autoscroller_reached_pinnik_controllers = []	
	}
)











