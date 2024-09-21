if (activated) {
	activation_delay = max(0, activation_delay - 1);
	exit;
}

vspd += grav;
if (place_meeting(x, y+vspd, WALLPARENT)) {
	while(!place_meeting(x, y+sign(vspd), WALLPARENT)) {
		y += sign(vspd);
	}
	if (vspd > 0) {
		activated = true;
		flashing = true;
	}
	vspd = 0;
}
y += vspd;