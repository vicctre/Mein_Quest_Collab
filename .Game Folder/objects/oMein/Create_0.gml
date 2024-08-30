
enum PLAYERSTATE {
	FREE,
	CROUCH,
	PUSHING,
	ATTACK_SLASH,
	ATTACK_COMBO,
	ATTACK_AERAL,
    ATTACK_POGO,
	PRE_DEAD,
	DEAD,
	HIT,
	ENTER_DOOR,
	GRABBED,
	THROWED,
    SYSTER_SPIRIT,
}

global.player = id
global.VAR_BAR_ROW_DELTA = 30

is_hsp_control_on = true // whether common hsp control code should be run
						 // see step event and updateHspControl()

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
ground_hsp = 0
vsp = 0
dir = 0
move_h = 0
idle_time = 0
idle_delay = 400 //time before idle animation plays
rotation = 0

function choose_idle_animation() {
	currentIdleAnimation = choose(Idle02, Idle03, Idle04, Idle05)
}
function choose_idle_delay() {
	return choose(250, 250, 300, 400)
}
choose_idle_animation()

rm_sp_min = 5

jumps_max = 1
jumps = jumps_max
jump_press_delay = 15
jump_pressed = 0
coyote_timer = make_timer(10)
is_on_log = false

wall_obj = oWall

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

// Pogo attack 
pogo_on = true      // turns pogo ability on/off
pogo_accel = 0.8 // 1 
pogo_vsp_max = 20
var pogo_bounce_height = 32 * 4 // 4 blocks
pogo_vsp_bounce = - sqrt(2 * grav * pogo_bounce_height)
pogo_cooldown_timer = make_timer(30, false)
pogo_attack_instance = instance_create_layer(
    x, y, layer, oAttackSimple, {one_frame: false, sprite_index: sHurtBoxPogo})

invincibility_timer_no_flashing = make_timer(global.player_invincibilty_time, 0)
invincibility_timer = make_timer(global.player_invincibilty_time, 0)
hit_blinking_gain = 14

//// Healing glowing
var glow_waves_count = 2
// glow "phase" is computed as hit_blinking_gain * time
// and alpha = f(phase); f(0) = 0, f(180) = 1, f(360) = 0
var time = 360 * glow_waves_count / hit_blinking_gain
heal_glowing_timer = make_timer(time, 0)

death_animation_started = false

// hit state
hit = global.player_hit_state

// room transition
enter_room = noone

// grabbed state
is_ungrabb_allowed = false

// throwed state
throw_decel = 0.03
allow_exit_throw_delay = make_timer(5)

