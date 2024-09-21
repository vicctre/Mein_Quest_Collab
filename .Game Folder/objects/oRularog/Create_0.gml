
event_inherited()

name = "Rularog"

hp_max = 26
hp = hp_max
hp_phase2_amount =  12//11
done_phase2_roar = false

if DEV {
    hp = hp_max //- 25
}

// hp ui
hp_ui.draw_x = 700
hp_ui.draw_y = 730


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
	idle_timer: make_timer(60), // how long to stay idle

	step: function() {

    },
	onExit: function() {

    },
	onEnter: function() {
		idle_timer.reset()
		id.sprite_index = sRulaIdle
		id.setDir()
    },
	checkChange: function() {
		if idle_timer.update() {
			return undefined
		}
		if id.isPhase2() and !id.done_phase2_roar {
			// if !id.done_phase2_roar {
			// 	return id.roarState	
			// }
			return id.roarState
		}
        return id.walkState
    },
}

walkState = {
    id: id,
    sp: 1.8, //2
    dir: image_xscale,
	change_state: false,
    prepare_to_tongue_attack: false,    // go to the closest wall instead of farest
                                        // used by jump state to get close enough to wall
                                        // before tongue attack
                                        // not in use currently

	step: function() {
        if id.colliding_wall(id.x + dir, id.y) {
            dir = -dir
            id.image_xscale = dir
            change_state = true
        }
        id.move(sp * dir, 0)
    },
	
	onExit: function() {
		change_state = false
    },
	
	onEnter: function() {
        dir = id.setDir()
        if prepare_to_tongue_attack {
            dir = id.setDir(-dir)
        }
        id.sprite_index = sRulaWalk
    },
	
	checkChange: function() {
        if change_state {
            if prepare_to_tongue_attack {
                prepare_to_tongue_attack = false
                return id.tongueChargeState
            }
			return id.checkStateChangePhase2() ?? id.jumpState
		}
		return undefined
    },
}

enum RulaJump {
	prepare,
	jump,
	fast_fall,
	after_fall_delay,
	finish,
}

