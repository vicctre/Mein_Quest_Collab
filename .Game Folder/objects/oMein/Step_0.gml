
key_left_pressed = oInput.key_left_pressed * has_control
key_right_pressed = oInput.key_right_pressed * has_control
key_up_pressed = oInput.key_up_pressed * has_control
key_left = oInput.key_left * has_control
key_right = oInput.key_right * has_control
key_down = oInput.key_down * has_control
key_jump = oInput.key_jump * has_control
key_attack = oInput.key_attack * has_control

prev_is_sprinting = is_sprinting
prev_down_free = down_free

updatePlayIdleAnimation()
pogo_cooldown_timer.update()

// contact walls
var thin_platform = checkThinPlatform()
down_free = place_empty(x, y + 1, wall_obj) and !thin_platform;
up_free = place_empty(x, y - 1, wall_obj)
left_free = place_empty(x - 1, y, wall_obj)
right_free = place_empty(x + 1, y, wall_obj)

// can we move hor?
move_h = (key_right*right_free - key_left*left_free) * has_control
// do we try to move?
input_move_h = key_right - key_left


if has_control {
	hsp_to = move_h * hsp_max // moving horizontally
    updateCoyoteTimer()
    checkCollidingEnemy()
    checkEnterDoor()
}

updateHspControl()
applyGravity()

// handle vertical sp
// hit ceil
if ((vsp < 0) and !up_free) {
	vsp = 0
}
// reset jumps if on ground
else if !down_free {
	jumps = jumps_max
	aeral_attack_used = false
	// land on ground
	if vsp > 0
		vsp = 0
}

switch state {
	case PLAYERSTATE.FREE: {
		check_perform_attack()
		check_perform_sprint()
		check_perform_crouch()
		check_perform_push()
		check_perform_jump()
		check_spikes()
		if check_just_landed() {
			audio_play_sound(SFX_Land, 5, false);
			dust_effect()
		}
		if check_sprint_started() {
			sprint_effect()	
		}
		break
	}
	case PLAYERSTATE.CROUCH: {
		hsp = 0
		vsp = 0
		if abs(input_move_h) != 0 {
			image_xscale = sign(input_move_h)	
		}
		if !key_down or down_free {
			state = ENEMYSTATE.FREE
			mask_index = sPlayer
			start_crouch_transition(true)
		}
		break
	}
	case PLAYERSTATE.PUSHING: {
		check_perform_jump()
		check_perform_attack()
		check_perform_crouch()
		if !(key_right and !right_free
				 or key_left and !left_free) {
			state = ENEMYSTATE.FREE
			sprite_index = sPlayer
		}
		break
	}
	case PLAYERSTATE.ATTACK_SLASH: {
		if !down_free {
			hsp = 0
		} else {
			vsp = 0
		}
		if image_index >= attack_perform_frame and !attack_performed {
			perform_attack(sAttack_1, image_xscale, 1)
		}
		if is_animation_end() {
			state = PLAYERSTATE.FREE
			sprite_index = sPlayer
			attack_performed = false
		}
		break
	}
	case PLAYERSTATE.ATTACK_COMBO: {
		break
	}
	case PLAYERSTATE.ATTACK_AERAL: {
		aeral_attack_inst.x = x 
		aeral_attack_inst.y = y
		if abs(hsp) {
			image_xscale = sign(hsp)
		}
		image_draw_angle += aeral_attack_spin_sp * -image_xscale
		if !aeral_attack_timer-- {
			aeral_attack_finish()
		}
		break
	}
	case PLAYERSTATE.ATTACK_POGO: {
        vsp += pogo_accel
        vsp = min(vsp, pogo_vsp_max)
        // switch to pogo falling sprite
        if sprite_index == sPlayer_PogoAttack {
            vsp = (image_index < 6) ? 0 : vsp
            if is_animation_end() {
                sprite_index = sPlayer_Pogo_fall
            }
        }

        pogo_attack_instance.x = x
        // scan for pcut child one pixel down
        // to prevent being stopped by oCrate
        pogo_attack_instance.y = y + 1
        var enemy = pogo_attack_instance.perform()
        if enemy {
            y -= vsp    // prevent enemy collision on next step
            enemy.set_hit(1)
            if object_is_ancestor(enemy.object_index, ENEMY) {
                pogo_bounce()
            }
            break
        }

        if place_meeting(x, y + vsp, oSpikes) {
            pogo_bounce()
            oEffects.emit_attack_contact(x, y + 16)
            break
        }

        if !down_free {
            state = PLAYERSTATE.FREE
            has_control = true            
            vsp = pogo_vsp_bounce * 0.5
            audio_play_sound(global.sfx_pogo_land, 0, false)
            // stay in pogo animation for one more sprite
            animation_stop_update_timer.reset()
        }
		break
	}
	case PLAYERSTATE.PRE_DEAD: {
		state = PLAYERSTATE.DEAD
		break	
	}
	case PLAYERSTATE.DEAD: {
		hsp = 0
		vsp = 0
		// transition
		if !death_animation_started {
			alarm[1] = global.death_transition_delay_time
			create_death_animation()
			visible = false
			death_animation_started = true
			oMusic.switch_music(global.msc_player_dead, false, 0)
		}
		break
	}
	case PLAYERSTATE.HIT: {
		hsp = hit.hsp * -image_xscale
		if !hit.timer-- {
			has_control = true
			state = PLAYERSTATE.FREE
			sprite_index = sPlayer
		}
		break
	}
	case PLAYERSTATE.ENTER_DOOR: {
		if is_animation_end() {
			RoomTransition(TRANS_MODE.GOTO, enter_room, true)
		}
		hsp = 0
		break
	}
	case PLAYERSTATE.GRABBED: {
		if is_ungrabb_allowed {
			state = PLAYERSTATE.FREE
		}
		break
	}
	case PLAYERSTATE.THROWED: {
		vsp = approach(vsp, vsp_max, throw_decel)
		if !allow_exit_throw_delay.update()
				&& !(right_free && left_free && up_free && down_free) {
			state = PLAYERSTATE.FREE
			Hit()
			setHspControl(true)
			has_control = true
		}
		break
	}
	case PLAYERSTATE.BOSS_END_SEQUENCE: {
        if down_free {
            break
        }
        var x_to = room_width * 0.5
        hsp_to = hsp_max * sign(x_to - x)
        if can_finish_boss_sequence() {
            x = x_to
            hsp = 0
			hsp_to = 0
            if room == W1_3BOSS {
                instance_create_layer(x, bbox_bottom, "SysterSpiritCutscene", oSequenceSysterSpirit)
            }
			state = PLAYERSTATE.FREE
        }
		break
	}
}

checkFloatOnLog()
final_hsp = finalizeHsp()


// handle collisions
if abs(final_hsp) or abs(vsp)
	player_move_coord_contact_obj(final_hsp, vsp, wall_obj)

check_zap_platform()

if global.camera_solid_bounds_on
		// without this player will teleport to the beginning
		// because camera is spawn there
		and !--dev_autoscroller_camera_solid_walls_workaround_timer {
	var xmax = camx(0) + camw(0) - (bbox_right- x)
	var xmin = camx(0) + (x - bbox_left)

	// loose if stack between view and walls
	if !right_free and x < xmin {
		Kill()
	}

	x = clamp(x, xmin, xmax)
}

Animate()

// fall out of world
if (global.player_hp > 0 && bbox_bottom > room_height) {
	// imitate regular death to trigger all needed stuff
	global.player_hp = 1
    is_dead_from_pit = true
	Hit(-1000)
}

invincibility_timer_no_flashing.update()
