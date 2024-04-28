
event_inherited()

name = "Rularog"

hp_max = 22
hp = 22
hp_phase2_amount = 11
done_phase2_roar = false

// hp ui
hp_ui.draw_x = 700
hp_ui.draw_y = 630

// used to animate rotation
rotation = 0

// distance from room edge when spawned
spawn_dist = room_width - x
room_center_x = room_width * 0.5
// left and right points, where Rula will jump to after jump state
right_side_x = x
left_side_x = spawn_dist

inactiveState = {
	step: function() {},
	onExit: function() {},
	onEnter: function() {},
	checkChange: function() {},
}

idleState = {
    id: id,
	step: function() {

    },
	onExit: function() {

    },
	onEnter: function() {

    },
	checkChange: function() {
		if id.isPhase2() {
			if !id.done_phase2_roar {
				return id.roarState	
			}
			return id.rollState
		}
        return id.walkState
    },
}

walkState = {
    id: id,
    sp: 2,
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
	
	onExit: function() {
		change_state = false
    },
	
	onEnter: function() {
		dir = id.setDir()
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

roarState = {
    id: id,
	roar_sfx: SFX_Rularog_Roar,
	roar_image_index: 24,

	step: function() {
		with id {
			if is_animation_at_frame(other.roar_image_index) {
				audio_play_sound(other.roar_sfx, 3, false)	
				oCamera.start_shaking()
			}
		}
    },
	onExit: function() {

    },
	onEnter: function() {
		id.sprite_index = sRulaROAR
    },
	checkChange: function() {
		with id {
			if is_animation_end() {
				return rollState
			}
		}
    },
}

rollState = {
    id: id,
	dir: 0,
	change_state: false,
	hsp: 0,
	vsp: 0,
	vsp_max: 5,
	accel: 0.2,
	roll_delay_timer: make_timer(60),
	roll_sp: 3,
	rotation_gain: 4,
	grav: 0.1,
	bounce_jump_sp: -2,
	wall_hits: 0,
	ultra_wall_hits_treshold: 2,

	roll: function() {
		id.rotation -= hsp * rotation_gain
		id.move(hsp * !roll_delay_timer.update(), vsp)
		if id.colliding_wall(id.x, id.y + 1) {
			vsp = bounce_jump_sp
		}
		if id.colliding_wall(id.x + dir, id.y) {
			hsp = 0
			id.image_xscale *= -1
			dir = id.image_xscale
			wall_hits++
			oCamera.start_shaking()
		}
	},

    wail_switch_to_ultra_roll: function() {
        id.rotation -= hsp * rotation_gain
        id.move(0, vsp)
        if id.colliding_wall(id.x, id.y + 1) {
            change_state = true
        }
    },

	step: function() {
		hsp = approach(hsp, roll_sp * dir, accel)
		vsp = approach(vsp, vsp_max, grav)
		if wall_hits < ultra_wall_hits_treshold {
			roll()
		} else {
            wail_switch_to_ultra_roll()
		}
	},

	onExit: function() {
		id.rotation = 0
    },
	onEnter: function() {
		roll_delay_timer.reset()
		change_state = false
		wall_hits = 0
		vsp = bounce_jump_sp
		dir = id.setDir()
		id.sprite_index = sRulaRoll
    },
	checkChange: function() {
		if change_state {
			return id.ultraRollState
		}
    },
}

// predefine leaf vars to be used in struct
var leaf_delay = 2
var leaf_number = 7
var leaf_timer = 20
ultraRollState = {
    id: id,
	hdir: 0,
	hdirprev: 0,
	vdir: 0,
	vdirprev: 0,
	change_state: false,
	hsp: 0,
	vsp: 0,
	accel: 0.2,
	roll_sp: 4,
	roll_delay_timer: make_timer(60),
	ultra_roll_sfx: SFX_Rularog_Roar,
	wall_hits: 0,
	ultra_roll_done: false,
	after_roll_timer: make_timer(120),
	rotation_sp: 20,
	rotation_dir: 0,

    make_ultra_roll: function() {
        id.move(hsp * !roll_delay_timer.update(), vsp)
		id.rotation += rotation_sp * rotation_dir
        if id.colliding_wall(id.x + hdir, id.y + vdir) {
            hsp = 0
            vsp = 0
            // change directions
            // if at start hdir = -1 and vdir = 0
            // they will change clockwise-like
            if hdir != 0 {
                hdirprev = hdir
                hdir = 0
            } else {
                hdir = -hdirprev
				id.image_xscale = hdir
            }
            if vdir != 0 {
                vdirprev = vdir
                vdir = 0
            } else {
                vdir = -vdirprev	
            }
            wall_hits++
            oCamera.start_shaking()
            if wall_hits == 4 {
                ultra_roll_done = true
                id.sprite_index = sRulaIdle
                id.rotation = 0
            }
        }
    },

    wait_after_roll: function() {
        if !after_roll_timer.update() {
            change_state = true	
        }
    },

	step: function() {
		hsp = approach(hsp, roll_sp * hdir, accel)
		vsp = approach(vsp, roll_sp * vdir, accel)
		if !ultra_roll_done {
            make_ultra_roll()
		} else {
            wait_after_roll()
		}
        // spawn leafs if rolling under the ceiling
        if wall_hits == 2 {
            check_spawn_leaf()
        }
	},

	onExit: function() {
		id.rotation = 0
	},

	onEnter: function() {
		ultra_roll_done = false
		after_roll_timer.reset()
		wall_hits = 0
		change_state = false
		hdir = id.setDir()
		vdirprev = 1 // next vdir will be -1 -> up
		rotation_dir = -hdir
		id.sprite_index = sRulaRoll
		audio_play_sound(ultra_roll_sfx, 3, false)
    },

	checkChange: function() {
		if change_state {
			return id.jumpState
		}
    },


    //// Leafs
    leaf_timer: make_timer(leaf_timer),
	leaf_delay: leaf_delay,
    // leaf_number - 1 will provide leafs to change spawning pattern
    leaf_hoffset_divider: leaf_number - 1,
    leaf_fall_time: leaf_timer - leaf_number * leaf_delay,
    leaf_counter: 0,
    leaf_distance: 15,
    spawn_leaf: function() {
        // this basically runs leaf_counter in cycles
        leaf_counter = (leaf_counter + 2) % leaf_hoffset_divider
        var h_offset = leaf_distance * (1 - leaf_counter / 2)
        instance_create_layer(id.x + h_offset, 50, "Enemies", oFallingLeaf)
    },
	check_spawn_leaf: function() {
		if !leaf_timer.update() {
		    leaf_timer.reset()
		}
		if (leaf_timer.timer >= leaf_fall_time
		        && leaf_timer.timer % leaf_delay == 0) {
		    spawn_leaf()
		}
	}
}

deadState = {
    id: id,
	pause_time: 80,
	vsp: -4,
	vsp_max: 10,
	grav: 0.2,
	hsp: 3,
	dir: 0,
	spirit_byte_timer: make_timer(60),
	spirit_byte_dropped: false,
	screen_shaked: false,

	step: function() {
		if !screen_shaked {
			oCamera.start_shaking()
			screen_shaked = true
			audio_play_sound(global.sfx_BOOM, 3, false)
		}
		vsp = approach(vsp, vsp_max, grav)
		id.move(hsp * dir, vsp)
		if id.colliding_wall(id.x + dir, id.y) {
			hsp = 0	
		}
		if id.colliding_wall(id.x, id.y + 1) {
			vsp = 0
			id.sprite_index = sRulaDead
			if !spirit_byte_dropped and !spirit_byte_timer.update() {
				instance_create_layer(id.x, id.y, "objects", oSpiritByteBoss)
				spirit_byte_dropped = true
				oMusic.switch_music(global.msc_post_battle, true, 0)
			}
		}
    },
	onExit: function() {

    },
	onEnter: function() {
		dir = sign(id.x - oMein.x)
		dir = dir != 0 ? dir : 1
		id.image_xscale = -dir
		id.sprite_index = sRulaKOed
		oPause.PauseWithTimer(pause_time)
    },
	checkChange: function() {
		// there is no coming back from the dead
        return undefined
    },
}

function checkStateChangeGlobal() {
	if !hp and state != deadState {
		return deadState
	}
	return undefined
}


function isPhase2() {
	return hp <= hp_phase2_amount
}

function setDir() {
	image_xscale = x > room_center_x ? -1 : 1
	return image_xscale
}


state = idleState

function is_on_left_side() {
	return abs(x - left_side_x) < abs(x - right_side_x)
}

function draw_hit_flashing() {
	if (flash > 0) {
		flash--
		shader_set(SHWhite)
		draw_sprite_ext(sprite_index, image_index, x, y,
					    image_xscale, image_yscale, rotation, c_white, 1)
		shader_reset()
	} else {
		// for rotation animation don't rotate actuall sprite with its collision mask
		// but simply animate rotation
		draw_sprite_ext(sprite_index, image_index, x, y,
					    image_xscale, image_yscale, rotation, c_white, 1)
	}
}

function colliding_wall(xx, yy) {
	return place_meeting(xx, yy, oWall)
}

function move(hsp, vsp) {
	scr_move_coord_contact_obj(hsp, vsp, oWall)
}













