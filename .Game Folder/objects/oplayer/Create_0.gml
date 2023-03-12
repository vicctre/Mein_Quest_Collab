
event_inherited()

enum PLAYERSTATE {
	FREE,
	CROUCH,
	PUSHING,
	ATTACK_SLASH,
	ATTACK_COMBO,
	ATTACK_AERAL,
	DEAD,
	HIT,
	ENTER_DOOR,
}

scr_debug_ini()
global.VAR_BAR_ROW_DELTA = 30

/// main parameters
hp_max = 4
hp = hp_max
hsp_max = 3
vsp_max = 7
acc = 1.1
grav = 0.3
jump_sp = -7
double_jump_sp = -6
hsp_to = 0	// how sp_x and sp_y change
hsp = 0
vsp = 0
dir = 0
move_h = 0

rm_sp_min = 5
rm_sp_max = 60

jumps_max = 1
jumps = jumps_max
jump_press_delay = 15
jump_pressed = 0
on_ground_delay = 10
on_ground = 0 // used to fake ground for smoother jumping
on_wall = false
wall_jump_on = false

wall_obj = oWall

gp_hinp = 0
gp_hinp_treshold = 0.2

has_control = true
state = PLAYERSTATE.FREE


// attacks
attack_pause_time = 15
attack_pause_timer = 0
attack_perform_frame = 2
attack_performed = false
list_hit_by_attack = ds_list_create()

// aeral attack
aeral_attack_spin_sp = 30
aeral_attack_time = 10
aeral_attack_timer = 0
aeral_attack_used = false
image_draw_angle = 0
aeral_attack_inst = noone

is_sprinting = false
sprint_double_press_time = 0.5 * room_speed
sprint_double_press_timer = 0
sprint_last_pressed_dir = 0

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

function Animate() {
	image_speed = 1
	switch state {
		case PLAYERSTATE.FREE: {
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
					sprite_index = sMeinSprint
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
			if is_animation_end() {
				image_speed = 0
			}
			break
		}
		case PLAYERSTATE.CROUCH: {
			sprite_index = sCrouch
			break
		}
	}
}

function Kill() {
	sprite_index = sPlayerDead
	state = PLAYERSTATE.DEAD
	has_control = false
	hsp = 0
	//y -= 30
	game_set_speed(30, gamespeed_fps)
	var inst = instance_create_layer(x, y, layer, deadEnemy)
	inst.sprite_index = sPlayerDead
	inst.vsp = global.player_dead_vsp
	inst.hsp = global.player_dead_hsp * -image_xscale
	visible = false
	// transition
	alarm[1] = 60
}

function Hit() {
	hp -= PLAYER_INVINCIBLE == false
	if !hp {
		Kill()
		return;
	}
	vsp = hit.vsp
	hsp = hit.hsp * -image_xscale
	has_control = false
	hit.timer = hit.time
	state = PLAYERSTATE.HIT
	sprite_index = sPlayerDamage
}

function animate_update_xscale() {
	if hsp != 0 {
		image_xscale = sign(hsp)
	}
}

instance_create_layer(x, y, layer, oCamera)