jumpState = {
    id: id,
    after_fall_delay_timer: make_timer(25), // how long to stay headed jump direction
	fast_fall_delay: make_timer(30),
	fast_fall_sp: 12,//20 // how fast Rula falls on Mein
	finish_vsp_hsp_ratio: 4,//3 // finish_vsp_hsp_ratio = vsp / hsp//auto jump height? 
	finish_edge_dist_treshold: 50, // if room edge is closer than finish_edge_dist_treshold
    // don't make the finishing jump
    finish_gr: 0.2,
	grav_base: 0.6,	  // jump state gravity
	jump_sp: -13,
	jump_height: 120, //140, // that's it, jump height
	hsp_max: 6,  // how fast Rula moves during jump
                // also affects jump curve if Mein is far away
	last_fast_fall_delay_timer: make_timer(60), // Final jumps endlag
    prepare_time: 25, // used for prepare_timer between jumps
    first_jump_prepare_time: 50, 
	prepare_timer: make_timer(25), //startup for jumps 
	pre_fast_fall_lift_height: 25, // slowly lift a bit before falling
	reach_player_time: 30, // how fast Rula reaches the player during jump
                           // will be increased if Mein is far away
	vsp_max: 10, // idk what this changes... Well, Vic if you don't know, you can always ask Gav, right? I mean, we're a team, bro
                 // this is literally maximum fall speed
	state: RulaJump.prepare,
	hsp: 0,
	grav: 0.6,

	vsp: 0,
	fast_fall_x: 0, //dont see what this changes either???
	jumps_total: 3, // if you change jumps_total, change jumps_left too!
	jumps_left: 3,
	change_state: false,
    pre_fast_fall_lift: 0,

    next_rula_state: undefined, // used to override next state

	switch_to_prepare: function() {
		state = RulaJump.prepare
		vsp = 0
        prepare_timer.time = prepare_time
		prepare_timer.reset()
		fast_fall_delay.reset()
		var dir = sign(oMein.x - id.x)
		if dir != 0 {
			id.image_xscale = dir
		}
	},
	
	maybe_switch_to_finish: function() {
		var dist_to_left = id.left_side_x - id.x
		var dist_to_right = id.right_side_x - id.x
		var dist = min(abs(dist_to_left), abs(dist_to_right))
		
		if dist < finish_edge_dist_treshold {
            // switch to walk state to come closer to the wall
            id.walkState.prepare_to_tongue_attack = true
            next_rula_state = id.walkState
			change_state = true
			return;
		}
        // switch to finish substate
		state = RulaJump.finish
		var dir = dist == dist_to_right ? 1 : -1
		vsp = -sqrt(0.5 * dist * finish_gr * finish_vsp_hsp_ratio)
		hsp = abs(vsp) * dir / finish_vsp_hsp_ratio
	},

	emit_fall_dust: function() {
		with id {
			var rand = randomer(-5, 5)
			oEffects.emit_dust_ext(bbox_right, bbox_bottom, 1.6, rand())
			oEffects.emit_dust_ext(bbox_left, bbox_bottom, 1.6, 180 + rand())
			oEffects.emit_dust_ext(bbox_right, bbox_bottom, 1.4, rand())
			oEffects.emit_dust_ext(bbox_left, bbox_bottom, 1.4, 180 + rand())
			oEffects.emit_dust_ext(bbox_right, bbox_bottom, 1, rand())
			oEffects.emit_dust_ext(bbox_left, bbox_bottom, 1, 180 + rand())
		}
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
						fast_fall_x = median(id.left_side_x, oMein.x, id.right_side_x)
						var dist = (fast_fall_x - id.x)
						if abs(dist) < 0.001 {
							dist = 0
							fast_fall_x = x
						}
						hsp = dist / reach_player_time
						audio_play_sound(global.sfx_rula_jump, 3, false)

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
						other.vsp = 0
					}
					player_move_coord_contact_obj(other.hsp, other.vsp, oWall)
					if abs(other.fast_fall_x - x) <= abs(other.hsp)
							or place_meeting(x + sign(other.hsp), y, oWall) {
						other.state = RulaJump.fast_fall
						other.hsp = 0
						sprite_index = sRulaFalling
					}
				}
		    break
			case RulaJump.fast_fall:
				if fast_fall_delay.update() {
                    // lift with decreasing sp
                    vsp = -(pre_fast_fall_lift_height - pre_fast_fall_lift)
							/ pre_fast_fall_lift_height * 0.25
                    pre_fast_fall_lift += abs(vsp)
                } else {
					vsp = fast_fall_sp
                }
                id.move(hsp, vsp)
                if id.colliding_wall(id.x, id.y + 1) {
                    audio_play_sound(global.sfx_rula_land, 3, false)
                    state = RulaJump.after_fall_delay
                    id.sprite_index = sRulaJumpPrep
                    oCamera.start_shaking() // how much the screen shakes when Rula jumps
                    emit_fall_dust()
                }
		    break
			case RulaJump.after_fall_delay:
				if !after_fall_delay_timer.update() {
					after_fall_delay_timer.reset()
					switch_to_prepare()
				}
			break
			case RulaJump.finish:
				if last_fast_fall_delay_timer.update() {
					break	
				}
				id.sprite_index = sRulaJumpUp
				vsp = approach(vsp, vsp_max, finish_gr)
                id.move(hsp, vsp)
                if id.colliding_wall(id.x, id.y + 1) {
                    audio_play_sound(global.sfx_rula_land, 3, false)
                    change_state = true
                }
		    break
		}
	},
	
	onExit: function() {},
	
	onEnter: function() {
		change_state = false
		last_fast_fall_delay_timer.reset()
        prepare_timer.time = first_jump_prepare_time
		prepare_timer.reset()
		jumps_left = jumps_total
		state = RulaJump.prepare
		id.sprite_index = sRulaJumpPrep
		id.setDir()
        pre_fast_fall_lift = 0
    },
	
	checkChange: function() {
		var next_state = next_rula_state ?? id.tongueChargeState
		// reset next state overriding
		next_rula_state = undefined
        if change_state {
			return id.checkStateChangePhase2() ?? next_state
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
		id.setDir()
    },

	checkChange: function() {
        if !charge_timer.update() {
			return id.checkStateChangePhase2() ?? id.tongueAttackState
		}
    },
}

