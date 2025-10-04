if (activated) {
	activation_delay = max(0, activation_delay - 1);
	exit;
}

vspd += grav;
if (place_meeting(x, y+vspd, oWallParent)) {
	while(!place_meeting(x, y+sign(vspd), oWallParent)) {
		y += sign(vspd);
	}
	if (vspd > 0) {
		activated = true;
		flashing = true;
	}
	vspd = 0;
}
y += vspd;