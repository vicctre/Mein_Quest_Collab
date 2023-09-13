
enum PLAYERSTATE {
	FREE,
	CROUCH,
	PUSHING,
	ATTACK_SLASH,
	ATTACK_COMBO,
	ATTACK_AERAL,
	PRE_DEAD,
	DEAD,
	HIT,
	ENTER_DOOR,
}

scr_debug_ini()
global.VAR_BAR_ROW_DELTA = 30

/// main parameters
// hp - see global.player_hp
hsp_max = 2.5
vsp_max = 6
acc = global.player_accel
decel = global.player_decel
grav = 0.3
jump_sp = -7
double_jump_sp = -6
hsp_to = 0	// how sp_x and sp_y change
hsp = 0
vsp = 0
dir = 0
move_h = 0

rm_sp_min = 5

jumps_max = 1
jumps = jumps_max
jump_press_delay = 15
jump_pressed = 0
on_ground_delay = 10
on_ground = 0 // used to fake ground for smoother jumping

wall_obj = oWall

gp_hinp_treshold = 0.2

has_control = true
state = PLAYERSTATE.FREE

// attacks
attack_pause_time = 15
attack_pause_timer = 0
attack_perform_frame = 2
attack_performed = false
list_hit_by_attack = ds_list_create()

up_free = false
left_free = false
right_free = false
down_free = false
// landing detection
prev_down_free = false

// aeral attack
aeral_attack_spin_sp = 30
aeral_attack_time = 10
aeral_attack_timer = 0
aeral_attack_used = false
image_draw_angle = 0
aeral_attack_inst = noone

is_sprinting = false
prev_is_sprinting = false
sprint_double_press_time = 0.5 * room_speed
sprint_double_press_timer = 0
sprint_last_pressed_dir = 0
sprint_add_sp_gain = 0.5

invincibility_time = global.player_invincibilty_time
invincibility_timer = 0
invincibility_blinking_gain = 14

death_animation_started = false

// hit state
hit = {
	vsp: -4,
	hsp: 4,
	time: 20,
	timer: 0
}

// room transition
enter_room = noone


// create player-related ui
instance_create_layer(0, 0, "ui", oUI)

function start_crouch_transition(reverse = false) {
	sprite_index = sCrouchTransition
	image_index = reverse ? (image_number - 1) : 0
}

function animate_crouch_transition(sprite_to, img_sp) {
	if sprite_index == sCrouchTransition {
		image_speed = img_sp
		if is_animation_end() {
			sprite_index = sprite_to
			// transition finished
			return false
		}
		return true
	}
	return false
}

function check_perform_jump() {
	if key_jump
		jump_pressed = jump_press_delay
		
	if jump_pressed {
		jump_pressed--
		if jumps {
			jumps -= down_free and !on_ground
			vsp = jumps ? jump_sp : double_jump_sp
			if jumps 
				audio_play_sound(global.sfx_jump, 7, false)
			else
				audio_play_sound(global.sfx_djump, 7, false)
			jump_pressed = 0
            state = PLAYERSTATE.FREE
            return true
		}
	}
    return false
}
function check_perform_sprint() {
	sprint_double_press_timer--
	if sprint_double_press_timer == 0 {
		sprint_last_pressed_dir = 0
	}
	var _sprint_press_dir = key_right_pressed - key_left_pressed
	if !is_sprinting {
		if (key_left_pressed or key_right_pressed) 
				and sprint_last_pressed_dir == _sprint_press_dir
				and !down_free {
			is_sprinting = true
		}
	} else {
		if move_h == 0 {
			is_sprinting = false
		}
	}
	if _sprint_press_dir != 0 {
		sprint_double_press_timer = sprint_double_press_time
		sprint_last_pressed_dir = _sprint_press_dir
	}
    return is_sprinting
}
function check_perform_crouch() {
	if key_down and !down_free and state != PLAYERSTATE.CROUCH {
		state = PLAYERSTATE.CROUCH
		mask_index = sCrouch
		start_crouch_transition()
		audio_play_sound(global.sfx_crouch, 5, false);
        return true
	}
    return false
}
function check_perform_push() {
	if !down_free and state != PLAYERSTATE.ATTACK_SLASH
			and (key_right and !right_free
				 or key_left and !left_free) {
		state = PLAYERSTATE.PUSHING
		sprite_index = sPush
        return true
	}
    return false
}

function check_perform_attack() {
	attack_pause_timer--
	if key_attack and !attack_pause_timer {
		image_index = 0
		if !down_free {
			state = PLAYERSTATE.ATTACK_SLASH
			sprite_index = sPlayerAttack
			audio_play_sound(SFX_AttackWiff,5,false)
			attack_pause_timer = attack_pause_time
            return true
		}
        if !aeral_attack_used {
			state = PLAYERSTATE.ATTACK_AERAL
			sprite_index = sPlayerAttackAeral
			aeral_attack_timer = aeral_attack_time
			aeral_attack_inst = perform_attack(sAttackCirlce, 1, 1, false)
			audio_play_sound(SFX_AttackWiff,5,false)
			attack_pause_timer = attack_pause_time
			aeral_attack_used = true
            return true
		}
	}
    return false
}