tongueAttackState = {
    id: id,
	change_state: false,
	tongue: noone,
	tongue_rel_x: 14,
	tongue_rel_y: 14,

	step: function() {
    },

	onExit: function() {
    },

	onEnter: function() {
		audio_play_sound(SFX_TongueAttack, 3, false)
		id.sprite_index = sRulaTongueStance
		id.setDir()
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
			if oMein.is_grabbed() {
				return id.throwMeinChargeState
			}
			return id.checkStateChangePhase2() ?? id.ifPhase2(id.rollState)
		}
		return undefined
    },
}

throwMeinChargeState = {
    id: id,
	charge_timer: make_timer(45),

	step: function() {},
	
	onExit: function() {
		charge_timer.reset()
    },

	onEnter: function() {
		id.sprite_index = sRulaCharge
		id.setDir()
		oMein.visible = false
    },

	checkChange: function() {
        if !charge_timer.update() {
			return id.throwMeinState
		}
    },
}

throwMeinState = {
    id: id,
	change_state_timer: make_timer(90), // how long to stay in Stance pose
	throw_hsp: 8,
	throw_vsp: -8,

	step: function() {
    },

	onExit: function() {
    },

	onEnter: function() {
		change_state_timer.reset()
		oMein.visible = true
		oMein.become_throwed(throw_hsp * id.image_xscale, throw_vsp)
		oMein.invincibility_timer_no_flashing.reset(5) // make Mein invincible to not be hit by Rula while throwed
		audio_play_sound(SFX_pew, 3, false)
		id.sprite_index = sRulaTongueStance
		id.setDir()
    },

	checkChange: function() {
		if !change_state_timer.update() {
			return id.checkStateChangePhase2() ?? id.ifPhase2(id.rollState)
		}
		return undefined
    },
}

