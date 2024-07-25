if (done == 0)
{
	vsp = vsp + grv; 
	x = x + hsp; 
	y = y + vsp; 
	image_angle += rotation_speed sign(image_xscale);
}

if global.voleyball {
	if place_meeting(x, y, oAttack) {
		vsp = -5
		if abs(global.player.x - x) > 0 {
			hsp *= -sign(global.player.x - x)
		}
	}
}

// need for blinking function
rotation = image_angle

if dead_animation_fly_forward {
	image_xscale += dead_animation_fly_forward_speed * sign(image_xscale)
	image_yscale += dead_animation_fly_forward_speed
}
