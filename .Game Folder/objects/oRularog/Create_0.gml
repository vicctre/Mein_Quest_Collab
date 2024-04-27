  
event_inherited()

hp = 22

//function set_hit() {
	
//}

// distance from room edge when spawned
spawn_dist = room_width - x
// left and right points, where Rula will jump to after jump state
right_side_x = x
left_side_x = spawn_dist

idleState = {
    id: id,
	step: function() {

    },
	onExit: function() {

    },
	onEnter: function() {

    },
	checkChange: function() {
        return id.walkState
    },
}

walkState = {
    id: id,
    sp: 2,
    room_center_x: room_width * 0.5,
    dir: image_xscale,
	change_state: false,
	
	step: function() {
        with id {
            if place_meeting(x + other.dir, y, oWall) {
                other.dir = -other.dir
				image_xscale = other.dir
				other.change_state = true
            }
			var sp = other.sp * other.dir
			scr_move_coord_contact_obj(sp, 0, oWall)
        }
    },
	
	setWalkDir: function() {
		dir = id.x > room_center_x ? -1 : 1	
	},
	
	onExit: function() {
		change_state = false
    },
	
	onEnter: function() {
		setWalkDir()
        id.sprite_index = sRulaWalk
    },
	
	checkChange: function() {
        if change_state {
			return id.jumpState
		}
		return undefined
    },
}

enum RulaJump {
	prepare,
	jump,
	dash_fall,
	finish,
}

jumpState = {
    id: id,
	prepare_timer: make_timer(40),
	state: RulaJump.prepare,
	hsp: 0,
	hsp_max: 9, // how fast Rula moves during jump
				// also affects jump curve if Mein is far away
	reach_player_time: 30, // how fast Rula reaches the player during jump
						   // will be increased if Mein is far away
	jump_sp: -13,
	jump_height: 140, // that's it, jump height
	grav_base: 0.6,	  // jump state gravity
	grav: 0.6,

	vsp: 0,
	vsp_max: 10,
	dash_fall_sp: 6, // how fast Rula falls on Mein
	dash_x: 0,
	jumps_total: 3,
	jumps_left: 3,
	dash_delay: make_timer(5),
	last_dash_delay_timer: make_timer(60), // after last dash just hang out for some time
	change_state: false,
	finish_vsp_hsp_ratio: 3, // finish_vsp_hsp_ratio = vsp / hsp
	finish_edge_dist_treshold: 50, // if room edge is closer than finish_edge_dist_treshold
									// don't make the finishing jump
	finish_gr: 0.2,

	switch_to_prepare: function() {
		state = RulaJump.prepare
		vsp = 0
		prepare_timer.reset()
		dash_delay.reset()
		id.sprite_index = sRulaJumpPrep
		var dir = sign(oMein.x - id.x)
		if dir != 0 {
			id.image_xscale = dir
		}
		oCamera.start_shaking()
	},
	
	maybe_switch_to_finish: function() {
		var dist_to_left = id.left_side_x - id.x
		var dist_to_right = id.right_side_x - id.x
		var dist = min(abs(dist_to_left), abs(dist_to_right))
		
		if dist < finish_edge_dist_treshold {
			change_state = true
			return;
		}
		state = RulaJump.finish
		var dir = dist == dist_to_right ? 1 : -1
		vsp = -sqrt(0.5 * dist * finish_gr * finish_vsp_hsp_ratio)
		hsp = abs(vsp) * dir / finish_vsp_hsp_ratio
	},

	step: function() {
		switch state {
		    case RulaJump.prepare:
				if !prepare_timer.update() {
					if jumps_left {
						grav = grav_base
						state = RulaJump.jump
						jumps_left--
						vsp = jump_sp
						dash_x = median(id.left_side_x, oMein.x, id.right_side_x)
						var dist = (oMein.x - id.x)
						hsp = dist / reach_player_time

						// decrease movement vars so Rula moves a bit smoother
						if abs(hsp) > hsp_max {
							hsp = hsp_max * sign(hsp)
							var actual_reach_player_time = dist / hsp
							// g = 2h / t^2
							grav = 2 * jump_height / power(actual_reach_player_time, 2)
							// v = -g * t
							vsp = -grav * actual_reach_player_time
						}
						id.sprite_index = sRulaJumpUp
					} else {
						maybe_switch_to_finish()
					}
				}
		    break
			case RulaJump.jump:
				vsp = approach(vsp, vsp_max, grav)
				with id {
					if other.vsp > 0 {
						sprite_index = sRulaFalling	
					}
					scr_move_coord_contact_obj(other.hsp, other.vsp, oWall)
					if abs(other.dash_x - x) < abs(other.hsp)
							or place_meeting(x + sign(other.hsp), y, oWall) {
						other.state = RulaJump.dash_fall
						other.hsp = 0
						sprite_index = sRulaFalling	
					}
				}
		    break
			case RulaJump.dash_fall:
				if !dash_delay.update() {
					vsp = dash_fall_sp
				}
				with id {
					scr_move_coord_contact_obj(other.hsp, other.vsp, oWall)
					if place_meeting(x, y + 1, oWall) {
						other.switch_to_prepare()
					}
				}
		    break
			case RulaJump.finish:
				if last_dash_delay_timer.update() {
					break	
				}
				id.sprite_index = sRulaJumpUp
				vsp = approach(vsp, vsp_max, finish_gr)
				with id {
					scr_move_coord_contact_obj(other.hsp, other.vsp, oWall)
					if place_meeting(x, y + 1, oWall) {
						other.change_state = true
					}
				}
		    break
		}
	},
	
	onExit: function() {},
	
	onEnter: function() {
		change_state = false
		last_dash_delay_timer.reset()
		prepare_timer.reset()
		jumps_left = jumps_total
		state = RulaJump.prepare
		id.sprite_index = sRulaJumpPrep
    },
	
	checkChange: function() {
        if change_state {
			return id.tongueChargeState
		}
		return undefined
    },
}

