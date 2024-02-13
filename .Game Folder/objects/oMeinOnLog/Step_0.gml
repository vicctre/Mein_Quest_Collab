
if oPause.paused
	exit

key_left_pressed = oInput.key_left_pressed * has_control
key_right_pressed = oInput.key_right_pressed * has_control
key_up_pressed = oInput.key_up_pressed * has_control
key_left = oInput.key_left * has_control
key_right = oInput.key_right * has_control
key_down = oInput.key_down * has_control
key_jump = oInput.key_jump * has_control
key_attack = oInput.key_attack * has_control

var inside_wall = place_meeting(x, y, oWall)
was_down_free = down_free
down_free = inside_wall or place_empty(x, y + 1, wall_obj)
up_free = inside_wall or place_empty(x, y - 1, wall_obj)
//left_free = place_empty(x - 1, y, wall_obj)
right_free = place_empty(x + 1, y, wall_obj)
was_floating = is_floating
is_floating = (y >= bottom_bound_y)

var just_water_landed = (is_floating and !was_floating)
var just_landed = (!down_free and was_down_free)

if has_control {

	if just_water_landed {
		audio_play_sound(global.sfx_log_ride_landing, 0, false)
	}

	if just_landed or just_water_landed {
		sprite_index = sMeinLogRide
		image_index = 0
	}

	check_spikes()

	jump_timer--

	if y < bottom_bound_y {
		vsp += grav * down_free
	} else if y > bottom_bound_y
			// water doesn't affect vsp shortly after jump
			and !jump_timer {
		var diff = abs(y - bottom_bound_y)
		if vsp > 0 {
			vsp -= diff * 0.06
		} else {
			vsp = -diff * 0.1
			// negate vsp if near the floating 
			if abs(vsp) < 0.1 {
				vsp = 0
				y = bottom_bound_y
			}
		}
	}

	// hit ceil
	if ((vsp < 0) and !up_free) {
		vsp = 0
	}
	// land on ground
	else if !down_free {
		if vsp > 0
			vsp = 0
	}

	if !down_free or is_floating {
		if key_jump {
			vsp = jump_sp
			jump_timer = 5
			sprite_index = sMeinLogRideJump
			image_index = 0
			audio_play_sound(global.sfx_jump, 0, false)
		}
	}

	if !right_free and !is_dead() {
		Hit()
	}

	var enemy = colliding_enemy()
	if enemy {
		Hit()
	}

	if !inside_wall and vsp != 0 {
		scr_move_coord_contact_obj(0, vsp, wall_obj)
	} else {
		y += vsp
	}

	x += hsp
	if inside_wall {
		Hit()
	}

	if x > room_width {
		SlideTransition(TRANS_MODE.NEXT)
	}
}

if death_delay_timer and !--death_delay_timer {
	visible = false
	create_death_animation()
	oMusic.switch_music(global.msc_player_dead, false, 0)
}

invincibility_timer_no_flashing--
