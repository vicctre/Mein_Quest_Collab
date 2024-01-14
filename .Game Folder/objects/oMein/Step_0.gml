
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

//timer for idle animations
if (sprite_index == sPlayer || sprite_index == currentIdleAnimation) {
	idle_time++;
} else {
	idle_time = 0;
}

// contact walls
var thin_platform = thin_platform_check(0, 1);
if thin_platform 
		and thin_platform.object_index != oAutoscrollerLog
		and key_down {
	thin_platform = noone
}
down_free = place_empty(x, y + 1, wall_obj) and !thin_platform;
up_free = place_empty(x, y - 1, wall_obj)
left_free = place_empty(x - 1, y, wall_obj)
right_free = place_empty(x + 1, y, wall_obj)

// can we move hor?
move_h = (key_right*right_free - key_left*left_free) * has_control
// do we try to move?
input_move_h = key_right - key_left
// moving hor
hsp_to = move_h * hsp_max

if has_control {
	// used to fake ground for smoother jumping
	on_ground--
	if !down_free
		on_ground = on_ground_delay

	// enemies
	var enemy = colliding_enemy()
	var attack = instance_place(x, y, ENEMYATTACK)
	if enemy != noone or attack != noone {
		Hit()
		if state == PLAYERSTATE.ATTACK_AERAL and instance_exists(aeral_attack_inst) {
			instance_destroy(aeral_attack_inst)
			aeral_attack_finish()
		}
	}

	// enter door
	var door = instance_place(x, y, oDoor)
	if state != PLAYERSTATE.ENTER_DOOR and !down_free and key_up_pressed and door {
		state = PLAYERSTATE.ENTER_DOOR
		enter_room = door.room_to_go
		sprite_index = sPlayerEnterDoor
		audio_play_sound(global.sfx_door, 6, false)
	}
}

var is_accelerating = sign(hsp) == 0 or sign(hsp) == sign(hsp_to)
hsp = approach(hsp, hsp_to * (1 + is_sprinting*sprint_add_sp_gain), is_accelerating ? acc : decel)
vsp = approach(vsp, vsp_max, grav)

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
			perform_attack(sAttack, image_xscale, 1)
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
			var inst = instance_create_layer(x, y, layer, deadEnemy)
			inst.sprite_index = sPlayerDead
			inst.vsp = global.player_dead_vsp
			inst.hsp = global.player_dead_hsp * -image_xscale
			inst.image_xscale = image_xscale
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
			SlideTransition(TRANS_MODE.GOTO, enter_room)
		}
		hsp = 0
		break
	}
}

// floating on log
// additional hsp will keep untill land on common ground
is_on_log = false
if !down_free {
	if instance_place(x, y + 1, oAutoscrollerLog) != noone {
		ground_hsp = oAutoscrollerLog.hsp
		is_on_log = true
	} else {
		ground_hsp = 0
	}
}

var final_hsp = hsp + ground_hsp

dir = point_direction(0, 0, final_hsp, vsp)

// block hor sp if wall contact
if ((final_hsp > 0) and !right_free) or ((final_hsp < 0) and !left_free) {
	final_hsp = 0
	hsp = 0
}

// handle collisions
if abs(final_hsp) or abs(vsp)
	scr_move_coord_contact_obj(final_hsp, vsp, wall_obj)

if global.camera_solid_bounds_on and !autoscroller_workaround_delay-- {
	var xmax = scr_camx(0) + scr_camw(0) - (bbox_right- x)
	var xmin = scr_camx(0) + (x - bbox_left)
	//var ymax = scr_camy(0) + scr_camh(0) - (bbox_bottom - y)
	//var ymin = scr_camy(0) + (y - bbox_top)
	x = clamp(x, xmin, xmax)
	//y = clamp(y, ymin, ymax)
}

Animate()

// fall out of world
if (global.player_hp > 0 && bbox_bottom > room_height) {
	// imitate regular death to trigger all needed stuff
	global.player_hp = 1
	Hit()
}