if (done == 0)
{
	vsp = vsp + grv; 
	x = x + hsp; 
	y = y + vsp; 
	image_angle += image_xscale*rotation_speed;
}

if global.voleyball {
	if place_meeting(x, y, oAttack) {
		vsp = -5
		if abs(global.player.x - x) > 0 {
			hsp *= -sign(global.player.x - x)
		}
	}
}