tongueChargeState = {
    id: id,
	charge_timer: make_timer(135),
	
	step: function() {},
	
	onExit: function() {
		charge_timer.reset()
    },
	
	onEnter: function() {
		id.sprite_index = sRulaCharge
    },
	
	checkChange: function() {
        if !charge_timer.update() {
			return id.tongueAttackState
		}
		return undefined
    },
}

tongueAttackState = {
    id: id,
	change_state: false,
	tongue: noone,
	tongue_rel_x: 22,
	tongue_rel_y: 14,

	step: function() {
    },
	
	onExit: function() {
    },
	
	onEnter: function() {
		id.image_xscale = id.is_on_left_side() ? 1 : -1
		id.sprite_index = sRulaTongueStance
		tongue = instance_create_layer(id.x + tongue_rel_x * id.image_xscale,
									   id.y + tongue_rel_y,
									   "RulaTongue", oRulaTongue)
		var tongue_tip = instance_create_layer(id.x + tongue_rel_x * id.image_xscale,
											   id.y + tongue_rel_y,
											   "RulaTongue", oRulaTongueTip)
		tongue_tip.image_xscale = id.image_xscale
		tongue.tongue_tip = tongue_tip
    },
	
	checkChange: function() {
		if !instance_exists(tongue) {
			return id.idleState
		}
		return undefined
    },
}

state = idleState

//// Leafs
leaf_timer = make_timer(45)
leaf_delay = 2
leaf_number = 7
// leaf_number - 1 will provide leafs to change spawning pattern
leaf_hoffset_divider = leaf_number - 1
leaf_fall_time = leaf_timer.time - leaf_number * leaf_delay

leaf_counter = 0
leaf_distance = 15
function spawn_leaf() {
	// this basically runs leaf_counter in cycles
	leaf_counter = (leaf_counter + 2) % leaf_hoffset_divider
	var h_offset = leaf_distance * (1 - leaf_counter / 2)
	instance_create_layer(x + h_offset, 50, "Enemies", oFallingLeaf)
}


function is_on_left_side() {
	return abs(x - left_side_x) < abs(x - right_side_x)
}



















