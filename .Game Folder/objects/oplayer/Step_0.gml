
key_left = keyboard_check(vk_left) or keyboard_check(ord("A"))
key_right = keyboard_check(vk_right) or keyboard_check(ord("D"))
key_jump = keyboard_check_pressed(vk_space) or keyboard_check_pressed(ord("Z"))

// contact walls
up_free = place_empty(x, y - 1, wall_obj)
down_free = place_empty(x, y + 1, wall_obj)
left_free = place_empty(x - 1, y, wall_obj)
right_free = place_empty(x + 1, y, wall_obj)

// can we move hor?
move_h = key_right*right_free - key_left*left_free

// do we try to move?
input_move_h = key_right - key_left

// moving hor
hsp_to = move_h * hsp_max

hsp = approach(hsp, hsp_to, acc)
vsp = approach(vsp, vsp_max, grav)

// reset on_wall
on_wall = false

// used to fake ground for smoother jumping
on_ground--

if !down_free
	on_ground = on_ground_delay

// on wall
if ((!right_free and key_right) or (!left_free and key_left)) and abs(input_move_h)
	on_wall = true

// handle vertical sp
// hit ceil
if ((vsp < 0) and !up_free) {
	vsp = 0
}

// reset jumps if on ground
else if !down_free {
	jumps = jumps_max
	// land on ground
	if vsp > 0
		vsp = 0
}

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

// block hor sp if wall contact
if ((hsp > 0) and !right_free) or ((hsp < 0) and !left_free)
	hsp = 0

dir = point_direction(0, 0, hsp, vsp)

// handle collisions
if abs(hsp) or abs(vsp)
	scr_move_coord_contact_obj(hsp, vsp, wall_obj)

scr_camera_set_pos(0, x, y)
