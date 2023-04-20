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

function scr_move_coord_contact_glide(hsp, vsp, obj) {
	x += hsp
	//collision
	var dir = point_direction(0, 0, hsp, vsp)
	while place_meeting(x, y, obj) {
		x -= lengthdir_x(1, dir)
	}
	y += vsp
	while place_meeting(x, y, obj) {
		y -= lengthdir_y(1, dir)
	}
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

function scr_move_coord_contact_obj_v2(hsp, vsp, obj) {
	scr_move_coord(hsp, vsp)
	//collision
	var contact = instance_place(x, y, obj)
	if contact  {
		// compute relative movement
		var relhsp = hsp - contact.hsp
		var relvsp = vsp - contact.vsp
		var reldir = point_direction(0, 0, relhsp, relvsp)
		// move out of an object
		while place_meeting(x, y, contact) {
	        x -= lengthdir_x(1, reldir)
	        y -= lengthdir_y(1, reldir)
		}
		return contact
	}
	return noone
}

function scr_move_contact_obj(sp, dir, obj) {
	scr_move(sp, dir)
	//collision
	var contact = instance_place(x, y, obj)
	if contact {
		// move out of an object
		while place_meeting(x, y, contact) {
	        x -= lengthdir_x(1, dir)
	        y -= lengthdir_y(1, dir)
		}
	}
}
