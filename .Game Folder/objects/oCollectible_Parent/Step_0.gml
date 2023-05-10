if (activated) {
	activation_delay = max(0, activation_delay - 1);
	exit;
}

vspd += grav;
if (place_meeting(x, y+vspd, oWall)) {
	while(!place_meeting(x, y+sign(vspd), oWall)) {
		y += sign(vspd);
	}
	if (vspd > 0)
		activated = true;
	vspd = 0;
}
y += vspd;