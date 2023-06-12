
//// Debug
if keyboard_check_pressed(ord("Q")) {
	room_speed = room_speed == 60 ? 5 : 60
}

if has_control {
	key_left_pressed = keyboard_check_pressed(vk_left) or keyboard_check_pressed(ord("A"))
	key_right_pressed = keyboard_check_pressed(vk_right) or keyboard_check_pressed(ord("D"))
	key_up_pressed = keyboard_check_pressed(vk_up) or keyboard_check_pressed(ord("W")) 
	key_down_pressed = keyboard_check_pressed(vk_down) or keyboard_check_pressed(ord("S"))
	key_down = keyboard_check(vk_down) or keyboard_check(ord("S"))
	key_left = keyboard_check(vk_left) or keyboard_check(ord("A"))
	key_right = keyboard_check(vk_right) or keyboard_check(ord("D"))
	key_jump = keyboard_check_pressed(vk_space) 
			   or keyboard_check_pressed(ord("W"))
			   or gamepad_button_check_pressed(0, gp_face1)
	//key_down = keyboard_check_pressed(vk_down) or keyboard_check(ord("S"))
	key_attack = keyboard_check_pressed(ord("X"))
	
	var gp_hinp = gamepad_axis_value(0, gp_axislh)
	if abs(gp_hinp) > gp_hinp_treshold {
		key_left = abs(min(gp_hinp, 0))
		key_right = max(gp_hinp, 0)
	}

} else {
	key_left = false
	key_right = false
	key_jump = false
	//key_down = false
	key_attack = false
}

prev_is_sprinting = is_sprinting
prev_down_free = down_free

// contact walls
down_free = place_empty(x, y + 1, wall_obj) && !thin_platform_check(0, 1);
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
	var enemy = instance_place(x, y, ENEMY)
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
	if !down_free and key_up_pressed and door {
		state = PLAYERSTATE.ENTER_DOOR
		enter_room = door.room_to_go
		sprite_index = sPlayerEnterDoor
		audio_play_sound(SFX_Door, 6, false)
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
			image_xscale = input_move_h	
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
	case PLAYERSTATE.DEAD: {
		hsp = 0
		vsp = 0
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

// block hor sp if wall contact
if ((hsp > 0) and !right_free) or ((hsp < 0) and !left_free)
	hsp = 0

dir = point_direction(0, 0, hsp, vsp)

// handle collisions
if abs(hsp) or abs(vsp)
	scr_move_coord_contact_obj(hsp, vsp, wall_obj)

Animate()

//fall out of world
if (global.player_hp > 0 && bbox_bottom > room_height) {
	Kill();
}