function check_spikes() {
	var spike = instance_place(x, y, oSpikes)
	if spike != noone {
		Hit()
	}
}

function Animate() {
	image_speed = 1
	switch state {
		case PLAYERSTATE.FREE: {
			if animate_crouch_transition(sPlayer, -1) {
				break	
			}
			animate_update_xscale()
			if down_free {
				if vsp < 0 {
					if jumps {
						sprite_index = sPlayerJump
					} else {
						sprite_index = sPlayerDoubleJump
						if is_animation_end() {
							image_speed = 0	
						}
					}
				} else {
					if jumps {
						sprite_index = sPlayerFalling
					} else {
						sprite_index = sPlayerFallDj
					}
				}
				break
			}
			if abs(hsp) {
				if is_sprinting {
					sprite_index = sRun
				} else {
					sprite_index = sPlayerW
				}
			} else {
				sprite_index = sPlayer	
			}
			break
		}
		case PLAYERSTATE.ATTACK_SLASH: {
			break
		}
		case PLAYERSTATE.ATTACK_COMBO: {
			break
		}
		case PLAYERSTATE.DEAD: {
			break
		}
		case PLAYERSTATE.HIT: {
			break
		}
		case PLAYERSTATE.ENTER_DOOR: {
			image_speed = global.player_door_enter_anim_sp
			if is_animation_end() {
				image_speed = 0
			}
			break
		}
		case PLAYERSTATE.CROUCH: {
			if !animate_crouch_transition(sCrouch, 1) {
				sprite_index = sCrouch
			}
			break
		}
	}
}

function Kill() {
	show_debug_message("Kill")
	global.player_hp = 0;
	sprite_index = sPlayerDead
	state = PLAYERSTATE.PRE_DEAD
	has_control = false
	hsp = 0
	//y -= 30
	//visible = false
	oMusic.switch_music(noone, false, 0)
	oPause.PauseWithTimer(global.death_pause_time)
	oUI.shake_hp()
}

function Hit() {
	if invincibility_timer {
		return;
	}
	global.player_hp -= global.player_invincible == false
	show_debug_message("Hit")
	audio_play_sound(global.sfx_player_damage, 8, false);
	//this is for when we have both a voice AND SFX for taking damage 
	if !global.player_hp {
		Kill()
		return;
	}
	vsp = hit.vsp
	hsp = hit.hsp * -image_xscale
	has_control = false
	hit.timer = hit.time
	state = PLAYERSTATE.HIT
	sprite_index = sPlayerDamage
	invincibility_timer = invincibility_time
	oUI.shake_hp()
}

function animate_update_xscale() {
	if hsp != 0 {
		image_xscale = sign(hsp)
	}
}

function draw_invincibility_blinking() {
	var alpha = 0.5 - lengthdir_x(
		0.5, invincibility_blinking_gain * invincibility_timer)
	gpu_set_fog(true, global.player_damage_blinking_color, 0, 0)
	draw_sprite_ext(
		sprite_index,
		image_index,
		x, y,
		image_xscale, image_yscale,
		0, c_white, alpha)
	gpu_set_fog(false, global.player_damage_blinking_color, 0, 0)
}

function aeral_attack_finish() {
	state = PLAYERSTATE.FREE
	sprite_index = sPlayerFalling
	image_draw_angle = 0
	attack_performed = false
	instance_destroy(aeral_attack_inst)
}

function check_reset_hp() {
	if room == W1_1_part1 {
		global.player_hp = global.player_hp_max	
	}
}

function check_just_landed() {
	return !down_free and prev_down_free
}

function check_sprint_started() {
	return !prev_is_sprinting and is_sprinting
}

_dust_yoffset = -sprite_get_height(sDust) + sprite_get_yoffset(sDust)
function dust_effect() {
	oEffects.emit_dust(
		x, bbox_bottom + _dust_yoffset)
}

function sprint_effect() {
	oEffects.emit_sprint_dust(x, bbox_bottom + _dust_yoffset, -input_move_h)
}

function should_play_onto_stage_sequence() {
	return array_contains(global.rooms_with_onto_stage_seq, room)
}

function play_onto_stage_sequence() {
	visible = false
	has_control = false
	instance_create_layer(x, y, layer, oSequenceOntoLevel)
}

instance_create_layer(x, y, layer, oCamera)
check_reset_hp()

if should_play_onto_stage_sequence() {
	play_onto_stage_sequence()
}
