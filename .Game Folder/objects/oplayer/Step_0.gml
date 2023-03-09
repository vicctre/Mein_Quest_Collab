
//// Debug
if keyboard_check_pressed(ord("Q")) {
	room_speed = room_speed == 60 ? 5 : 60
}

if has_control {
	key_left_pressed = keyboard_check_pressed(vk_left) or keyboard_check_pressed(ord("A"))
	key_right_pressed = keyboard_check_pressed(vk_right) or keyboard_check_pressed(ord("D"))
	key_up_pressed = keyboard_check_pressed(vk_up) or keyboard_check_pressed(ord("W"))
	key_down_pressed = keyboard_check_pressed(vk_down) or keyboard_check_pressed(ord("S"))
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

// contact walls
up_free = place_empty(x, y - 1, wall_obj)
down_free = place_empty(x, y + 1, wall_obj)
left_free = place_empty(x - 1, y, wall_obj)
right_free = place_empty(x + 1, y, wall_obj)

// can we move hor?
move_h = (key_right*right_free - key_left*left_free) * has_control
// do we try to move?
input_move_h = key_right - key_left
// moving hor
hsp_to = move_h * hsp_max

if has_control {

	attack_pause_timer--
	if key_attack and !attack_pause_timer {
		image_index = 0
		if !down_free {
			state = PLAYERSTATE.ATTACK_SLASH
			sprite_index = sPlayerAttack
			audio_play_sound(SFX_AttackWiff,5,false)
			attack_pause_timer = attack_pause_time
		} else if !aeral_attack_used {
			state = PLAYERSTATE.ATTACK_AERAL
			sprite_index = sPlayerAttackAeral
			aeral_attack_timer = aeral_attack_time
			perform_attack(sAttackCirlce, 1, 1)
			audio_play_sound(SFX_AttackWiff,5,false)
			attack_pause_timer = attack_pause_time
			aeral_attack_used = true
		}
	}

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

	// reset on_wall
	on_wall = false

	// used to fake ground for smoother jumping
	on_ground--

	if !down_free
		on_ground = on_ground_delay

	// on wall
	if ((!right_free and key_right) 
			or (!left_free and key_left)) 
			and abs(input_move_h)
			and wall_jump_on
		on_wall = true

	// jumping
	if key_jump
		jump_pressed = jump_press_delay

	if jump_pressed {
		jump_pressed--
		// wall jump
		if on_wall {
			jumps = jumps_max
			jump_pressed = 0
			vsp = jump_sp
			hsp = -input_move_h * hsp_max
		}
		// ordinary jump
		else if jumps {
			vsp = jump_sp
			jumps -= down_free and !on_ground
			jump_pressed = 0
		}
	}

	// enemies
	var enemy = instance_place(x, y, ENEMY)
	if enemy != noone {
		Hit()
	}

	// enter door
	var door = instance_place(x, y, oDoor)
	if key_up_pressed and door {
		if has_control {
			has_control = false; 
			SlideTransition(TRANS_MODE.GOTO, door.target); 
		}
	}

}

hsp = approach(hsp, hsp_to * (1 + is_sprinting), acc)
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
		vsp = 0
		hsp = 0
		image_draw_angle += aeral_attack_spin_sp
		if !aeral_attack_timer-- {
			state = PLAYERSTATE.FREE
			sprite_index = sPlayerFalling
			image_draw_angle = 0
		}
		break
	}
	case PLAYERSTATE.DEAD: {
		if !down_free and !alarm[1] and oTransition.IsOff() {
			alarm[1] = 60
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
}

// block hor sp if wall contact
if ((hsp > 0) and !right_free) or ((hsp < 0) and !left_free)
	hsp = 0

dir = point_direction(0, 0, hsp, vsp)

// handle collisions
if abs(hsp) or abs(vsp)
	scr_move_coord_contact_obj(hsp, vsp, wall_obj)

scr_camera_set_pos(0, x, y)

Animate()
