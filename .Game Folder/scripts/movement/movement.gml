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
	var contact_normal = place_meeting(x + hsp, y + vsp, obj);
	var contact_thin = thin_platform_check(hsp, vsp);
	if contact_normal || contact_thin {
		// move out of an object
		var dir = point_direction(0, 0, hsp, vsp)
		var dx = lengthdir_x(1, dir)
		var dy = lengthdir_y(1, dir)
		var contact
		while true {
			contact = instance_place(x + dx, y + dy, obj)
			contact_thin = thin_platform_check(dx, dy);
			if contact == noone && contact_thin == noone {
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

function thin_platform_check(hsp, vsp) {
	var contact_thin = instance_place(x + hsp, y + vsp, oThinPlatform);
	if (contact_thin == noone
		|| contact_thin.bbox_top < bbox_bottom
		|| place_meeting(x, y, contact_thin)
		|| (contact_thin.object_index == oThinPlatform and key_down))
		return noone;
	return contact_thin;
}