// Used for keeping Mein in pogo animation for one frame after 
// he hits smth. So after last hit to a boss he's still
// in pogo animation during pause
animation_stop_update_timer = make_timer(2)

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
function create_death_animation() {
	var inst = instance_create_layer(x, y, layer, oDeadEnemy)
	
	inst.sprite_index = sPlayerDead
	inst.vsp = global.player_dead_vsp
	inst.hsp = global.player_dead_hsp * -image_xscale
	inst.image_xscale = image_xscale
}
function check_perform_jump() {
	if key_jump {
		jump_pressed = jump_press_delay
	}

	if jump_pressed {
		jump_pressed--
		if jumps {
			jumps -= down_free and coyote_timer.timer <= 0
			vsp = jumps ? jump_sp : double_jump_sp
			if jumps {
                // first jump
				audio_play_sound(global.sfx_jump, 7, false)
            } else {
                // second jump
				audio_play_sound(global.sfx_djump, 7, false)
            }
			jump_pressed = 0
            state = PLAYERSTATE.FREE
			// cancel coyote jump if pressed jump
			coyote_timer.timer = 0
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
		audio_play_sound(global.sfx_crouch, 5, false)
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
        if oStageManager.mein_pogo_attack_enabled and down_free and key_down and !pogo_cooldown_timer.timer {
            state = PLAYERSTATE.ATTACK_POGO
            sprite_index = sPlayer_PogoAttack
            hsp = 0
			hsp_to = 0
            vsp = 0
            has_control = false
            audio_play_sound(global.sfx_pogo_start, 0, false)
            return true
        }
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
    if animation_stop_update_timer.update() {
        return
    }
	image_speed = 1
	switch state {
        case PLAYERSTATE.SYSTER_SPIRIT:
		case PLAYERSTATE.FREE:
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
				if (idle_time < idle_delay)
					sprite_index = sPlayer
				if (idle_time >= idle_delay && sprite_index == sPlayer && image_index < 1) {
					sprite_index = currentIdleAnimation
					image_index = 0
					idle_delay = choose_idle_delay()
				}
			}
			break
		case PLAYERSTATE.ENTER_DOOR:
			image_speed = global.player_door_enter_anim_sp
			if is_animation_end() {
				image_speed = 0
			}
			break
		case PLAYERSTATE.CROUCH:
			if !animate_crouch_transition(sCrouch, 1) {
				sprite_index = sCrouch
			}
			break
        case PLAYERSTATE.ATTACK_POGO:
            if is_animation_end() {
                image_speed = 0
            }
	}
}

function Kill() {
    if is_dead() {
        return;
    }
	show_debug_message("Kill")
	global.player_hp = 0
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

function Hit(enemy) {
	if is_dead() {
		return	
	}
	if invincibility_timer.timer or invincibility_timer_no_flashing.timer {
		return
	}
	if state == PLAYERSTATE.GRABBED {
		return;
	}
	if state == PLAYERSTATE.ATTACK_AERAL and instance_exists(aeral_attack_inst) {
		instance_destroy(aeral_attack_inst)
		attack_performed = false
	}
	if enemy && enemy.object_index == oRulaTongueTip {
		become_grabbed()
		audio_play_sound(SFX_Grab, 3, false)
		return
	}
	global.player_hp -= global.player_invincible == false
	show_debug_message("Hit")
	audio_play_sound(global.sfx_player_damage, 8, false)
	//this is for when we have both a voice AND SFX for taking damage 
	if !global.player_hp {
		Kill()
		return
	}
	vsp = hit.vsp
	hsp = hit.hsp * -image_xscale
	has_control = false
	hit.timer = hit.time
	state = PLAYERSTATE.HIT
	sprite_index = sPlayerDamage
	invincibility_timer.reset()
	oUI.shake_hp()
}

function animate_update_xscale() {
	if hsp != 0 {
		image_xscale = sign(hsp)
	}
}

function aeral_attack_finish() {
	state = PLAYERSTATE.FREE
	sprite_index = sPlayerFalling
	image_draw_angle = 0
	attack_performed = false
	instance_destroy(aeral_attack_inst)
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

function colliding_enemy() {
	var enemy = instance_place(x, y, ENEMY)
	if enemy and object_is_ancestor(enemy.object_index, ENEMYBOSS)
			and enemy.isDead() {
		return noone
	}
	return enemy
}

function on_death() {
	RoomTransition(TRANS_MODE.RESTART)
	global.restart_level_on_death = true
	global.lose_coins_counter = global.lose_coins_time;
	global.coins = max(0, global.coins - global.lose_coins_punishment)
}

function is_dead() {
	return state == PLAYERSTATE.DEAD
		   or state == PLAYERSTATE.PRE_DEAD
}

function start_log_ride() {
	var yy = oAutoscrollerLog.y - 7
	with instance_create_layer(x, yy, layer, oMeinOnLog) {
		// prevent hitting a pinnik
		go_invincible_without_flashing()
	}
	instance_destroy()
}

function go_invincible_without_flashing() {
	invincibility_timer_no_flashing.reset()
}

function become_grabbed() {
	state = PLAYERSTATE.GRABBED
	sprite_index = sPlayerDead
	is_ungrabb_allowed = false
	has_control = false
    hsp = 0
	hsp_to = 0
    vsp = 0
}

function allow_ungrabbing() {
	is_ungrabb_allowed = true
}

function is_grabbed() {
	return state == PLAYERSTATE.GRABBED
}

function become_throwed(throw_hsp, throw_vsp, delay=5) {
	setHspControl(false)
	hsp = throw_hsp
	vsp = throw_vsp
	state = PLAYERSTATE.THROWED
	sprite_index = sPlayerDead
	has_control = false
	allow_exit_throw_delay.time = delay
	allow_exit_throw_delay.reset()
}

function updatePlayIdleAnimation() {
	if (sprite_index == sPlayer || sprite_index == currentIdleAnimation) {
		idle_time++;
	} else {
		idle_time = 0;
	}
}

function checkThinPlatform() {
	var thin_platform = thin_platform_check(0, 1);
	if thin_platform 
			and thin_platform.object_index != oAutoscrollerLog
			and key_down {
		return noone
	}
	return thin_platform
}

function updateCoyoteTimer() {
	// used to fake ground for smoother jumping
	coyote_timer.update()
	if !down_free
		coyote_timer.reset()
}

function checkCollidingEnemy() {
	var enemy = colliding_enemy()
	var attack = instance_place(x, y, ENEMYATTACK)
	if enemy != noone or attack != noone {
		Hit(enemy)
		// force finish airal attack
		if !invincibility_timer and state == PLAYERSTATE.ATTACK_AERAL
				and instance_exists(aeral_attack_inst) {
			instance_destroy(aeral_attack_inst)
			attack_performed = false
			aeral_attack_finish()
		}
	}	
}

function checkEnterDoor() {
	var door = instance_place(x, y, oDoor)
	if state != PLAYERSTATE.ENTER_DOOR and !down_free and key_up_pressed and door {
		state = PLAYERSTATE.ENTER_DOOR
		enter_room = door.room_to_go
		sprite_index = sPlayerEnterDoor
		audio_play_sound(global.sfx_door, 6, false)
	}
}

function setHspControl(value) {
	is_hsp_control_on = value
}

function updateHspControl() {
	if is_hsp_control_on {
		var is_accelerating = sign(hsp) == 0 or sign(hsp) == sign(hsp_to)
		hsp = approach(hsp, hsp_to * (1 + is_sprinting*sprint_add_sp_gain), is_accelerating ? acc : decel)
	}
}

function applyGravity() {
	vsp = approach(vsp, vsp_max, grav)
}

function checkFloatOnLog() {
    // floating on log
	// additional hsp will keep untill land on common ground
	is_on_log = false
    if state == PLAYERSTATE.ATTACK_POGO {
        ground_hsp = 0
        return
    }
	if !down_free {
		if instance_place(x, y + 1, oAutoscrollerLog) != noone {
			ground_hsp = oAutoscrollerLog.hsp
			is_on_log = true
		} else {
			ground_hsp = 0
		}
	}
}

function finalizeHsp() {
	var final_hsp = hsp + ground_hsp
	dir = point_direction(0, 0, final_hsp, vsp)
	// block hor sp if wall contact
	if ((final_hsp > 0) and !right_free) or ((final_hsp < 0) and !left_free) {
		final_hsp = 0
		hsp = 0
	}
	return final_hsp
}

function heal(amount) {
	if global.player_hp < global.player_hp_max {
		global.player_hp = min(global.player_hp_max, global.player_hp+amount)
	}
    heal_glowing_timer.reset()
}


function perform_attack(spr, xscale, dmg, one_frame=true) {
	var inst = instance_create_layer(x, y, "Player", oAttack, 
		{sprite_index: spr, image_xscale: xscale, damage: dmg, one_frame: one_frame})
	attack_performed = true
	return inst
}

function pogo_bounce() {
    pogo_cooldown_timer.reset()
    state = PLAYERSTATE.FREE
    has_control = true
    vsp = pogo_vsp_bounce
    jumps = 1       // reset d-jump
    aeral_attack_used = false   // reset aeral attack
    audio_play_sound(global.sfx_pogo_bounce, 0, false)
    animation_stop_update_timer.reset()
}

function switch_to_sister_spirit() {
    state = PLAYERSTATE.SYSTER_SPIRIT
	has_control = false
}


instance_create_layer(x, y, layer, oCamera)

if should_play_onto_stage_sequence() {
	play_onto_stage_sequence()
}

dev_autoscroller_camera_solid_walls_workaround_timer = 3

dev_override()