roarState = {
    id: id,
	roar_sfx: SFX_Rularog_Roar,
	roar_image_index: 24,
	roar_sound_played: false,

	step: function() {
		with id {
			if !other.roar_sound_played and is_animation_at_frame(other.roar_image_index) {
				audio_play_sound(other.roar_sfx, 3, false)	
				oCamera.start_shaking()
                show_debug_message("Roar")
				roar_sound_played = true
			}
		}
    },
	onExit: function() {

    },
	onEnter: function() {
		id.sprite_index = sRulaROAR
		id.done_phase2_roar = true
		roar_sound_played = false
		id.setDir()
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
	roll_delay_timer: make_timer(80),
	roll_sp: 3.5, //roll speed on the ground
	rotation_gain: 4,
	grav: 0.1,
	bounce_jump_sp_start: -2,
	bounce_jump_sp: 0,
    bounce_dissipation: 0.6,
	wall_hits: 0,
	ultra_wall_hits_treshold: 2,

    roll: function() {
		id.rotation -= hsp * rotation_gain
		id.move(hsp * !roll_delay_timer.update(), vsp)
		if id.colliding_wall(id.x, id.y + 1) {
            bounce_jump_sp = approach(bounce_jump_sp, 0, bounce_dissipation)
			vsp = bounce_jump_sp
            // audio_play_sound(global.sfx_rula_hitwall, 3, false)
		}
		if id.colliding_wall(id.x + dir, id.y) {
			hsp = 0
			id.image_xscale *= -1
			dir = id.image_xscale
			wall_hits++
            bounce_jump_sp = bounce_jump_sp_start
			vsp = bounce_jump_sp
			oCamera.start_shaking()
            roll_delay_timer.reset()
            audio_play_sound(global.sfx_rula_hitwall, 3, false)
		}
	},

    wail_switch_to_ultra_roll: function() {
        id.rotation -= hsp * rotation_gain
        id.move(0, vsp)
        if id.colliding_wall(id.x, id.y + 1) {
            bounce_jump_sp = approach(bounce_jump_sp, 0, bounce_dissipation)
            vsp = bounce_jump_sp
            if bounce_jump_sp == 0 {
                change_state = true
            }
            // audio_play_sound(global.sfx_rula_land, 3, false)
        }
    },

	step: function() {
		hsp = approach(hsp, roll_sp * dir, accel)
		vsp = approach(vsp, vsp_max, grav)
		if vsp > 0 and id.colliding_wall(id.x, id.y + 1) {
			vsp = 0
		}
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
        bounce_jump_sp = bounce_jump_sp_start
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
	accel: 0.15,  //how fast the roll meets max speed and going around the walls 
	roll_sp: 5.5, //Ultra roll speed
	roll_delay_timer: make_timer(70),//startup of 3rd roll
    stun_timer: make_timer(90),        // how long hes stunned 
	after_roll_timer: make_timer(60),  // how long he stays idle after stun
    after_roll_bounce_sp: 5.5,
    after_roll_bounce_decrease: 0.8, // the smaller this number the faster Rula stops
	ultra_roll_sfx: SFX_Rularog_Roar,
	wall_hits: 0,
	ultra_roll_done: false,
	rotation_sp: 20,
	rotation_dir: 0,

    make_ultra_roll: function() {
        id.move(hsp, vsp)
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
            }
            if vdir != 0 {
                vdirprev = vdir
                vdir = 0
            } else {
                vdir = -vdirprev	
            }
            wall_hits++
            oCamera.start_shaking(2)
            if wall_hits == 5 {
                ultra_roll_done = true
                id.sprite_index = sRulaKOed
                id.rotation = 0
                // bounce back a bit
                hsp = after_roll_bounce_sp * -hdirprev
            }
            audio_play_sound(global.sfx_rula_hitwall, 3, false)
        }
    },

    wait_after_roll: function() {
        if stun_timer.update() {
			// bounce
            id.move(hsp, 0)
            hsp *= after_roll_bounce_decrease
            return
        }
		sprite_index = sRulaIdle
		if !after_roll_timer.update() {
            change_state = true
        }
    },

	step: function() {
		hsp = approach(hsp, roll_sp * hdir, accel * !roll_delay_timer.update())
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
		hsp = 0
		vsp = 0
		ultra_roll_done = false
        stun_timer.reset()
		after_roll_timer.reset()
		wall_hits = 0
		change_state = false
		hdir = id.setDir()
		vdir = 0
		vdirprev = 1 // next vdir will be -1 -> up
		rotation_dir = -hdir
		id.sprite_index = sRulaRoll
		audio_play_sound(ultra_roll_sfx, 3, false)
        show_debug_message("Roar")
    },

	checkChange: function() {
		if change_state {
			return id.idleState
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
	syster_spirit_timer: make_timer(160),
	syster_spirit_triggered: false,
	screen_shaked: false,

	step: function() {
        // shake screen
		if !screen_shaked {
			oCamera.start_shaking(2)
			screen_shaked = true
			audio_play_sound(global.sfx_BOOM, 3, false)
		}
        // fall until hit the ground
		vsp = approach(vsp, vsp_max, grav)
		id.move(hsp * dir, vsp)
		if id.colliding_wall(id.x + dir, id.y) {
			hsp = 0	
		}
        // after falling and timer running off trigger syster spirit cutscene
		if id.colliding_wall(id.x, id.y + 1) {
			vsp = 0
			id.sprite_index = sRulaDead
			if !syster_spirit_triggered and !syster_spirit_timer.update() {
                oMein.start_boss_end_sequence()
				syster_spirit_triggered = true
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
        // move him up a bit
        // like being pushed
        id.y -= 10
		instance_destroy(oRulaTongueTip)
		instance_destroy(oRulaTongue)
		oPause.PauseWithTimer(pause_time)
        oMusic.stop(0)
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

function checkStateChangePhase2() {
	// check if must switch to phase 2
	// Rula can switch from any state
	if !done_phase2_roar and isPhase2() {
		return roarState
	}
	return undefined
}

function isPhase2() {
	return hp <= hp_phase2_amount
}

function ifPhase2(state) {
	// if in phase 2 choose state
	// otherwise choose default state - idleState
	return isPhase2() ? state : id.idleState
}

function setDir(dir=undefined) {
	image_xscale = dir ?? (x > room_center_x ? -1 : 1)
	return image_xscale
}


state = tongueAttackState

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
	player_move_coord_contact_obj(hsp, vsp, oWall)
}

function isDead() {
	return state == deadState
}










