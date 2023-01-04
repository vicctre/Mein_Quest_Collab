
scr_player_input()

up_free = place_empty(x, y - 1, obj_block)
down_free = place_empty(x, y + 1, obj_block)
left_free = place_empty(x - 1, y, obj_block)
right_free = place_empty(x + 1, y, obj_block)

move_h = key_right*right_free - key_left*left_free

// moving
hsp_to = move_h * hsp_max

hsp = scr_approach(hsp, hsp_to, acc)
vsp = scr_approach(vsp, vsp_max, grav)

vsp += key_jump * !down_free * jump_sp

if ((vsp > 0) and !down_free) or ((vsp < 0) and !up_free) 

	vsp = 0

if ((hsp > 0) and !right_free) or ((hsp < 0) and !left_free)

	hsp = 0

dir = point_direction(0, 0, hsp, vsp)

if abs(hsp) or abs(vsp)

	scr_move_coord_contact_obj(hsp, vsp, obj_block)

scr_camera_set_center(0, x, y)