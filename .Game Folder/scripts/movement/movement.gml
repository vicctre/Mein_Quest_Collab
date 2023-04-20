///@arg speed
///@arg dir
function scr_move(sp, dir) {
	x += lengthdir_x(sp, dir)
	y += lengthdir_y(sp, dir)
}

function scr_move_coord(hsp, vsp) {
	x += hsp
	y += vsp
}

function scr_move_coord_contact_obj(hsp, vsp, obj) {
	if place_meeting(x + hsp, y + vsp, obj)  {
		// move out of an object
		var dir = point_direction(0, 0, hsp, vsp)
		var dx = lengthdir_x(1, dir)
		var dy = lengthdir_y(1, dir)
		var contact
		while true {
			contact = instance_place(x + dx, y + dy, obj)
			if contact == noone {
		        x += dx
		        y += dy
			} else {
				break
			}
		}
		return contact
	}
	scr_move_coord(hsp, vsp)
	return noone
}
